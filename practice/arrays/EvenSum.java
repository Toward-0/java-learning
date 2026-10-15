/**
 * 第26题：数组中偶数求和。
 * 本人编写的练习代码（依据本人来源澄清）；Codex 协助整理、排版和同步。
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
