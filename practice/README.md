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
| [EvenSum](arrays/EvenSum.java) | AI 复习示例 [C] | 6 |
| [GreaterThanTenCount](arrays/GreaterThanTenCount.java) | AI 复习示例 [C] | 4 |
| [Main](arrays/filtered-stats/Main.java) | AI 复习示例 [C] | 见下方三行 |
| [ArrayMax](arrays/ArrayMax.java) | AI 复习示例 [C]，假设数组非空 | -3 |
| [ArrayMinMax](arrays/ArrayMinMax.java) | AI 复习示例 [C]，假设数组非空 | 最大值：-3、最小值：-12，各占一行 |

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
New-Item -ItemType Directory -Force out | Out-Null
javac -encoding UTF-8 -d out practice/arrays/EvenCount.java
if ($LASTEXITCODE -eq 0) {
    java -Dstdout.encoding=UTF-8 -cp out EvenCount
}
```

运行其他程序时，替换源码路径和最后的类名。每次只编译一个程序；根目录和 `arrays/filtered-stats/` 中的两个 `Main` 会写入同名 class，因此必须先成功编译所选源码，再运行。根目录 `Main.java` 不是总入口。

`-encoding UTF-8` 指定源码编码，`-d out` 指定编译目录，`-cp out` 指定运行时的类目录；类名不带扩展名。找不到 javac 时检查 JDK 和 PATH，找不到源文件时检查当前目录。

[GitHub Actions](../.github/workflows/java-basics.yml) 在 JDK 25 上将各源码隔离编译，并核对上表十个示例的输出；其他新增源码只编译。历史验证记录见[学习记录](../docs/learning.md)。
