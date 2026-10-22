/**
 * 第30题：求数组最大值。
 * [B] 完成状态由用户在 2026-10-13 同步请求中确认。
 * 本人代码，经 Codex 整理与同步；来源澄清见 docs/learning.md，不据此推断提示情况。
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
