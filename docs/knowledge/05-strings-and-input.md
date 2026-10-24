# 字符串与输入

[知识目录](../concepts.md) · [前置：变量与分支](02-expressions-and-branches.md)

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

检验理解：输入结束、空行、`12x`、数字后的空格，与读取到一个合法整数，分别是什么情况？
