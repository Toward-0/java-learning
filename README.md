# java-learning

My Java learning notes and practice code

我的零基础 Java 学习档案：保存练习片段、纠错过程和阶段成果，逐步练习独立写出小程序。

**学习进度截至 2026-10-09 · 资料整理于 2026-10-12**

## 从这里开始

| 想了解什么 | 文档 |
| --- | --- |
| 学过什么、哪些还需巩固 | [学习进度与成果](docs/learning-progress.md) |
| 当时写的代码和真实错误 | [原始片段 A01～A09](docs/original-snippets.md) |
| 按日期回顾、继续记录新练习 | [学习日志](docs/learning-log.md) |
| 编译运行示例、核对输出 | [练习指南](practice/README.md) |
| 保存今后独立完成的程序 | [独立程序保存规则](practice/independent/README.md) |

## 目前的学习成果

- 已练习输出、变量与运算、基础输入、条件判断、循环和数组。
- 能阅读、跟踪和改写基础练习，近期能独立写出数行数组循环逻辑。
- 数组第 1～25 题有完成记录；**第 26 题“数组中的偶数总和”尚未作答**。
- 从空白文件编写完整程序，特别是 `import`、类、`main` 和 `Scanner` 输入，仍需巩固。

下一步采用“讲一点 → 自己写一点 → 检查纠错 → 再继续”的节奏，先巩固已有基础。

## 先运行已有程序

在 Windows PowerShell 中进入仓库根目录，使用已安装的 JDK 25：

```powershell
java -version
javac -version
New-Item -ItemType Directory -Force out | Out-Null
javac -encoding UTF-8 -d out Main.java
java -cp out Main
```

预期输出：`我的 Java 已准备好！`。运行其余 4 个示例的方法见[练习指南](practice/README.md)。

## 资料来源与目录

依据学习者提供的 `CODEX_JAVA_LEARNING_HANDOFF.md` 整理。该资料只覆盖部分历史学习记录，本次没有直接读取全部旧对话。

- **[A] 用户原始片段**：可以确认由学习者发送，保留原始错误和片段边界。
- **[B] 进度概要**：有记录支持，不代表每道题都保存了完整原文。
- **[C] 整理补充**：后加的类、`main`、测试数组和说明，不计作学习者原创完整程序。

```text
Main.java                 已有入门程序，保持原样
docs/                     学习进度、原始片段、学习日志
practice/README.md        运行步骤、预期输出、复习提示
practice/loops/           偶数逐次累计、奇数求和示例
practice/arrays/          数组求和、偶数计数示例
```

仅使用基础 Java 语法，不引入构建框架。编译产物由 `.gitignore` 忽略；方法、面向对象、集合、异常等后续主题不列为已掌握。

## 自动检查与协作

[JDK 25 工作流](.github/workflows/java-basics.yml)在推送和 Pull Request 时编译当前五个 Java 程序，逐一核对无输入示例的预期输出。使用 `javac`、`java` 和 `diff`，不引入构建框架；运行结果以 PR 的 Checks 为准。通过检查不代表完成新的学习任务。

仓库修改遵循 [AGENTS.md](AGENTS.md)；后续学习继续复用[学习日志](docs/learning-log.md)中的模板。
