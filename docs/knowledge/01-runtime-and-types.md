# 程序、变量与类型

[知识目录](../concepts.md) · [程序运行](../../practice/README.md#单独运行与调试)

> 知识说明 [C]，示例使用 JDK 25。相关原答：[A07 输出语法](../learning.md#a07)、[A08 年龄输入](../learning.md#a08)。

## 从源码到执行

程序把输入变成输出，中间依靠数据和规则。先明确“有什么数据、要得到什么、怎样转换”，再写语法。

通常的执行过程是 `.java 源码 → javac 编译 → .class 字节码 → JVM 执行`。JDK 提供编译器、启动器等开发工具；JVM 执行字节码。直接用 `java 文件.java` 时，源文件启动模式代为完成编译和运行。

本仓库沿用显式类与传统入口。例如把下列完整程序保存为 `Program.java`：

```java
public class Program {
    public static void main(String[] args) {
        int age = 18;
        System.out.println(age + 1);
    }
}
```

输出 `19`。公开类名 `Program` 对应文件名；`main` 是这里的启动入口；`String[] args` 接收命令行参数，不是键盘交互输入；`void` 表示方法不返回值。`public` 与 `static` 的含义见[对象](07-objects.md)。Java 25 还支持其他入口形式，这里保持与现有练习一致。参见 [Java 25 启动器](https://docs.oracle.com/en/java/javase/25/docs/specs/man/java.html)。

花括号组织代码块，分号结束语句；缩进不改变含义，却能显示结构。中文说明可以放在注释或字符串内，语法标点使用半角字符。原始片段 A07/A08 的点号、分号错误见[原答](../learning.md)。

### 类名、文件名、包与 import

文件是保存源码的单位，类是程序中的类型；简单练习的公开类 `Program` 放在 `Program.java`，启动时写类名 `Program`。`import java.util.Scanner;` 让源码能用简名 `Scanner`，不负责安装库，也不会创建扫描器对象；创建对象仍要执行 `new`。

项目变大时，`package` 给类型增加命名空间。例如声明属于 `study` 包的 `Program`，完整类名是 `study.Program`；使用 `javac -d out` 编译时，编译器会在 `out` 下按包组织输出。运行时用完整类名，并让 classpath 指向包含 `study` 目录的根目录。当前练习按已有[运行说明](../../practice/README.md)组织，不需要为每道小题提前增加包。名称规则见 [JLS 包与导入](https://docs.oracle.com/javase/specs/jls/se25/html/jls-7.html)。

## 变量是有类型的存储位置

`int age = 18` 包含三件事：类型 `int`、名字 `age`、初值 `18`。

赋值先计算右侧，再更新左侧，所以 `age = age + 1` 表示“取旧值，加1，写回”，不是数学恒等式。读程序时要随语句更新状态。

```java
int a = 3;
int b = a;
a = 8;
System.out.println(a + "," + b);
```

输出 `8,3`。这里复制了数值3，两个变量不会自动保持同步。数组变量保存引用，行为不同，见[数组与引用](04-arrays.md#reference)。

## 类型决定能存什么、能做什么

| 类型 | 典型用途 | 边界 |
| --- | --- | --- |
| `byte`、`short` | 小范围整数 | 分别为8、16位有符号整数 |
| `int` | 普通整数、下标、计数 | 32位，范围 −2³¹ 到 2³¹−1 |
| `long` | 更大整数 | 64位；较大的整数字面量加 `L` |
| `float`、`double` | 浮点近似计算 | 分别为32、64位；`float` 字面量常加 `F` |
| `char` | 一个 UTF-16 代码单元 | 16位；单引号，例如 `'A'` |
| `boolean` | 条件结果 | 只有 `true`、`false`，不能用0/1代替 |
| `String` | 文本 | 引用类型，双引号，例如 `"Java"` |

Java 有八种基本类型；`String`、数组和普通类是引用类型。一个可见字符未必只占一个 `char`，见[字符串](05-strings-and-input.md)。类型与初值规则参见 [JLS 第4章](https://docs.oracle.com/javase/specs/jls/se25/html/jls-4.html)。

局部变量在使用前必须明确赋值。`int score;` 只声明，不等于 `int score = 0;`。对象字段和新建数组元素有默认值，但这不能用于推断局部变量也自动初始化。

`final int limit = 10;` 表示赋值后不能再改这个变量。对引用变量，`final` 限制重新指向对象，不一定限制对象内部变化。

## 转换不会修复已经发生的计算

```java
int a = 5;
int b = 2;
double x = a / b;
double y = (double) a / b;
System.out.println(x + "," + y);
```

输出 `2.0,2.5`。第一行除法先按整数执行，结果2再转成 `double`；第二行在除法前转换了操作数。

强制转换也可能损失信息，例如 `(int) 2.9` 得到2。大范围整数转为小范围整数可能改变数值；“编译通过”不意味着数值仍准确。

<a id="floating-point"></a>

## 浮点数保存的是有限精度的近似值

下面是可放入 `main` 的独立片段：

```java
double total = 0.1 + 0.2;
System.out.println(total);
System.out.println(total == 0.3);
System.out.println(Math.abs(total - 0.3) < 1e-12);
```

依次输出 `0.30000000000000004`、`false`、`true`。原因是这些十进制小数的二进制表示需要舍入，不是 `+` 随机算错。最后一行检查绝对误差；`1e-12` 只是这个示例选定的容差，不能机械套用到所有数量级或用途。

先决定数据代表什么，再决定表示：个数通常用整数，近似测量可用浮点数；金额等要求精确十进制运算的需求，需要另外明确精度与舍入规则。`double` 还包括无穷大和 `NaN` 等特殊值，数值算法不能只检查“编译成功”；定义见 [JLS 浮点类型](https://docs.oracle.com/javase/specs/jls/se25/html/jls-4.html#jls-4.2.3)。

## 定位错误

| 现象 | 问题所在 | 先做什么 |
| --- | --- | --- |
| 编译失败 | 语法、名称、类型等不满足规则 | 看第一条错误及行号 |
| 运行抛异常 | 当前数据触发了非法操作 | 看异常类型、位置与输入 |
| 能运行但结果不对 | 程序规则与题意不符 | 手算小例子，找首个状态分歧 |

一次只缩小一个疑点：保留能复现问题的最小输入，写出预期；再用打印或调试器观察相关变量，找到第一处不同；只改与这个原因有关的代码，重跑原输入和一个边界输入。异常栈提供调用位置，优先找到属于自己源码的行，而不是只记住异常名称。编译失败后不要继续运行旧的 `.class` 文件，操作见[程序运行](../../practice/README.md)。

检验理解：为什么把整数除法的结果交给 `double` 仍可能没有小数部分？浮点误差与整数截断是同一种问题吗？遇到错误时，你能先给出一个最小输入与预期，而不是立即改很多行吗？

[知识目录](../concepts.md) · [相邻主题：运算与分支](02-expressions-and-branches.md)
