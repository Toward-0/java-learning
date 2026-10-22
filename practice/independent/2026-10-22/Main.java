public class Main{
public static void main(String[] args){

int[] numbers = {23,18,-5,18,42,18,0};
int index = -1;
int count = 0;
for(int i = 0;i < numbers.length;i++){
if(numbers[i] == 18){
index = i ;
count = count + 1;
System.out.println("找到18，下标为：" + index);
}
}

System.out.print("18总共出现了" + count + "次");
}
}
