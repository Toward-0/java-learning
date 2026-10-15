/**
 * 第30题：求数组最大值。
 * 本人编写的练习代码（依据本人来源澄清）；Codex 协助整理、排版和同步。
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
