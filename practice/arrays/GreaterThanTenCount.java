/**
 * 第27题：统计大于10的元素数量。
 * 本人编写的练习代码（依据本人来源澄清）；Codex 协助整理、排版和同步。
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
