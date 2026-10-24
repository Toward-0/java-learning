# 练习指南

[返回首页](../README.md) · [学习记录](../docs/learning.md) · [早期原始片段](../docs/original-snippets.md)

## 程序与预期输出

输出对应当前源码；日期、来源与纠错见[学习记录](../docs/learning.md)。

| 题号 | 源码 | 预期输出 |
| --- | --- | --- |
| 26：偶数求和 | [EvenSum](arrays/EvenSum.java) | `6` |
| 27：统计严格大于10的元素 | [GreaterThanTenCount](arrays/GreaterThanTenCount.java) | `4` |
| 28～29：筛选、计数与求和 | [Main](arrays/filtered-stats/Main.java) | `符合条件的元素：12 18 20`、`数量：3`、`总和：50`，各一行 |
| 30：最大值 | [ArrayMax](arrays/ArrayMax.java) | `-3`；前提为非空数组 |
| 31：最大/最小值 | [ArrayMinMax](arrays/ArrayMinMax.java) | `最大值：-3`、`最小值：-12`，各一行；前提为非空数组 |
| 32：首个匹配 | [Main](independent/2026-10-14/Main.java) | `1` |
| 33：全部匹配及次数 | [Main](independent/2026-10-22/Main.java) | `找到18，下标为：1`、`找到18，下标为：3`、`找到18，下标为：5`、`18总共出现了3次`，共四行，最后无换行 |

## 单独运行与调试

安装 JDK 25，在仓库根目录运行一道已完成的练习：

~~~text
java practice/arrays/EvenSum.java
~~~

应输出 `6`。换题只需使用上表的源码路径。若练习“编译→运行”两步，Windows PowerShell 示例为：

~~~powershell
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
New-Item -ItemType Directory -Force out/ex33 | Out-Null
javac -encoding UTF-8 -d out/ex33 practice/independent/2026-10-22/Main.java
java '-Dfile.encoding=UTF-8' '-Dstdout.encoding=UTF-8' -cp out/ex33 Main
~~~

`-encoding` 指定源码编码，`-d` 指定编译目录，`-cp` 指定类目录。三个同名 `Main.java` 分目录编译；其余程序运行时使用文件名对应的类名，不加扩展名。PowerShell 中 `-D...` 参数加引号。

| 现象 | 先检查 |
| --- | --- |
| 找不到 javac | JDK 安装与 PATH |
| 找不到文件/主类，或运行了另一题 | 仓库根目录、源码路径、编译结果、类名及输出目录 |
| 标点报错 | 原始片段 A07/A08 的点号、半角分号 |
| 结果不对 | 手算一组数据，跟踪第一个不同的变量值 |

## 维护者全量检查

JDK 25、PowerShell 7，在仓库根目录执行：

~~~powershell
pwsh -File scripts/check-practice.ps1
~~~

[脚本](../scripts/check-practice.ps1)与 CI 共用，检查逐字输出及数组边界；只统一换行，测试数据仅替换临时副本。新增源码时补 `$programs` 的路径与预期输出，脚本会检查遗漏。
