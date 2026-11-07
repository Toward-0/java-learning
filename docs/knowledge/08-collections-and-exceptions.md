# 集合与异常

[知识目录](../concepts.md) · [前置：对象](07-objects.md)

> 后续查阅内容 [C]，示例使用 JDK 25。先理解数组与方法，再按实际需要使用这些工具；示例运行成功不直接记为独立掌握。

## 集合：让数据组织符合问题

| 工具 | 关心的关系 | 常见用途 |
| --- | --- | --- |
| 数组 | 固定长度、按下标访问 | 已知数量的同类型数据 |
| `List` | 有顺序，允许重复 | 需要增删的序列 |
| `Set` | 元素不重复 | 判断是否出现过、去重 |
| `Map` | 键对应值，键不重复 | 按名称/编号查值、频次统计 |

`Map` 属于集合框架的一部分，但不是 `Collection` 的子接口。`HashSet`、`HashMap` 不承诺按插入顺序遍历，不能用“这次打印顺序恰好符合”当作规则。参见 [HashSet](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/util/HashSet.html) 与 [Map](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/util/Map.html) 的顺序约定。

泛型中的类型参数约束元素类型，例如 `List<Integer>`；不能写 `List<int>`。整数会在 `int` 与包装类型 `Integer` 间装箱/拆箱，拆箱 `null` 会抛异常，不等于得到0。

## List：下标与元素值要区分

```java
java.util.List<Integer> numbers = new java.util.ArrayList<>();
numbers.add(10);
numbers.add(20);
numbers.remove(Integer.valueOf(10));
System.out.println(numbers);
numbers.remove(0);
System.out.println(numbers.size());
```

输出 `[20]`、`0`。`remove(0)` 按下标删；`remove(Integer.valueOf(10))` 按元素值删，这里体现了重载。

常用操作是 `add`、`get(index)`、`set(index, value)`、`remove`、`size()`。数组用 `length`，字符串用 `length()`，集合通常用 `size()`，不要混写。

`ArrayList` 按下标读取通常是常数时间，末尾追加是均摊常数时间；中间插入/删除可能移动后面的元素，通常为线性时间。选择它是为了可变序列，不表示所有操作都同样快。参见 [ArrayList 文档](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/util/ArrayList.html)。

### 可修改性与遍历中的删除

`List` 声明的是操作合同，具体对象不一定允许修改。`List.of(...)` 创建不可修改且不允许 `null` 元素的列表；需要增删时，可以用它初始化新的 `ArrayList`。不可修改列表仍可能保存可变对象，不等于把每个元素也冻结，约定见 [List 文档](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/util/List.html)。

下面是可放入 `main` 的独立片段：

```java
java.util.List<Integer> original = java.util.List.of(1, 2, 2, 3);
java.util.List<Integer> editable = new java.util.ArrayList<>(original);
java.util.Iterator<Integer> iterator = editable.iterator();
while (iterator.hasNext()) {
    if (iterator.next() == 2) {
        iterator.remove();
    }
}
System.out.println(editable);
System.out.println(original);
```

输出 `[1, 3]`、`[1, 2, 2, 3]`。这里的 `ArrayList` 迭代器允许删除刚刚返回的元素；它与列表协调位置，因此连续两个2都能处理。不要在增强 `for` 遍历普通 `ArrayList` 时直接对列表增删，这可能破坏遍历并触发异常；异常检测也不应作为程序的正常控制逻辑。按下标正向删除时还要防止后继元素移动导致漏查。

复制列表复制的是元素引用；本例元素是不可变的 `Integer`，其他可变元素仍可能共享。数组中相同的问题见[引用与复制](04-arrays.md#reference)。

## Set 与 Map

```java
java.util.Set<Integer> seen = new java.util.HashSet<>();
seen.add(18);
seen.add(18);
seen.add(23);
System.out.println(seen.size());

java.util.Map<String, Integer> counts = new java.util.HashMap<>();
counts.put("Java", 1);
counts.put("Java", counts.get("Java") + 1);
System.out.println(counts.get("Java"));
System.out.println(counts.size());
```

输出2、2、1。`Set` 消除了重复的18；`Map` 第二次给同一键写入值，更新已有映射，而不是新增一对。

键可能不存在时，先约定缺失值的处理方式；计数常用 `getOrDefault(key, 0)`。对允许存 `null` 值的 Map，单看 `get` 返回 `null` 不能区分“无键”与“值为 null”，需要时用 `containsKey`。键值规则见 [Map 文档](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/util/Map.html)。

哈希集合依据相等性与哈希值识别元素/键。自定义对象若重写 `equals`，通常也必须配套重写 `hashCode`；当对象已作键时，不应随意改变参与这两者的字段。

<a id="exceptions"></a>

## 异常：把失败带回能处理的位置

异常使正常执行路径中断，并寻找匹配的处理代码。它与“计算得到一个普通结果”不同：无匹配返回-1可能是查找合同的一部分；访问越界则是非法操作。

```java
String input = "12x";
try {
    int number = Integer.parseInt(input);
    System.out.println(number);
} catch (NumberFormatException ex) {
    System.out.println("请输入整数");
}
```

输出 `请输入整数`。解析失败后不会继续执行 `println(number)`，而是转入匹配的 `catch`。处理应针对可预见失败，不用空 `catch` 把问题隐藏掉。

| 情况 | 例子 | 处理思路 |
| --- | --- | --- |
| 输入格式错误 | `NumberFormatException` | 明确反馈，必要时重新输入 |
| 访问不存在的位置 | `ArrayIndexOutOfBoundsException` | 检查边界与循环逻辑 |
| 对 null 调用方法 | `NullPointerException` | 检查对象来源与缺失约定 |
| 外部资源读写失败 | `IOException` | 处理失败，或向调用者声明传播 |

受检异常需要捕获或通过 `throws` 声明；`RuntimeException` 及其子类不强制这样做，`Error` 一系也属于非受检。是否受检与“是否严重”不是同一个判断。`throw` 抛出异常对象，`throws` 声明方法可能传播的类型。参见 [JLS 异常](https://docs.oracle.com/javase/specs/jls/se25/html/jls-11.html)。

对本方法拥有并应关闭的资源，可以使用 `try-with-resources`；退出块时自动关闭。共享资源的生命周期应由拥有者决定，见[Scanner 示例](05-strings-and-input.md)。

### 异常沿调用路径传播

若当前方法没有匹配的 `catch`，失败会沿调用路径交给调用者，而不是回到抛出位置继续下一行。完整程序保存为 `ExceptionFlowDemo.java`：

```java
public class ExceptionFlowDemo {
    static int parseNumber(String text) {
        try {
            return Integer.parseInt(text);
        } finally {
            System.out.println("本次解析结束");
        }
    }

    public static void main(String[] args) {
        System.out.println(parseNumber("12"));
        try {
            System.out.println(parseNumber("12x"));
        } catch (NumberFormatException ex) {
            System.out.println("输入无效");
        }
    }
}
```

依次输出 `本次解析结束`、`12`、`本次解析结束`、`输入无效`。成功返回与异常传播都会经过本例的 `finally`；第二次没有得到返回值，所以外层的数字打印没有执行。不要在 `finally` 中写新的 `return` 或随意抛出另一异常来覆盖原结果。需要关闭资源时优先用资源管理语法，普通 `finally` 不必强行出现在每个方法中。规则见 [JLS try 与 finally](https://docs.oracle.com/javase/specs/jls/se25/html/jls-14.html#jls-14.20.2)。

选择处理位置时，问“这里能做出什么有效决定”：输入层可以请求重试，计算层可以拒绝非法参数，负责文件操作的上层可以决定恢复备份或报告失败。捕获后返回0会把失败伪装成有效统计值；没有恢复办法时，应保留失败信息，而不是用空 `catch` 消除迹象。

检验理解：什么时候应该返回“没找到”，什么时候应拒绝非法输入？把示例中的输入换成空字符串或越界整数，先预测调用与处理顺序。另选一个集合操作，说明它要求什么可修改性、如何处理缺失，以及遍历时能否删除元素。

[知识目录](../concepts.md) · [相关主题：数组](04-arrays.md)、[方法](06-methods.md)、[对象](07-objects.md)
