# 原始代码片段与纠错档案

[返回首页](../README.md) · [学习记录](learning.md) · [可运行示例](../practice/README.md)

来源：2026-10-12 提供的 `CODEX_JAVA_LEARNING_HANDOFF.md`，不是完整聊天逐字导出。A01～A09 按交接材料保留原始写法 [A]；说明属于整理文字 [C]，未补成完整原作。

### A01. 偶数累加，循环内打印中间结果（2026-09-24）

```java
int sum = 0;
for (int i = 1; i <= 10; i++) {
    if(i % 2 == 0){
        sum = sum + i;
        System.out.println(sum);
    }
}
```

说明：这段打印的是每次命中偶数后的**累计值**，而不只是最终总和；不能将其注释写成只输出一次。

### A02. 奇数累加：使用 if 筛选（2026-09-24）

```java
int sum = 0;
for (int i = 1; i <= 10; i++) {
    if(i % 2 != 0){
        sum = sum + i;
    }
}
System.out.println(sum);
```

### A03. 奇数累加：使用 i += 2（2026-09-24）

```java
int sum = 0;
for (int i = 1; i <= 10; i += 2) {
    sum = sum + i;
}
System.out.println(sum);
```

### A04. 数组求和逻辑片段（2026-10-09）

```java
int sum = 0 ;
for(int i = 0;i < numbers.length;i++) {
    sum = sum + numbers[i];
}
System.out.println(sum);
```

说明：`numbers` 的声明没有包含在已找到的用户原始片段中。可运行示例的测试数组由整理者补充 [C]。

### A05. 数组中偶数个数（不是偶数总和；2026-10-09）

```java
int count = 0;
for(int i = 0;i < values.length;i++){
    if(values[i] % 2 == 0){
        count = count +1;
    }
}
System.out.println(count);
```

说明：原题是**偶数计数**，不能把此代码误标为“数组中偶数之和”。`values` 数组的初始化不在这段原始代码里。

### A06. 数组创建（2026-10-09）

```java
int[ ] scores = new int[5];
```

### A07. 尚未修正的语法错误样本（2026-10-09）

```java
for (int i = 0; i < 5;i++) {
    System.out println(i);
}
```

教学记录：原句 `System.out println(i);` 缺少 `out` 与 `println` 之间的点号，正确写法为 `System.out.println(i);`。

### A08. 输入年龄的早期片段（2026-09-18）

```java
Scanner scanner = new Scanner(System.in)；
System.out.println("请输入你的年龄：");
int age = scanner.nextInt();
int sum = age +1;
System.out.println("你今年"+age+"岁，明年"+sum+"岁。");
```

教学记录：第一行用了中文全角分号 `；`，会引起 Java 编译错误；缺少 `import`、类和 `main` 外壳；这能体现用户早期的真实写法。

### A09. 其他可证实但非完整代码的填空（2026-10-08）

- 倒三角内层循环条件：`j <= 6-i`
- 输入 0 时的判断：`num == 0`
- 跳出循环：`break`（作为独立 Java 语句需补 `;`）

这些只是用户对助手所给代码框架的局部填空，不能标记为“用户独立完成了整份程序”。
