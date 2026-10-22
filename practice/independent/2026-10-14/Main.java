public class Main{
public static void main(String[] args) {

int[] numbers = {23,18,-5,18,42,0};
int index = -1;
for(int i = 0;i <numbers.length;i++){
if(numbers[i] == 18){
index = i;
break;
}
}
System.out.println(index);
}
}
