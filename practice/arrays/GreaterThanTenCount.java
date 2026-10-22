/**
 * 第27题：统计大于10的元素数量。
 * [B] 完成状态由用户在 2026-10-13 同步请求中确认。
 * 本人代码，经 Codex 整理与同步；来源澄清见 docs/learning.md，不据此推断提示情况。
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
