# java-learning

用 Java 把问题写成可运行的程序，并能解释为什么结果正确。

## 每次从这里继续

打开 [当前学习状态](docs/learning.md#当前任务)，先完成其中的一道题。先写预测或尝试，再运行检查；遇到错误才回到对应片段。当天只记录改变了理解的地方。

| 需要什么 | 入口 |
| --- | --- |
| 当前题目、已有能力与学习记录 | [学习状态与日志](docs/learning.md) |
| 程序索引、运行命令和预期输出 | [练习指南](practice/README.md) |
| 早期原答和原始错误 | [原始片段 A01～A09](docs/original-snippets.md) |

## 验证现有代码

安装 JDK 25 和 PowerShell 7，在仓库根目录执行：

```powershell
pwsh -File scripts/check-practice.ps1
```

脚本分别编译程序，核对固定输出及数组边界；同名 `Main` 使用不同临时目录。单个程序怎样运行见 [练习指南](practice/README.md)。根目录的 `Main.java` 是最初的打印练习，不是所有程序的总入口。

记录与协作规则见 [AGENTS.md](AGENTS.md)。学习日志保留原答与关键纠错，验证通过不自动改变掌握状态。
