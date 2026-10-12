/**
 * 来源：docs/original-snippets.md A05 [A]。
 * [C] 整理者新增类、main、缩进、说明及测试数组，不是用户原创完整程序。
 * 输出：4。
 */
public class EvenCount {
    public static void main(String[] args) {
        // [C] 测试数据，原始片段没有数组声明。
        int[] values = {-4, -3, 0, 2, 7, 8};
        // [A] 以下逻辑来自 A05，仅调整外层缩进。
        int count = 0;
        for(int i = 0;i < values.length;i++){
            if(values[i] % 2 == 0){
                count = count +1;
            }
        }
        System.out.println(count);
    }
}
