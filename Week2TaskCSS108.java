import java.io.*;
import java.util.*;


public class Solution {

    public static void main(String[] args) {
        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
    try{            
        Scanner scan = new Scanner(System.in);
        int input1 = scan.nextInt();
        int input2 = scan.nextInt();
        scan.close();
        System.out.println(divideInput(input1,input2));
    }catch(ArithmeticException e){
           System.out.println("java.lang.ArithmeticException: / by zero");       
    
    }catch(InputMismatchException e){
            System.out.println("java.util.InputMismatchException");          
    
    }
 }
   
  public static int divideInput(int input1, int input2)
  {
     int sum;
     sum = input1 / input2;
     return sum;
  }
}