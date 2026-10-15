/**
 * 来源：docs/original-snippets.md A04 [A]。
 * 本人编写求和逻辑；[C] Codex 补充类、main、说明及测试数组，并调整缩进。
 * 输出：8。
 */
public class ArraySum {
    public static void main(String[] args) {
        // [C] 测试数据，原始片段没有数组声明。
        int[] numbers = {3, -2, 7, 0};
        // [A] 以下逻辑来自 A04，仅调整外层缩进。
        int sum = 0 ;
        for(int i = 0;i < numbers.length;i++) {
            sum = sum + numbers[i];
        }
        System.out.println(sum);
    }
}
