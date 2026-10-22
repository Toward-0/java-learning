/**
 * 第31题：一个 for 循环求最大值和最小值。
 * [B] 完成状态由用户在 2026-10-13 同步请求中确认。
 * 本人代码，经 Codex 整理与同步；来源澄清见 docs/learning.md，不据此推断提示情况。
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
