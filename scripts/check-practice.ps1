#requires -Version 7.0
# [C] Verification only: these cases are not learner attempts or mastery evidence.
$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$utf8 = [System.Text.UTF8Encoding]::new($false)
[Console]::OutputEncoding = $utf8
$tempParent = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
$tempRoot = Join-Path $tempParent ('java-practice-' + [guid]::NewGuid().ToString('N'))
$arrayPattern = [regex]'int\[\]\s+(?:values|numbers)\s*=\s*\{[^}]*\};'
$script:checked = 0

function Invoke-CheckedProcess($command, $arguments) {
    $info = [System.Diagnostics.ProcessStartInfo]::new()
    $info.FileName = $command
    $info.UseShellExecute = $false
    $info.RedirectStandardInput = $true
    $info.RedirectStandardOutput = $true
    $info.RedirectStandardError = $true
    $info.StandardOutputEncoding = $utf8
    $info.StandardErrorEncoding = $utf8
    foreach ($argument in $arguments) { $info.ArgumentList.Add([string]$argument) }
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $info
    try {
        [void]$process.Start()
        $process.StandardInput.Close()
        $stdout = $process.StandardOutput.ReadToEndAsync()
        $stderr = $process.StandardError.ReadToEndAsync()
        if (-not $process.WaitForExit(15000)) {
            $process.Kill($true)
            $process.WaitForExit()
            throw "$command timed out after 15 seconds"
        }
        $output = $stdout.GetAwaiter().GetResult()
        $errorOutput = $stderr.GetAwaiter().GetResult()
        if ($process.ExitCode -ne 0) { throw "$command failed ($($process.ExitCode)): $errorOutput" }
        return $output
    }
    finally { $process.Dispose() }
}

function Check-Program($source, $expected, $caseName, $values = $null) {
    $sourceText = [System.IO.File]::ReadAllText((Join-Path $repoRoot $source), $utf8)
    if ($null -ne $values) {
        if ($arrayPattern.Matches($sourceText).Count -ne 1) {
            throw "Expected exactly one input array in $source"
        }
        $original = $arrayPattern.Match($sourceText).Value
        $replacement = [regex]::Replace($original, '\{[^}]*\}', ('{' + $values + '}'))
        $sourceText = $arrayPattern.Replace($sourceText, $replacement)
    }
    $buildDir = Join-Path $tempRoot ([guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $buildDir -Force | Out-Null
    $className = [System.IO.Path]::GetFileNameWithoutExtension($source)
    $tempSource = Join-Path $buildDir ($className + '.java')
    [System.IO.File]::WriteAllText($tempSource, $sourceText, $utf8)
    $null = Invoke-CheckedProcess 'javac' @('-encoding', 'UTF-8', '-d', $buildDir, $tempSource)
    $actual = Invoke-CheckedProcess 'java' @('-Dfile.encoding=UTF-8', '-Dstdout.encoding=UTF-8', '-cp', $buildDir, $className)
    $actual = $actual.Replace("`r`n", "`n")
    if ($actual -cne $expected) {
        throw "Output mismatch: $source ($caseName)`nExpected: <$expected>`nActual: <$actual>"
    }
    Write-Output "PASS: $source ($caseName)"
    $script:checked++
}

try {
    # Exact output, including trailing newlines; every checked-in program must be listed.
    $programs = @(
        @{ Source = 'Main.java'; Expected = "我的 Java 已准备好！`n" }
        @{ Source = 'practice/loops/EvenRunningTotal.java'; Expected = "2`n6`n12`n20`n30`n" }
        @{ Source = 'practice/loops/OddSum.java'; Expected = "25`n" }
        @{ Source = 'practice/arrays/ArraySum.java'; Expected = "8`n" }
        @{ Source = 'practice/arrays/EvenCount.java'; Expected = "4`n" }
        @{ Source = 'practice/arrays/EvenSum.java'; Expected = "6`n" }
        @{ Source = 'practice/arrays/GreaterThanTenCount.java'; Expected = "4`n" }
        @{ Source = 'practice/arrays/ArrayMax.java'; Expected = "-3`n" }
        @{ Source = 'practice/arrays/ArrayMinMax.java'; Expected = "最大值：-3`n最小值：-12`n" }
        @{ Source = 'practice/arrays/filtered-stats/Main.java'; Expected = "符合条件的元素：12 18 20`n数量：3`n总和：50`n" }
        @{ Source = 'practice/independent/2026-10-14/Main.java'; Expected = "1`n" }
        @{ Source = 'practice/independent/2026-10-22/Main.java'; Expected = "找到18，下标为：1`n找到18，下标为：3`n找到18，下标为：5`n18总共出现了3次" }
    )
    $sources = @('Main.java') + @(Get-ChildItem (Join-Path $repoRoot 'practice') -Recurse -Filter '*.java' | ForEach-Object {
        [System.IO.Path]::GetRelativePath($repoRoot, $_.FullName).Replace('\', '/')
    })
    $difference = Compare-Object ($sources | Sort-Object -Unique) ($programs.Source | Sort-Object -Unique)
    if ($difference) { throw "Update the output cases for added or removed programs: $($difference | Out-String)" }
    foreach ($program in $programs) {
        Check-Program $program.Source $program.Expected 'original input'
    }

    # Max/min require a nonempty array. No new empty-array contract is imposed.
    foreach ($case in @(
        @{ Values = '-7'; Max = '-7'; Min = '-7' }
        @{ Values = '4, 4, 4'; Max = '4'; Min = '4' }
        @{ Values = '-12, -7, -3, -9'; Max = '-3'; Min = '-12' }
        @{ Values = '9, 4, 2'; Max = '9'; Min = '2' }
        @{ Values = '2, 4, 9'; Max = '9'; Min = '2' }
    )) {
        Check-Program 'practice/arrays/ArrayMax.java' ($case.Max + "`n") "array {$($case.Values)}" $case.Values
        Check-Program 'practice/arrays/ArrayMinMax.java' ("最大值：" + $case.Max + "`n最小值：" + $case.Min + "`n") "array {$($case.Values)}" $case.Values
    }
    Check-Program 'practice/arrays/GreaterThanTenCount.java' "0`n" 'threshold, no match' '-12, 0, 10'
    Check-Program 'practice/arrays/GreaterThanTenCount.java' "1`n" 'threshold, one match' '10, 11, -2, 0'
    Check-Program 'practice/arrays/GreaterThanTenCount.java' "3`n" 'all match' '11, 12, 18'
    Check-Program 'practice/arrays/filtered-stats/Main.java' "符合条件的元素：`n数量：0`n总和：0`n" 'no match' '10, 11, -2, 0'
    Check-Program 'practice/arrays/filtered-stats/Main.java' "符合条件的元素：12`n数量：1`n总和：12`n" 'one match' '10, 12, 13, 0, -2'
    Check-Program 'practice/arrays/filtered-stats/Main.java' "符合条件的元素：12 18 20`n数量：3`n总和：50`n" 'all match' '12, 18, 20'
    Check-Program 'practice/arrays/ArraySum.java' "0`n" 'zero sum' '0, -2, 2'
    Check-Program 'practice/arrays/ArraySum.java' "-8`n" 'negative sum' '-5, 0, -3'
    foreach ($case in @(
        @{ Values = '-3, 1, 7'; Sum = '0'; Count = '0' }
        @{ Values = '-3, 0, 7'; Sum = '0'; Count = '1' }
        @{ Values = '-4, 0, 2'; Sum = '-2'; Count = '3' }
    )) {
        Check-Program 'practice/arrays/EvenSum.java' ($case.Sum + "`n") "array {$($case.Values)}" $case.Values
        Check-Program 'practice/arrays/EvenCount.java' ($case.Count + "`n") "array {$($case.Values)}" $case.Values
    }

    # Catch the historical fixed-index error and confusion between first/all matches.
    foreach ($case in @(
        @{ Name = 'no match'; Values = '23, -5, 42, 0'; First = '-1'; All = '18总共出现了0次' }
        @{ Name = 'first element'; Values = '18, 0, -5'; First = '0'; All = "找到18，下标为：0`n18总共出现了1次" }
        @{ Name = 'last element'; Values = '0, -5, 18'; First = '2'; All = "找到18，下标为：2`n18总共出现了1次" }
        @{ Name = 'repeated matches'; Values = '18, 18, 18'; First = '0'; All = "找到18，下标为：0`n找到18，下标为：1`n找到18，下标为：2`n18总共出现了3次" }
        @{ Name = 'empty array'; Values = ''; First = '-1'; All = '18总共出现了0次' }
        @{ Name = 'singleton'; Values = '18'; First = '0'; All = "找到18，下标为：0`n18总共出现了1次" }
    )) {
        Check-Program 'practice/independent/2026-10-14/Main.java' ($case.First + "`n") $case.Name $case.Values
        Check-Program 'practice/independent/2026-10-22/Main.java' $case.All $case.Name $case.Values
    }
    Write-Output "Passed $checked checks (12 original outputs, 36 boundary cases). No learner state was changed."
}
finally {
    if (Test-Path -LiteralPath $tempRoot) {
        $resolved = (Resolve-Path -LiteralPath $tempRoot).Path
        if ($resolved -ne [System.IO.Path]::GetFullPath($tempRoot) -or
            [System.IO.Path]::GetDirectoryName($resolved).TrimEnd('\', '/') -ne $tempParent.TrimEnd('\', '/')) {
            throw 'Refusing to clean an unexpected temporary directory.'
        }
        Remove-Item -LiteralPath $resolved -Recurse -Force
    }
}
