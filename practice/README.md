# 基础练习指南

[返回首页](../README.md) · [原始片段](../docs/original-snippets.md) · [学习状态与日志](../docs/learning.md) · [独立程序](independent/README.md)

这里原有的 4 个程序以已确认片段为基础，便于编译和观察结果。**类、main、测试数据及讲解为整理者补充 [C]**，不代表学习者当时独立写出了整份程序。原文与错误保存在 Markdown 中。

## 示例索引

| 程序 | 原始片段 | 补充内容 [C] | 预期输出 |
| --- | --- | --- | --- |
| [EvenRunningTotal](loops/EvenRunningTotal.java) | A01 | 类、main、说明和外层缩进 | 2、6、12、20、30，各占一行 |
| [OddSum](loops/OddSum.java) | A02 | 类、main、说明和外层缩进 | 25 |
| [ArraySum](arrays/ArraySum.java) | A04 | 上述外壳，加测试数组 `{3, -2, 7, 0}` | 8 |
| [EvenCount](arrays/EvenCount.java) | A05 | 上述外壳，加测试数组 `{-4, -3, 0, 2, 7, 8}` | 4 |

A03 的步长为 2 的写法保留在原始片段文档中。A04、A05 的原练习数组未收录，因此这里的数值输出只对应补充数据。`EvenCount` 统计偶数个数，不是第26题偶数求和；第26题的最新状态见学习日志。

## 第26～31题复习示例 [C]

这些新增文件可各自独立运行；全部代码、测试数据和输出格式由 AI 按用户确认的题目概要整理，不是用户原始答案，也不放入独立作品目录。第28～29题只保留一份正式源码。第32、33题后续已有用户原始作答 [A]，见下方独立程序索引。

| 题号 | 程序 | AI 补充测试数据的预期输出 |
| --- | --- | --- |
| 26 | [EvenSum](arrays/EvenSum.java) | `6` |
| 27 | [GreaterThanTenCount](arrays/GreaterThanTenCount.java) | `4` |
| 28～29 | [Main](arrays/filtered-stats/Main.java) | 见下方三行 |
| 30 | [ArrayMax](arrays/ArrayMax.java) | `-3` |
| 31 | [ArrayMinMax](arrays/ArrayMinMax.java) | `最大值：-3`、`最小值：-12`，各占一行 |

第28～29题的预期输出：

```text
符合条件的元素：12 18 20
数量：3
总和：50
```

在仓库根目录分别编译运行（第30～31题假设数组非空）。中文输出采用 UTF-8，PowerShell 的解码也需保持一致：

```powershell
New-Item -ItemType Directory -Force out | Out-Null
javac -encoding UTF-8 -d out practice/arrays/EvenSum.java practice/arrays/GreaterThanTenCount.java practice/arrays/ArrayMax.java practice/arrays/ArrayMinMax.java
java -cp out EvenSum
java -cp out GreaterThanTenCount
java -cp out ArrayMax
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
java -Dstdout.encoding=UTF-8 -cp out ArrayMinMax

# 第28～29题与根目录 Main 同名，使用单独输出目录。
New-Item -ItemType Directory -Force out/filtered-stats | Out-Null
javac -encoding UTF-8 -d out/filtered-stats practice/arrays/filtered-stats/Main.java
java -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 -cp out/filtered-stats Main
```

## 第32、33题用户原始作答 [A]

两份用户原始作答分别保存在按完成日期命名的目录中，均保留原有 `public class Main`，需单独编译运行；第34题已布置，尚未提交答案。完成方式、纠错经历与验证证据见[学习日志](../docs/learning.md)。

| 题号 | 正式源码 | 预期输出 |
| --- | --- | --- |
| 32：第一次出现的 18 | [2026-10-14/Main.java](independent/2026-10-14/Main.java) | `1` |
| 33：所有 18 及次数 | [2026-10-22/Main.java](independent/2026-10-22/Main.java) | 下标 1、3、5 各一行，最后一行是 `18总共出现了3次` |

在仓库根目录分别运行，避免两个 `Main` 的编译产物互相覆盖：

```powershell
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
New-Item -ItemType Directory -Force out/ex32, out/ex33 | Out-Null
javac -encoding UTF-8 -d out/ex32 practice/independent/2026-10-14/Main.java
java '-Dfile.encoding=UTF-8' '-Dstdout.encoding=UTF-8' -cp out/ex32 Main
javac -encoding UTF-8 -d out/ex33 practice/independent/2026-10-22/Main.java
java '-Dfile.encoding=UTF-8' '-Dstdout.encoding=UTF-8' -cp out/ex33 Main
```

## 编译运行（Windows PowerShell / JDK 25）

以下命令均在**仓库根目录**执行。先确认 `java -version` 与 `javac -version` 指向预期 JDK，然后编译：

```powershell
New-Item -ItemType Directory -Force out | Out-Null
javac -encoding UTF-8 -d out Main.java practice/loops/EvenRunningTotal.java practice/loops/OddSum.java practice/arrays/ArraySum.java practice/arrays/EvenCount.java
java -cp out Main
java -cp out EvenRunningTotal
java -cp out OddSum
java -cp out ArraySum
java -cp out EvenCount
```

每个文件的公开类名与文件名一致，可以只运行一个示例：

```powershell
javac -encoding UTF-8 -d out practice/arrays/EvenCount.java
java -cp out EvenCount
```

`-encoding UTF-8` 指定源码编码；`-d out` 指定编译文件的存放目录；`-cp out` 告诉 Java 去哪里查找编译好的类。运行时写类名，不加 `.java` 或 `.class`。

## 复习时可以观察什么 [C]

以下是复习提示，不是新增的已完成练习：

1. 运行前，手动写出 `EvenRunningTotal` 每轮结束后的 `sum`，再对照五行输出。
2. 对照 A02 与 A03，解释它们为什么都只加奇数。
3. 在 `ArraySum` 中逐个跟踪数组下标、元素和累计值，检查何时退出循环。
4. 在 `EvenCount` 中指出哪些元素满足条件，说明 0 和负偶数为什么也计入。
5. 尝试不照抄写出程序外壳，再与示例核对。是否完成需由后续学习记录确认。

## 常见问题

| 现象 | 检查方法 |
| --- | --- |
| 提示找不到 javac | 确认安装的是 JDK，检查 VS Code 终端的 PATH；安装后重新打开终端 |
| 提示找不到源文件 | 确认当前路径为仓库根目录，并核对文件名 |
| 提示找不到主类 | 先确认编译成功，再使用 `java -cp out 类名` |
| 代码中标点报错 | 检查点号和半角分号；A07、A08 的错误样本只在文档里保存 |

## 本次验证

2026-10-12 使用 OpenJDK 21.0.12.1 的 javac 编译器及 java，对已有 `Main` 和 4 个示例逐个编译运行、核对输出，合并编译也通过。环境没有独立 javac 启动命令，实际以 `java com.sun.tools.javac.Main` 调用同一编译器。

后续 GitHub Actions（JDK 25 / Ubuntu）已在 [PR #2](https://github.com/Toward-0/java-learning/pull/2) 中成功编译并核对五个程序输出；Windows PowerShell 仍未独立验证。`.class`、`out/` 等编译产物不提交到仓库。

2026-10-13 增量验证：在 Windows PowerShell 使用 Oracle JDK 25.0.4.1，对新增5个源码逐个编译并运行，输出逐字匹配练习指南；以 UTF-8 解码标准输出，并使用 `-Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8`。编译产物未提交。现有 Actions 会逐个编译新增文件，但其固定输出检查仍只覆盖原有五个程序；新增示例的输出通过本次运行验证。

2026-10-22 增量验证：Oracle JDK 25.0.4.1 下分别编译、运行第32、33题独立源码，输出与上表及学习日志一致；第32题另用不含 18 的临时副本验证输出 `-1`。临时编译产物未提交。
