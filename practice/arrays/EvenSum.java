/**
 * 第26题：数组中偶数求和。
 * [C] 本文件的代码、测试数组和输出格式由 AI 整理，不是用户原始作答。
 */
public class EvenSum {
    public static void main(String[] args) {
        int[] values = {-4, -3, 0, 2, 7, 8};
        int sum = 0;
        for (int i = 0; i < values.length; i++) {
            if (values[i] % 2 == 0) {
                sum = sum + values[i];
            }
        }
        System.out.println(sum);
    }
}
