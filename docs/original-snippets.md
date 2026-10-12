# 原始代码片段与纠错档案

[返回首页](../README.md) · [学习状态与日志](learning.md)

来源：学习者提供的 `CODEX_JAVA_LEARNING_HANDOFF.md`（2026-10-12）。这是部分历史对话的交接整理，并非全部聊天的逐字导出；本次未直接访问旧对话。

- **[A]** 交接资料确认的用户原始片段：下文 A01～A09 保留交接原貌，错误也保留。说明文字属于交接资料的解释，不是用户原话。
- **[B]** 学习进度与主题概要，见学习状态与日志。
- **[C]** 为运行而新增的类、main、测试数组和整理说明，见 practice 示例；不属于用户原创完整程序。


以下保留主要原始写法。没有外层类定义的片段，只能归档为“片段”，不能直接假装是完整 `.java` 文件。

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

说明：`numbers` 的声明没有包含在已找到的用户原始片段中。若 Codex 要创建可运行程序，需要另外补充测试数组，并标记其为教学包装代码 [C]。

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

教学记录：原句 `System.out println(i);` 缺少 `out` 与 `println` 之间的点号，正确写法为 `System.out.println(i);`。**将原句保存到 Markdown 纠错文档里，不要让这个错误导致工程无法编译。**

### A08. 输入年龄的早期片段（2026-09-18）

```java
Scanner scanner = new Scanner(System.in)；
System.out.println("请输入你的年龄：");
int age = scanner.nextInt();
int sum = age +1;
System.out.println("你今年"+age+"岁，明年"+sum+"岁。");
```

教学记录：第一行用了中文全角分号 `；`，会引起 Java 编译错误；缺少 `import`、类和 `main` 外壳；这能体现用户早期的真实写法。可在 Markdown 里并列注明改正方式，不要悄悄覆盖掉原始错误。

### A09. 其他可证实但非完整代码的填空（2026-10-08）

- 倒三角内层循环条件：`j <= 6-i`
- 输入 0 时的判断：`num == 0`
- 跳出循环：`break`（作为独立 Java 语句需补 `;`）

这些只是用户对助手所给代码框架的局部填空，不能标记为“用户独立完成了整份程序”。


## 核对与复习说明 [C]

- A01 依次输出 `2、6、12、20、30`，每个数字占一行；A02、A03 各输出一次 `25`。
- A04、A05 缺少原始数组数据，无法确认原练习的实际数值输出。示例中的数组和对应结果仅用于验证。
- A07 保留错误的 `System.out println(i);`，正确语句为 `System.out.println(i);`。
- A08 应先把全角 `；` 改为半角 `;`，再补 `import java.util.Scanner;`、类和 main 才能形成完整程序。这里不把补全后的程序列为原作。
- A09 是局部填空，不能作为独立完成整份程序的证明。

可运行版本与具体补充范围见[练习指南](../practice/README.md)。学习进度仅在[学习状态与日志](learning.md)统一维护；原始片段作为历史证据保留，不再复制到以后每份练习记录中。
