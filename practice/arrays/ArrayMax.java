/**
 * 第30题：求数组最大值。
 * [B] 完成状态由用户在 2026-10-13 同步请求中确认。
 * [C] 本文件的代码、测试数组和输出格式由 AI 整理，不是用户原始作答。
 */
public class ArrayMax {
    public static void main(String[] args) {
        // 非空全负测试数组：最大值不能初始化为0。
        int[] values = {-8, -3, -12, -5};
        int max = values[0];
        for (int i = 1; i < values.length; i++) {
            if (values[i] > max) {
                max = values[i];
            }
        }
        System.out.println(max);
    }
}
