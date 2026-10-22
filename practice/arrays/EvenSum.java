/**
 * 第26题：数组中偶数求和。
 * [B] 完成状态由用户在 2026-10-13 同步请求中确认。
 * 本人代码，经 Codex 整理与同步；来源澄清见 docs/learning.md，不据此推断提示情况。
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
