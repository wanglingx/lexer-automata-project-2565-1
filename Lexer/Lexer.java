import java.util.Scanner;

public class Lexer {
    static Scanner scan = new Scanner(System.in);

    public static void main(String[] args) {
        //if get from args
        if (args.length < 1) {
            System.out.println("Usage: java Lexer");
            return;
        }
        //if get from scanner
        String input = scan.nextLine();
        String[] arrInput = input.split("");
        for (String str : arrInput) {
            check_string(str);
        }

        //ArrayList<Token> string = lexeme();
        //split
        //loop checking
    }
    
    public static String check_string(String str) {
        String ans = "";
        //operator checking
        String operator[] = { "+", "-", "*", "/", "=", ">", ">=", "<", "<=", "==", "++", "--" };
       
        for (int i = 0; i <= operator.length; i++) {
            if (str.equals(operator[i])) {
                return ans = "Operator : " + operator[i];
            }
        }
       return ans;
    }
    
}