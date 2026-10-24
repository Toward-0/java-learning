# 方法与参数

[知识目录](../concepts.md) · [前置：数组与引用](04-arrays.md#reference)

> 后续查阅内容；加入知识集合不表示已经独立掌握。

## 方法给一段行为定义边界

方法可以看成一份合同：**接收什么 → 在什么条件下处理 → 返回什么或改变什么**。它让调用者关注用途，而不必每次重读内部过程。

下面是完整程序，保存为 `MethodDemo.java`：

```java
public class MethodDemo {
    static int square(int number) {
        return number * number;
    }

    public static void main(String[] args) {
        int result = square(4);
        System.out.println(result + 1);
    }
}
```

输出17。`square` 返回16，调用者还可以继续使用它；若方法只打印16，调用者就没有拿到该数值。

| 部分 | 含义 |
| --- | --- |
| `int` | 返回类型 |
| `square` | 方法名 |
| `int number` | 形参：方法内部接收值的局部变量 |
| 调用中的 `4` | 实参：先求值，再传给方法 |
| `return` | 结束本次方法调用并返回结果 |

本例只用于小整数，乘法仍受 `int` 范围限制。方法名不能代替输入范围与行为约定。

`void` 方法没有返回值，可以用 `return;` 提前结束。非 `void` 方法正常结束时必须给出相应返回值。方法声明规则见 [JLS §8.4](https://docs.oracle.com/javase/specs/jls/se25/html/jls-8.html#jls-8.4)。

## Java 传递的是值

基本类型复制数值；引用类型复制引用值。两者都不是把调用者的变量本身交出去。

保存下面的完整程序为 `ParameterDemo.java`：

```java
public class ParameterDemo {
    static void changeNumber(int value) {
        value = 99;
    }

    static void changeArray(int[] values) {
        values[0] = 99;
        values = new int[] {7, 8};
    }

    public static void main(String[] args) {
        int number = 3;
        changeNumber(number);
        int[] data = {1, 2};
        changeArray(data);
        System.out.println(number);
        System.out.println(java.util.Arrays.toString(data));
    }
}
```

输出3、`[99, 2]`。第一种赋值只修改形参。第二种先通过复制的引用修改了共享数组，随后重新赋值形参，只让局部变量指向新数组，不会让调用者的 `data` 跟着重新指向。参数初始化见 [JLS §15.12.4.5](https://docs.oracle.com/javase/specs/jls/se25/html/jls-15.html#jls-15.12.4.5)。

## 作用域与副作用

在代码块内声明的局部变量，通常只在对应作用域内可用；退出后不能从外面直接访问。每次调用有各自的参数和局部状态。

返回计算结果、修改传入数组、打印文本是不同效果。命名和说明应体现它们，尤其要明确“是否修改输入”。能只返回值的计算方法通常更容易单独核对。

## static、重载与职责

- `static` 方法属于类，不依赖某个实例。当前工具式计算可从 `main` 直接调用同类的静态方法；实例方法见[对象](07-objects.md)。
- 重载是同名方法具有不同参数列表；不能仅靠返回类型区分两个方法。让同名方法保持相近语义，避免调用者猜测。
- 不是每两行代码都需要提取方法。当一段行为有独立含义、会重复使用，或输入输出值得单独核对时，再考虑封装。

检验理解：打印结果与返回结果有什么区别？为什么方法内改数组元素能影响调用者，而重新给形参赋数组却不能？
