# 类与对象

[知识目录](../concepts.md) · [前置：方法](06-methods.md)

> 后续查阅内容；例子为教学补充 [C]。

## 对象把状态与行为放在一起

如果一个实体有需要保存的状态，也有围绕状态进行的操作，就可以用对象表达。类描述结构与行为，对象是运行时的具体实例。

下面的完整程序保存为 `ObjectDemo.java`：

```java
class Counter {
    private int value;

    Counter(int initialValue) {
        this.value = initialValue;
    }

    void increment() {
        value++;
    }

    int getValue() {
        return value;
    }
}

public class ObjectDemo {
    public static void main(String[] args) {
        Counter a = new Counter(0);
        Counter b = new Counter(10);
        a.increment();
        a.increment();
        System.out.println(a.getValue() + "," + b.getValue());
    }
}
```

输出 `2,10`。两次 `new` 创建两个对象，各自有一个 `value`。`a.increment()` 改的是 `a` 指向的对象；如果写 `Counter b = a`，则会共享同一个对象，原理与数组引用相同。

## 字段、构造器、方法

| 概念 | 作用 | 本例 |
| --- | --- | --- |
| 字段 | 保存对象状态 | `value` |
| 构造器 | 建立初始状态 | `Counter(int initialValue)` |
| 方法 | 定义对象能做什么 | `increment()`、`getValue()` |
| `this` | 当前对象的引用 | `this.value` |

构造器与类同名，没有返回类型；写成 `void Counter(...)` 就成了普通方法。类没有声明任何构造器时，编译器才会隐式提供默认构造器；本例已有带参构造器，不能直接写 `new Counter()`。参见 [JLS 构造器](https://docs.oracle.com/javase/specs/jls/se25/html/jls-8.html#jls-8.8)。

## 封装：通过规则维护状态

`private` 限制外部直接访问字段；`public` 声明可公开访问的成员，具体还受所属类型等访问条件限制；没有写访问修饰符的普通成员通常在同包内可访问。

封装的价值不是多写几个 getter/setter，而是让改变状态的路径遵守规则。例如有范围限制的成绩，更新方法应统一检查范围；随意开放字段会让任何调用者绕过规则。

实例字段属于各个对象；`static` 字段属于类，在这些实例之间共享。实例方法有当前对象 `this`，静态方法没有，因此静态方法不能凭空访问某个实例的字段。参见 [JLS 字段与方法](https://docs.oracle.com/javase/specs/jls/se25/html/jls-8.html#jls-8.3)。

## 接口与多态：依赖能力

下面的完整程序保存为 `PolymorphismDemo.java`：

```java
interface Sound {
    String text();
}

class Bell implements Sound {
    @Override
    public String text() {
        return "ding";
    }
}

class Drum implements Sound {
    @Override
    public String text() {
        return "boom";
    }
}

public class PolymorphismDemo {
    public static void main(String[] args) {
        Sound sound = new Bell();
        System.out.println(sound.text());
        sound = new Drum();
        System.out.println(sound.text());
    }
}
```

输出 `ding`、`boom`。变量类型是 `Sound`，声明了调用者可使用的能力；实际实例决定被覆盖的实例方法如何执行。这里的多态不需要把每种对象都转换成它的具体类型。

| 术语 | 区别 |
| --- | --- |
| 重载 overload | 同名，不同参数列表，编译时选择适用方法 |
| 覆盖 override | 子类型提供实例方法的实现，普通动态调用取决于运行时对象 |
| 继承 `extends` | 类扩展父类；普通类只直接继承一个类 |
| 实现 `implements` | 类承诺提供接口能力，可以实现多个接口 |
| 组合 | 一个对象持有另一个对象，委托它完成工作 |

仅为复用几行代码而继承，可能建立不合适的类型关系。先判断“是一种”还是“拥有/使用”；后者通常更适合组合。`@Override` 让编译器检查是否真的覆盖了预期方法。接口规则见 [JLS 第9章](https://docs.oracle.com/javase/specs/jls/se25/html/jls-9.html)。

检验理解：两个变量与两个对象是否是一回事？`static` 字段为什么不适合保存每个对象各自不同的状态？
