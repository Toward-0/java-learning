# 字符串与输入

[知识目录](../concepts.md) · [前置：变量与分支](02-expressions-and-branches.md)

> 知识说明 [C]，示例使用 JDK 25。相关原答：[A08 年龄输入](../learning.md#a08)。

## 文本、数值与引用

`18` 是整数，`"18"` 是字符串，`'1'` 是字符。看起来相近，不代表可以用相同运算。`Integer.parseInt("18")` 把文本解析成整数；`String.valueOf(18)` 把整数转换成文本。

字符串内容比较用 `equals`，引用是否相同用 `==`：

```java
String a = new String("Java");
String b = new String("Java");
System.out.println(a == b);
System.out.println(a.equals(b));
```

输出 `false`、`true`。字符串字面量可能共享对象，因此某些 `==` 比较碰巧为真，不能据此把它当作内容比较。

若变量可能为 `null`，`"Java".equals(name)` 比 `name.equals("Java")` 更安全；`null`、空字符串 `""`、只含空格的字符串是三种不同状态。

## 不可变：操作结果需要接住

```java
String text = "java";
text.replace("j", "J");
System.out.println(text);
String changed = text.replace("j", "J");
System.out.println(changed);
```

输出 `java`、`Java`。`replace` 不修改原对象，而是返回结果。`text = ...` 改变的是变量引用，不是让原字符串变成可变对象。

| 操作 | 示例 | 含义 |
| --- | --- | --- |
| 长度 | `text.length()` | UTF-16 代码单元数 |
| 取一单元 | `text.charAt(0)` | 返回 `char`，要求下标合法 |
| 截取 | `text.substring(1, 3)` | 左闭右开，包含1、不含3 |
| 查找 | `text.indexOf("a")` | 首个位置；未找到为-1 |
| 内容相等 | `text.equals(other)` | 比较字符串内容 |
| 去两端空白 | `text.strip()` | 返回去除相应空白后的结果 |

一个可见字符可能包含多个 UTF-16 代码单元，甚至多个 Unicode 码点；`length()` 不保证等于人眼看到的字符数。需要码点时再查 `codePointCount` 等 API。方法合同见 [String 文档](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/lang/String.html)。

反复拼接较多片段时，可用 `StringBuilder` 累积，最后 `toString()`；不必为短小的固定拼接提前增加结构。

## Scanner：按词与按行是不同读取方式

| 方法 | 消耗内容 |
| --- | --- |
| `nextInt()` | 一个可解析的整数 token |
| `next()` | 一个 token，默认按空白分隔 |
| `nextLine()` | 从当前位置到这一行结束，返回不含行分隔符的内容 |

下面是完整演示，用固定文本模拟输入，便于重复核对。保存为 `InputDemo.java`：

```java
import java.util.Scanner;

public class InputDemo {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner("18\nAda\n")) {
            int age = scanner.nextInt();
            String rest = scanner.nextLine();
            String name = scanner.nextLine();
            System.out.println(age);
            System.out.println("[" + rest + "]");
            System.out.println(name);
        }
    }
}
```

输出 `18`、`[]`、`Ada`。`nextInt()` 读取18后，当前位置仍在第一行结尾；第一次 `nextLine()` 得到这一行的剩余内容，本例为空。若18后还有文字，剩余内容就不是空字符串。

若约定“一行年龄、一行姓名”，也可统一用 `nextLine()`，再解析年龄，避免混合两种读取语义。真实键盘输入可用 `new Scanner(System.in)`；先检查是否还有输入、格式是否符合约定。格式错误与异常处理见[集合与异常](08-collections-and-exceptions.md#exceptions)。

关闭 `Scanner` 也可能关闭底层输入源。上例只关闭固定字符串上的扫描器；共享 `System.in` 时不要在别处仍需输入时提前关闭。行为依据 [Scanner 文档](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/util/Scanner.html)。

## 从读取到可用的小程序

先写清输入合同，再选择读取方式。下面练习约定：按空白分隔逐项读取学习时长，接受 `0` 到 `1440` 之间的整数分钟；遇到不合要求的项就提示并继续，读到第一个合法值后结束。范围来自本练习的约定，不是 `int` 的取值范围。

保存为 `StudyMinutesInput.java`，按[程序运行说明](../../practice/README.md)编译运行，再在终端输入：

```java
import java.util.Scanner;

public class StudyMinutesInput {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(System.in)) {
            System.out.println("请输入学习分钟数（0 到 1440）：");
            while (scanner.hasNext()) {
                if (!scanner.hasNextInt()) {
                    String invalid = scanner.next();
                    System.out.println("不是 int 范围内的整数：" + invalid);
                    continue;
                }

                int minutes = scanner.nextInt();
                if (minutes < 0 || minutes > 1440) {
                    System.out.println("分钟数必须在 0 到 1440 之间。");
                    continue;
                }

                System.out.println("已记录：" + minutes + " 分钟");
                return;
            }
            System.out.println("输入已结束，没有记录。");
        }
    }
}
```

这里分开处理三个问题：

- **还有没有输入**：`hasNext()` 判断后续是否有 token；交互输入时可能等待用户继续输入。空行和只有空白的行会被跳过，不等于输入结束。
- **能否读取为 int**：`hasNextInt()` 检查下一项，但不会消费它。检查失败后用 `next()` 取走该项，再继续循环；如果只反复检查同一项，程序就不能向前推进。
- **数值是否符合需求**：`-1`、`1441` 都能读成 `int`，但不符合本练习的范围。格式与业务条件是两层检查。

本例只接受第一个合法 token，例如输入 `30 60` 会记录 `30` 后结束，并没有验证“整行只能包含一个整数”。如果需求按行定义，就应按行读取和校验，而不是悄悄换成按词读取。方法行为可查 [Scanner 的 hasNextInt](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/util/Scanner.html#hasNextInt()) 与 [nextInt](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/util/Scanner.html#nextInt())。

这个完整程序拥有输入的整个生命周期，退出时关闭扫描器；若把读取逻辑移入还会被其他代码调用的方法，仍要遵守前文关于共享 `System.in` 的约定。

### 先预测再核对边界

下面是有限输入的检查用例；“输入结束”表示输入流到达末尾，不是键盘上仅按一次回车。固定输入或重定向输入更适合重复验证。

| 输入情况 | 除最初提示外的预期行为 |
| --- | --- |
| `30` | 记录 30 并结束 |
| `0` 或 `1440` | 接受边界值 |
| `-1 1441 30` | 两次范围提示，然后记录 30 |
| `12x 30` | 一次格式提示，然后记录 30 |
| `2147483648 30` | 第一项超出 int 范围，提示后记录 30 |
| 空输入，或只有空白后输入结束 | 显示输入结束，没有记录 |
| `12x` 后输入结束 | 提示该项格式不符，再显示输入结束 |

先分别预测每项会经过哪个分支，再运行核对。不看示例时，尝试把范围改为新的约定，并说明需要改哪些位置；随后解释为什么删除 `scanner.next()` 会让错误输入无法被越过。完整示例是知识说明 [C]，运行成功不直接记为独立掌握。

检验理解：输入结束、空行、`12x`、数字后的空格，与读取到一个合法整数，分别是什么情况？

[知识目录](../concepts.md) · [相关主题：方法与参数](06-methods.md)、[异常](08-collections-and-exceptions.md#exceptions)

