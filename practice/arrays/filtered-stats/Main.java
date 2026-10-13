/**
 * 第28～29题：大于10且为偶数的筛选、数量和总和，完整 Main 与输出格式。
 * [B] 完成状态由用户在 2026-10-13 同步请求中确认。
 * [C] 本文件的代码、测试数组和输出格式由 AI 整理，不是用户原始作答。
 */
public class Main {
    public static void main(String[] args) {
        int[] values = {10, 11, 12, 18, 7, 20};
        int count = 0;
        int sum = 0;
        System.out.print("符合条件的元素：");
        for (int i = 0; i < values.length; i++) {
            if (values[i] > 10 && values[i] % 2 == 0) {
                // 分隔符放在第二个及以后的元素之前，避免末尾多一个空格。
                if (count > 0) {
                    System.out.print(" ");
                }
                System.out.print(values[i]);
                count = count + 1;
                sum = sum + values[i];
            }
        }
        // 先结束元素行，再在循环外打印最终统计结果。
        System.out.println();
        System.out.println("数量：" + count);
        System.out.println("总和：" + sum);
    }
}
