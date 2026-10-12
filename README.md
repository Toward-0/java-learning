# java-learning

我的 Java 学习仓库：**真实记录 → 可运行练习 → 复习进步**。它是学习档案，不是成熟的软件产品，也不以文件数量衡量进步。

## 从这里开始

| 想做什么 | 去哪里 |
| --- | --- |
| 看现在会什么、下一步学什么 | [学习状态与日志](docs/learning.md) |
| 运行基础示例 | [练习指南](practice/README.md) |
| 看历史真实片段和当时的错误 | [原始片段 A01～A09](docs/original-snippets.md) |
| 保存将来独立写出的程序 | [独立程序规则](practice/independent/README.md) |

**现有代码**：`Main.java` 是最早的打印入门程序，不是所有练习的总入口。四个独立运行的教学包装示例分别在 [practice/loops](practice/loops) 和 [practice/arrays](practice/arrays)；程序外壳或测试数据由整理者补充的地方均标为 [C]，不算独立作品。

## 快速运行（Windows PowerShell）

在仓库根目录，安装好 JDK 后执行：

```powershell
java -version
javac -version
New-Item -ItemType Directory -Force out | Out-Null
javac -encoding UTF-8 -d out Main.java
java -cp out Main
```

应打印：`我的 Java 已准备好！`。其他程序的编译、运行与预期输出见 [practice/README.md](practice/README.md)。

## 目录与职责

```text
Main.java                     最初的 Java 入门程序
practice/                     可运行的练习（含后续独立作品）
docs/learning.md              唯一的当前进度与学习日志
docs/original-snippets.md     一次性归档早期可确认的原始片段
AGENTS.md                     AI 协作与来源保护规则
.github/workflows/            JDK 25 编译和输出检查
```

## 最少记录原则

1. **一个程序只保留一份正式源码**。学习日志仅链接源码、记录关键错误及完成方式。
2. **不伪造学习成果**。保留原始错误与 [A] 原作、[B] 概要、[C] AI 补充之间的区别；历史交接并非全部聊天导出。
3. **一切以真实作答为准**。能编译不等于独立会写；不提前填充未来题目。
4. **不要为每道简单题新增文档**。只有有代表性的练习才形成独立源码或重点复习记录。

仓库协作遵循 [AGENTS.md](AGENTS.md)。[GitHub Actions](.github/workflows/java-basics.yml) 使用 JDK 25 检查现有示例的输出，并尝试逐个编译练习目录内的程序；它不代替人工判断学习程度。
