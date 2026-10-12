/**
 * 来源：docs/original-snippets.md A01 [A]。
 * [C] 整理者新增类、main、缩进、说明，不是用户原创完整程序。
 * 输出：2, 6, 12, 20, 30（逐行）。
 */
public class EvenRunningTotal {
    public static void main(String[] args) {
        // [A] 以下逻辑来自 A01，仅调整外层缩进。
        int sum = 0;
        for (int i = 1; i <= 10; i++) {
            if(i % 2 == 0){
                sum = sum + i;
                System.out.println(sum);
            }
        }
    }
}
