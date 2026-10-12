/**
 * 来源：docs/original-snippets.md A04 [A]。
 * [C] 整理者新增类、main、缩进、说明及测试数组，不是用户原创完整程序。
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
