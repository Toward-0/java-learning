# 练习索引与运行方法

[返回首页](../README.md) · [学习记录](../docs/learning.md) · [原始片段](../docs/original-snippets.md)

## 现有程序

| 源码 | 来源 | 预期输出 |
| --- | --- | --- |
| [Main](../Main.java) | 最早的打印入门程序 | 我的 Java 已准备好！ |
| [EvenRunningTotal](loops/EvenRunningTotal.java) | A01 原始逻辑 [A]，程序外壳 [C] | 2、6、12、20、30，各占一行 |
| [OddSum](loops/OddSum.java) | A02 原始逻辑 [A]，程序外壳 [C] | 25 |
| [ArraySum](arrays/ArraySum.java) | A04 原始逻辑 [A]，外壳与测试数组 [C] | 8 |
| [EvenCount](arrays/EvenCount.java) | A05 原始逻辑 [A]，外壳与测试数组 [C] | 4 |
| [EvenSum](arrays/EvenSum.java) | 本人代码，Codex 整理与同步 | 6 |
| [GreaterThanTenCount](arrays/GreaterThanTenCount.java) | 本人代码，Codex 整理与同步 | 4 |
| [Main](arrays/filtered-stats/Main.java) | 本人代码，Codex 整理与同步 | 见下方三行 |
| [ArrayMax](arrays/ArrayMax.java) | 本人代码，假设数组非空 | -3 |
| [ArrayMinMax](arrays/ArrayMinMax.java) | 本人代码，假设数组非空 | 最大值：-3、最小值：-12，各占一行 |

`arrays/filtered-stats/Main.java` 的输出：

```text
符合条件的元素：12 18 20
数量：3
总和：50
```

原始数组 A04、A05 没有保留下来；上表输出只对应源码中的补充数据。A03 的另一种奇数求和写法仍在原始片段档案中。

## 运行一个程序

安装 JDK 后，在仓库根目录的 Windows PowerShell 执行：

```powershell
java -version
javac -version
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
$buildDir = Join-Path 'out' 'EvenCount'
New-Item -ItemType Directory -Force $buildDir | Out-Null
javac -encoding UTF-8 -d $buildDir practice/arrays/EvenCount.java
if ($LASTEXITCODE -eq 0) {
    java '-Dstdout.encoding=UTF-8' -cp $buildDir EvenCount
}
```

运行其他程序时，替换源码路径、类名和编译子目录。每个程序用独立子目录，例如根目录 `Main.java` 用 `out/root-main`，`arrays/filtered-stats/Main.java` 用 `out/filtered-stats`，避免同名 `Main.class` 相互覆盖。先成功编译所选源码，再运行。根目录 `Main.java` 不是总入口。

`-encoding UTF-8` 指定源码编码，`-d` 指定编译目录，`-cp` 指定运行时的类目录；类名不带扩展名。找不到 javac 时检查 JDK 和 PATH，找不到源文件时检查当前目录。

[GitHub Actions](../.github/workflows/java-basics.yml) 在 JDK 25 上将各源码隔离编译，并核对上表十个示例的输出；其他新增源码只编译。历史验证记录见[学习记录](../docs/learning.md)。

## 数组边界检查 [C]

在仓库根目录执行 `pwsh -NoProfile -File scripts/check-array-boundaries.ps1`（需要 PowerShell 7 和 JDK）。[脚本](../scripts/check-array-boundaries.ps1) 只在临时副本里替换输入数组，运行现有源码的逻辑，不复制解法；各次编译隔离，结束后清理临时目录。CI 也运行同一脚本。

- 最大值、最小值：单元素、全部相同、全负数、极值在首位或末位。原题假设非空，检查沿用该条件。
- `> 10` 以及 `> 10 && 偶数`：零个、一个、全部匹配，并确认等于 10 不匹配。
- 数组求和、偶数求和与偶数计数：覆盖 0、负数、零个匹配，分别核对元素值之和和匹配个数。例如 `{-4, 0, 2}` 的偶数总和为 -2，个数为 3；0 是偶数，计数加 1，但求和加 0。

这些数据和脚本由 Codex 补充，检查通过只证明指定输入下的程序行为；没有新增本人练习或本人复测记录。
