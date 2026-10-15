/**
 * 第31题：一个 for 循环求最大值和最小值。
 * 本人编写的练习代码（依据本人来源澄清）；Codex 协助整理、排版和同步。
 */
public class ArrayMinMax {
    public static void main(String[] args) {
        // 非空数组；以首元素初始化两个极值。
        int[] values = {-8, -3, -12, -5};
        int max = values[0];
        int min = values[0];
        for (int i = 1; i < values.length; i++) {
            // 两个独立的判断，共用同一个循环。
            if (values[i] > max) {
                max = values[i];
            }
            if (values[i] < min) {
                min = values[i];
            }
        }
        System.out.println("最大值：" + max);
        System.out.println("最小值：" + min);
    }
}
