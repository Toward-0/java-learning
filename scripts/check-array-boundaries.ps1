# [C] Codex 补充的边界数据和验证脚本，不是本人新增练习或复测。
# 只在临时源码副本中换数组；算法、打印逻辑仍使用仓库里的原代码。
$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$utf8 = [System.Text.UTF8Encoding]::new($false)
[Console]::OutputEncoding = $utf8
$OutputEncoding = $utf8
$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('java-array-check-' + [guid]::NewGuid().ToString('N'))
$arrayPattern = [regex]'int\[\]\s+(?:values|numbers)\s*=\s*\{[^}]*\};'
$checked = 0

function Check-Array($source, $values, $expected, $caseName) {
    $sourceText = [System.IO.File]::ReadAllText((Join-Path $repoRoot $source))
    if ($arrayPattern.Matches($sourceText).Count -ne 1) {
        throw "Expected exactly one input array in $source"
    }
    $originalArray = $arrayPattern.Match($sourceText).Value
    $newArray = [regex]::Replace($originalArray, '\{[^}]*\}', ('{' + $values + '}'))
    $sourceText = $arrayPattern.Replace($sourceText, $newArray)
    $buildDir = Join-Path $tempRoot ([guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $buildDir | Out-Null
    $className = [System.IO.Path]::GetFileNameWithoutExtension($source)
    $tempSource = Join-Path $buildDir ($className + '.java')
    [System.IO.File]::WriteAllText($tempSource, $sourceText, $utf8)
    & javac -encoding UTF-8 -d $buildDir $tempSource
    if ($LASTEXITCODE -ne 0) { throw "Compilation failed: $source ($caseName)" }
    $actualPath = Join-Path $buildDir 'actual.txt'
    & java '-Dfile.encoding=UTF-8' '-Dstdout.encoding=UTF-8' -cp $buildDir $className > $actualPath
    if ($LASTEXITCODE -ne 0) { throw "Run failed: $source ($caseName)" }
    $actual = [System.IO.File]::ReadAllText($actualPath).Replace("`r`n", "`n")
    if ($actual -cne ($expected + "`n")) {
        throw "Output mismatch: $source ($caseName)`nExpected: $expected`nActual: $actual"
    }
    Write-Output "PASS: $source ($caseName)"
    $script:checked++
}

try {
    # 非空前提；首尾两个用例分别让最大值和最小值落在首位、末位。
    $extremes = @(
        @{ Name = 'single'; Values = '-7'; Max = '-7'; Min = '-7' }
        @{ Name = 'all equal'; Values = '4, 4, 4'; Max = '4'; Min = '4' }
        @{ Name = 'all negative'; Values = '-12, -7, -3, -9'; Max = '-3'; Min = '-12' }
        @{ Name = 'maximum first, minimum last'; Values = '9, 4, 2'; Max = '9'; Min = '2' }
        @{ Name = 'minimum first, maximum last'; Values = '2, 4, 9'; Max = '9'; Min = '2' }
    )
    foreach ($case in $extremes) {
        Check-Array 'practice/arrays/ArrayMax.java' $case.Values $case.Max $case.Name
        Check-Array 'practice/arrays/ArrayMinMax.java' $case.Values ("最大值：" + $case.Max + "`n最小值：" + $case.Min) $case.Name
    }

    Check-Array 'practice/arrays/GreaterThanTenCount.java' '-12, 0, 10' '0' 'no match, includes threshold'
    Check-Array 'practice/arrays/GreaterThanTenCount.java' '10, 11, -2, 0' '1' 'one match, includes threshold'
    Check-Array 'practice/arrays/GreaterThanTenCount.java' '11, 12, 18' '3' 'all match'
    Check-Array 'practice/arrays/filtered-stats/Main.java' '10, 11, -2, 0' "符合条件的元素：`n数量：0`n总和：0" 'no match, includes threshold'
    Check-Array 'practice/arrays/filtered-stats/Main.java' '10, 12, 13, 0, -2' "符合条件的元素：12`n数量：1`n总和：12" 'one match, includes threshold'
    Check-Array 'practice/arrays/filtered-stats/Main.java' '12, 18, 20' "符合条件的元素：12 18 20`n数量：3`n总和：50" 'all match'

    Check-Array 'practice/arrays/ArraySum.java' '0, -2, 2' '0' 'zero sum with a negative value'
    Check-Array 'practice/arrays/ArraySum.java' '-5, 0, -3' '-8' 'negative sum with zero'
    # 同一组数据分别核对求和与计数：每命中一个元素，前者加值，后者加1。
    $evenCases = @(
        @{ Name = 'no even values'; Values = '-3, 1, 7'; Sum = '0'; Count = '0' }
        @{ Name = 'zero is even'; Values = '-3, 0, 7'; Sum = '0'; Count = '1' }
        @{ Name = 'negative even values and zero'; Values = '-4, 0, 2'; Sum = '-2'; Count = '3' }
    )
    foreach ($case in $evenCases) {
        Check-Array 'practice/arrays/EvenSum.java' $case.Values $case.Sum $case.Name
        Check-Array 'practice/arrays/EvenCount.java' $case.Values $case.Count $case.Name
    }
    Write-Output "Passed $checked array boundary checks."
}
finally {
    if (Test-Path -LiteralPath $tempRoot) {
        $resolved = (Resolve-Path -LiteralPath $tempRoot).Path
        if ($resolved -ne [System.IO.Path]::GetFullPath($tempRoot)) {
            throw 'Refusing to clean an unexpected temporary directory.'
        }
        Remove-Item -LiteralPath $resolved -Recurse -Force
    }
}
