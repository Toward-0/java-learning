/**
 * 来源：docs/original-snippets.md A02 [A]。
 * 本人编写累加逻辑；[C] Codex 补充类、main、说明，并调整缩进。
 * 输出：25。
 */
public class OddSum {
    public static void main(String[] args) {
        // [A] 以下逻辑来自 A02，仅调整外层缩进。
        int sum = 0;
        for (int i = 1; i <= 10; i++) {
            if(i % 2 != 0){
                sum = sum + i;
            }
        }
        System.out.println(sum);
    }
}
