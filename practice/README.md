# Java：程序运行

[学习记录](../docs/learning.md) · [当前任务](../current.md) · [知识目录](../docs/concepts.md)

题目、原答、预期输出与纠错统一见[题目索引](../docs/learning.md#题目索引)。本页只说明如何运行和检查。

## 环境准备

本仓库以 JDK 25 为验证环境。先在终端检查编译器与运行时：

~~~text
java --version
javac --version
~~~

两者均应可用且版本对应。若只有 `java`，请检查是否已安装完整 JDK，以及 `PATH` 是否指向该 JDK 的 `bin` 目录。下文练习命令在**仓库根目录**执行；PowerShell 示例使用 PowerShell 7（`pwsh`）。

## 单独运行与调试

快速运行一道已完成的练习：

~~~text
java practice/arrays/EvenSum.java
~~~

预期结果见[第26题](../docs/learning.md#ex26)。换题使用题目记录中的源码路径。若练习“编译 → 运行”两步，以第33题为例：

~~~powershell
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
New-Item -ItemType Directory -Force out/ex33 | Out-Null
javac -encoding UTF-8 -d out/ex33 practice/independent/2026-10-22/Main.java
java '-Dfile.encoding=UTF-8' '-Dstdout.encoding=UTF-8' -cp out/ex33 Main
~~~

`-encoding` 指定源码编码，`-d` 指定编译目录，`-cp` 指定类目录。三个同名 `Main.java` 分目录编译；其余程序运行时使用文件名对应的类名，不加扩展名。PowerShell 中 `-D...` 参数加引号。

源码改动后需要重新编译；仅运行 `java -cp ...` 不会自动更新旧的 `.class` 文件。编译失败时先修复错误，不继续运行旧结果。

| 现象 | 先检查 |
| --- | --- |
| 找不到 javac | JDK 安装与 PATH |
| 找不到文件/主类，或运行了另一题 | 仓库根目录、源码路径、编译结果、类名及输出目录 |
| 多个 Main 导致重复类错误 | 每题使用独立编译目录，不把全部源码一起交给 javac |
| 标点报错 | [A07](../docs/learning.md#a07) / [A08](../docs/learning.md#a08) 的点号、半角分号 |
| 结果不对 | 手算一组数据，跟踪第一个不同的变量值 |

## 知识示例

[知识目录](../docs/concepts.md#怎样使用示例)中的完整程序，先按指定文件名保存到独立练习目录，再编译运行。例如，将对象章节的完整示例保存为 `ObjectDemo.java` 后，在该文件所在目录执行：

~~~powershell
New-Item -ItemType Directory -Force out | Out-Null
javac -encoding UTF-8 -d out ObjectDemo.java
java -cp out ObjectDemo
~~~

`PolymorphismDemo.java` 同理，将上述两条命令中的类名改成 `PolymorphismDemo`。这些文件同时声明了辅助类型，含 `main` 的类不是首个顶层类型，因此使用显式类名启动。方法内片段要先放入完整的类和 `main`，不能直接把片段保存为 `.java` 文件运行。

## 维护者全量检查

文档检查需要 Python 3.10+，无第三方依赖。在仓库根目录执行：

~~~text
python scripts/check_repo.py
~~~

检查 UTF-8、本地链接、图片引用、锚点、代码围栏与显示公式分隔符；不检查外部网站是否可访问，也不判断知识正确性。

程序检查需要 JDK 25、PowerShell 7：

~~~powershell
pwsh -File scripts/check-practice.ps1
~~~

[脚本](../scripts/check-practice.ps1)与 CI 共用，检查逐字输出及数组边界；只统一换行，测试数据仅替换临时副本。新增源码时补 `$programs` 的路径与预期输出，脚本会检查遗漏。

修改文档检查脚本后，额外运行其回归测试：

~~~text
python -B -m unittest discover -s scripts -p "test_*.py"
~~~

检查通过只证明对应的文件结构或程序行为；学习掌握程度仍以本人实际作答和提示情况为依据。
