/**
 * 第27题：统计大于10的元素数量。
 * [C] 本文件的代码、测试数组和输出格式由 AI 整理，不是用户原始作答。
 */
public class GreaterThanTenCount {
    public static void main(String[] args) {
        int[] values = {10, 11, 12, 18, 7, 20};
        int count = 0;
        for (int i = 0; i < values.length; i++) {
            if (values[i] > 10) {
                count = count + 1;
            }
        }
        System.out.println(count);
    }
}
