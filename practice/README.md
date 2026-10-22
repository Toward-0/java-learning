# 练习指南

[返回首页](../README.md) · [学习记录](../docs/learning.md) · [原始片段](../docs/original-snippets.md)

## 程序与预期输出

以下输出对应仓库当前数据。A01/A02 补有运行外壳，A04/A05 另补测试数组 [C]；第26～31题按本人来源澄清保留为本人代码，经 Codex 整理与同步。实际日期、提示情况和原始错误见学习记录。

| 题目或片段 | 源码 | 预期输出 |
| --- | --- | --- |
| 入门 | [Main](../Main.java) | `我的 Java 已准备好！` |
| A01 | [EvenRunningTotal](loops/EvenRunningTotal.java) | 2、6、12、20、30，各一行 |
| A02 | [OddSum](loops/OddSum.java) | 25 |
| A04 | [ArraySum](arrays/ArraySum.java) | 8；补充数组为 `{3, -2, 7, 0}` |
| A05 | [EvenCount](arrays/EvenCount.java) | 4；补充数组为 `{-4, -3, 0, 2, 7, 8}` |
| 26 | [EvenSum](arrays/EvenSum.java) | 6 |
| 27 | [GreaterThanTenCount](arrays/GreaterThanTenCount.java) | 4 |
| 28～29 | [Main](arrays/filtered-stats/Main.java) | `符合条件的元素：12 18 20`、`数量：3`、`总和：50`，各一行 |
| 30 | [ArrayMax](arrays/ArrayMax.java) | -3；前提为非空数组 |
| 31 | [ArrayMinMax](arrays/ArrayMinMax.java) | `最大值：-3`、`最小值：-12`，各一行；前提为非空数组 |
| 32 | [Main](independent/2026-10-14/Main.java) | 1 |
| 33 | [Main](independent/2026-10-22/Main.java) | `找到18，下标为：1`、`找到18，下标为：3`、`找到18，下标为：5`、`18总共出现了3次`，共四行，最后无换行 |

A03 的另一种奇数求和写法保留在原始片段；A05 是计数，不能当作第26题求和的原答。第32、33题保留用户原始排版。当前待答题只在 [学习记录](../docs/learning.md#当前任务) 维护。

## 一条命令验证

JDK 25、PowerShell 7，在仓库根目录运行：

```powershell
java -version
javac -version
pwsh -File scripts/check-practice.ps1
```

[脚本](../scripts/check-practice.ps1)和 CI 共用：检查 12 个原有输出、36 个边界用例，每次单独编译并限时运行。保留输出中的空格和末尾换行，仅统一操作系统换行。只在临时副本中换数组，不改正式源码。

边界覆盖非空最大/最小值、条件阈值、零个/一个/全部匹配、负数与 0 的计数/求和；第32、33题还覆盖首尾命中、重复命中、空数组、单元素及未找到。测试数据是验证补充 [C]，通过不等于本人已完成这些练习。

新增正式程序时，在脚本的 `$programs` 中补上源码路径和实际核对的预期输出；脚本会拒绝漏列的程序。未来有输入程序时再补相应输入案例，不提前搭建框架。

## 单独运行与调试

以下是第33题的完整命令（Windows PowerShell）：

```powershell
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
New-Item -ItemType Directory -Force out/ex33 | Out-Null
javac -encoding UTF-8 -d out/ex33 practice/independent/2026-10-22/Main.java
java '-Dfile.encoding=UTF-8' '-Dstdout.encoding=UTF-8' -cp out/ex33 Main
```

换题时修改源码路径与输出目录；四个同名 `Main.java` 必须分目录编译。其余程序用文件名对应的类名运行，例如 `EvenCount`，不加 `.java` 或 `.class`。

`-encoding UTF-8` 指定源码编码；`-d` 指定编译目录；`-cp` 指定查找类的目录。PowerShell 中 JVM 的 `-D...` 参数加引号。

| 现象 | 先检查 |
| --- | --- |
| 找不到 javac | JDK 安装和终端 PATH |
| 找不到源文件 | 是否在仓库根目录、路径是否正确 |
| 找不到主类或运行了另一题 | 编译是否成功、类名与独立输出目录是否对应 |
| 标点报错 | 对照 A07/A08 的点号、半角分号 |
| 结果不对 | 先手算一组数据，再跟踪第一个不同的变量值 |

过去的验证记录保留在 [学习日志](../docs/learning.md)。当前覆盖范围以脚本为准；构建产物不提交。
