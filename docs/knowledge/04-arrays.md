# 数组与遍历

[知识目录](../concepts.md) · [前置：循环](03-loops.md) · [现有程序](../learning.md#题目索引)

## 数组把同类型数据按位置组织起来

```java
int[] values = {10, 20, 30};
System.out.println(values.length);
System.out.println(values[1]);
values[1] = 25;
System.out.println(values[1]);
```

输出3、20、25，各一行。长度为 `n` 的数组合法下标是 `0` 到 `n-1`；`values[n]` 已经越界。`length` 是字段，没有括号。

`new int[3]` 创建长度3的数组，元素初值均为0。数组创建后长度不变，但元素可以改变；变量也可以重新指向另一个数组。规则参见 [JLS 数组](https://docs.oracle.com/javase/specs/jls/se25/html/jls-10.html)。

| 状态 | 含义 | 能否访问 length |
| --- | --- | --- |
| `new int[0]` | 有一个数组对象，元素数量为0 | 可以，结果0 |
| `null` | 没有指向数组对象 | 不可以，会抛空指针异常 |
| `new int[1]` | 有一个元素的数组 | 可以；唯一合法下标为0 |

<a id="reference"></a>

## 引用：赋值不等于复制数组

```java
int[] a = {3, 7};
int[] b = a;
b[0] = 9;
System.out.println(a[0]);
int[] c = a.clone();
c[0] = 1;
System.out.println(a[0] + "," + c[0]);
```

输出 `9`、`9,1`。`b = a` 复制引用，因此两个变量访问同一个数组；`clone()` 在这里创建了另一个 `int[]`。

这不表示所有对象都被深层复制。对象数组或二维数组中的元素本身也是引用，浅拷贝仍可能共享内部对象。理解当前的一维 `int[]` 后再扩展这个区别。

数组的 `==` 比较是否为同一个对象。比较两个 `int[]` 的元素内容可以用 `java.util.Arrays.equals(a, b)`；查看内容用 `java.util.Arrays.toString(a)`。参见 [Arrays 文档](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/util/Arrays.html)。

## 下标遍历与增强 for

```java
int[] values = {2, 4};
for (int value : values) {
    value = 0;
}
System.out.println(java.util.Arrays.toString(values));
for (int i = 0; i < values.length; i++) {
    values[i] += 1;
}
System.out.println(java.util.Arrays.toString(values));
```

输出 `[2, 4]`、`[3, 5]`。第一个循环把元素值复制给局部变量 `value`，重新赋值不会写回数组；第二个循环明确更新了数组元素。

只读取元素时，增强 `for` 更直接；需要位置、写回元素或控制遍历范围时，用下标。对象元素的局部变量保存引用，因此通过它修改对象内部状态，仍可能影响数组中对应对象。

<a id="accumulation"></a>

## 筛选、计数、求和

条件决定“哪些元素参与”，更新决定“统计什么”：

| 目标 | 初值 | 命中时更新 | 循环中的含义 |
| --- | --- | --- | --- |
| 计数 | `count = 0` | `count += 1` | 已处理部分的匹配数量 |
| 求和 | `sum = 0` | `sum += values[i]` | 已处理部分的匹配元素总和 |

尚未处理元素时，两者均为0。以[第26题](../../practice/arrays/EvenSum.java)数组的前四项为例，筛选偶数：

| 元素 | 是否参与 | 累计数量 | 累计总和 |
| --- | --- | --- | --- |
| -4 | 是 | 1 | -4 |
| -3 | 否 | 1 | -4 |
| 0 | 是 | 2 | -4 |
| 2 | 是 | 3 | -2 |

0增加数量却不改变总和，说明计数不能代替求和。条件中“严格大于”也不包含等于；组合筛选见[第28～29题](../../practice/arrays/filtered-stats/Main.java)。大范围数据还需留意[整数溢出](02-expressions-and-branches.md)。

## 最大值：初值来自问题本身

[第30题](../../practice/arrays/ArrayMax.java)维护的事实是：`max` 等于已处理部分的最大值。用首元素初始化后，第一个元素已经处理，因此从下标1继续。

新元素更大就替换，否则保留；两种情况都保持上述事实。对 `{-8, -3, -12, -5}`，初值0会错误地得到0，首元素初始化则得到-3。

前提是数组非空。空数组没有最大元素，不能无依据地返回0。未来封装方法时，要在“要求非空、抛异常或返回显式缺失结果”之间约定合同。[第31题](../../practice/arrays/ArrayMinMax.java)同时维护最大和最小值，无需改变这一原则。

## 查找：答案决定何时停止

[第32题](../../practice/independent/2026-10-14/Main.java)从左到右找第一个18。命中时，前面的位置已排除，可以 `break`。保存 `i` 才是位置；例如 `i=1` 时 `numbers[i]=18`，固定保存1只会碰巧通过某组数据。初值-1不属于合法下标，可表示未找到。

[第33题](../../practice/independent/2026-10-22/Main.java)要求全部下标与次数，命中后仍需继续扫描。下标在命中时输出，最终次数在循环后输出。

完整扫描 `n` 个元素要检查 `n` 次，即线性工作量 `O(n)`；首个匹配可能提前结束，最坏仍检查 `n` 次。复杂度描述规模增大时的趋势，不是准确运行秒数。

检验理解：换成空数组、单元素、全负数、无匹配和重复匹配后，初值与停止条件是否仍符合题意？
