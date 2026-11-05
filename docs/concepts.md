# Java：知识目录

[当前任务](../current.md) · [学习记录](learning.md) · [首页](../README.md)

本目录及各章为知识说明 [C]，示例使用 JDK 25。目录表示已有资料，不表示本人已掌握；今天学什么以[当前任务](../current.md)为准。

查某道题的原理时，从下表的“关联记录”往返阅读；系统查阅时，按各章开头的前置链接补齐需要的概念。

## 语言基础

| 主题 | 内容 | 关联记录 |
| --- | --- | --- |
| [程序、变量与类型](knowledge/01-runtime-and-types.md) | 执行流程、类型、转换、错误定位 | [A07 输出语法](learning.md#a07) |
| [运算与分支](knowledge/02-expressions-and-branches.md) | 除法、溢出、拼接、短路、条件分支 | [27 阈值计数](learning.md#ex27) |
| [循环与状态](knowledge/03-loops.md) | 循环形式、控制转移、不变式、终止 | [A01～A03 累加](learning.md#循环与累加) |

## 数据与输入

| 主题 | 内容 | 关联记录 |
| --- | --- | --- |
| [数组与遍历](knowledge/04-arrays.md) | 下标、引用、统计、极值、查找 | [数组与统计](learning.md#数组与统计)、[极值与查找](learning.md#极值与查找) |
| [字符串与输入](knowledge/05-strings-and-input.md) | 内容比较、不可变性、Scanner | [A08 年龄输入](learning.md#a08) |

## 抽象与组织

| 主题 | 内容 |
| --- | --- |
| [方法与参数](knowledge/06-methods.md) | 合同、返回值、值传递、作用域 |
| [类与对象](knowledge/07-objects.md) | 状态、构造、封装、接口、多态 |
| [集合与异常](knowledge/08-collections-and-exceptions.md) | List、Set、Map、异常与资源管理 |

方法、对象、集合与异常为后续查阅内容；实际经历与证据见[学习记录](learning.md#阶段小结2026-10-22)。章末问题仅供按需自检。

## 怎样使用示例

每个 Java 代码块独立看待。标为“完整程序”的示例按所写公开类名保存为同名文件；其余是方法内片段，可分别放入传统 `main` 中运行。不要把不同块直接拼接成一个文件。

含多个顶层类型的完整程序（如 `ObjectDemo`、`PolymorphismDemo`）请先编译，再按含 `main` 的类名启动，见[知识示例运行方法](../practice/README.md#知识示例)。源文件启动模式会选择源文件中的首个顶层类，不一定是文件名对应的公开类，规则见 [Java 25 启动器](https://docs.oracle.com/en/java/javase/25/docs/specs/man/java.html#using-source-file-mode-to-launch-source-code-programs)。

先预测输出，再执行，再解释与预测不同的第一步。知识示例用于理解原理；本人原答及其核查结果统一保存在[学习记录](learning.md)。

各章附 Java 25 官方语言规范或 API 链接，进一步细节按需查证。
