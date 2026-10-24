# 运算与分支

[知识目录](../concepts.md) · [前置：变量与类型](01-runtime-and-types.md)

## 表达式：由已有值产生新值

| 类别 | 写法 | 结果 |
| --- | --- | --- |
| 算术 | `+ - * / %` | 数值；`%` 是余数 |
| 比较 | `> >= < <= == !=` | `boolean` |
| 逻辑 | `&&`、`||`、`!` | 且、或、非 |
| 赋值 | `=`、`+=`、`-=` | 更新变量 |

`=` 写入值，`==` 比较。不能把数学连写 `0 < x < 10` 直接搬过来，应写 `0 < x && x < 10`。

整数除法向0截断，例如 `-5 / 2` 为 `-2`，`-5 % 2` 为 `-1`。因此偶数用 `n % 2 == 0`，判断任意正负奇数用 `n % 2 != 0`，不能只检查是否等于1。相关规则见 [JLS 表达式](https://docs.oracle.com/javase/specs/jls/se25/html/jls-15.html#jls-15.17)。

## 表达式的类型先于接收变量

```java
int a = 50000;
int b = 50000;
long wrong = a * b;
long right = (long) a * b;
System.out.println(wrong);
System.out.println(right);
```

依次输出 `-1794967296`、`2500000000`。第一行乘法在 `int` 中已经溢出，之后存入 `long` 无法恢复；第二行先扩大操作数范围。整数溢出通常不会自动抛异常，必要时可再了解 `Math.addExact` 等精确检查方法。

浮点数也有边界：很多十进制小数不能被二进制浮点精确表示。近似计算是否可接受应由题目决定，不把 `double` 当作任意精度的实数。

## 顺序与括号

乘除通常先于加减；复杂条件用括号表达意图，不靠猜优先级。字符串拼接还会改变 `+` 的含义：

```java
System.out.println(1 + 2 + "次");
System.out.println("次数：" + 1 + 2);
System.out.println("次数：" + (1 + 2));
```

依次输出 `3次`、`次数：12`、`次数：3`。从左到右看，每一步先确认当前是数值相加还是字符串拼接。

`i++` 与 `++i` 都加1，但作为表达式时分别产生旧值和新值。初学时把更新单独写一行，避免在一条语句中多次改变同一个变量。

## 分支：条件决定路径

```java
int score = 75;
if (score >= 90) {
    System.out.println("优秀");
} else if (score >= 60) {
    System.out.println("及格");
} else {
    System.out.println("未及格");
}
```

输出 `及格`，示例假定成绩已在合法范围内。`else if` 只在前面条件失败后才检查，因此第二个分支隐含了 `score < 90`。

多个独立 `if` 可以执行多段；一条 `if / else if / else` 链只选择其中一条路径。遇到“严格大于10”，边界10应排除，见[第27题](../../practice/arrays/GreaterThanTenCount.java)。

`if (条件);` 中的分号会结束这个 `if`，后面的代码块可能无条件执行。统一写花括号有助于辨认实际控制范围。

## 短路：只有必要时才算右边

```java
int denominator = 0;
if (denominator != 0 && 10 / denominator > 1) {
    System.out.println("满足");
} else {
    System.out.println("不满足");
}
```

输出 `不满足`，不会执行除以0。`&&` 左侧为假时停止，`||` 左侧为真时停止。因此“检查条件”和“依赖该条件的操作”有先后关系。布尔运算中的 `&`、`|` 会求值两侧，不能随意替换短路运算符。

## switch：按离散值选择

```java
int day = 2;
String label = switch (day) {
    case 1 -> "周一";
    case 2 -> "周二";
    default -> "其他日期";
};
System.out.println(label);
```

输出 `周二`。这里使用 Java 25 支持的 `switch` 表达式；箭头分支不向下穿透，表达式必须覆盖可能情况。区间判断通常用 `if` 更直接；旧式冒号分支要另外留意 `break`。参见 [JLS 分支语句](https://docs.oracle.com/javase/specs/jls/se25/html/jls-14.html#jls-14.11)。

检验理解：90分为什么不能先落入“≥60”的分支？“同时满足两个条件”和“满足任一条件”分别对应哪个运算符？
