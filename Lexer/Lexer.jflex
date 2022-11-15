import java.util.ArrayList;
import java.util.List;

%%
%class Lexer
%public
%unicode
%standalone

%{
    static void printString(String type,String value){
        System.out.println(type+" : "+value);
    }

    List<String> symbolTable = new ArrayList<String>();  
    int countingIndetifier = 0;
    String type = "";
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]
TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
CommentContent       = {TraditionalComment} | {EndOfLineComment}
Identifier = [:jletter:] [:jletterdigit:]*
DecIntegerLiteral = 0 | [1-9][0-9]*

Operator = "+"|"-"|"*"|"/"|"="|">"|">="|"<"|"<="|"=="|"++"|"--"
ParentheseAndSemicolon = "("|")"|";"
Keywords = "if"|"then"|"else"|"endif"|"while"|"do"|"endwhile"|"print"|"newline"|"read"
String = \"{InputCharacter}*\"

%%
<YYINITIAL>{
    /* OPERATOR */
    {Operator}
        {
            type = "OPERATOR";
            printString(type,yytext());
        }
    /* SEMICOLON and PARENTHESE */
    {ParentheseAndSemicolon}
        {
            String type[] = {"SEMICOLON","PARENTHESE"};
            if(yytext().equals(";"))

                printString(type[0],yytext());

            else
                printString(type[1],yytext());
            
        }
    /* KEYWORDS */
    {Keywords}
        {
            type = "KEYWORDS";
            printString(type,yytext());
        }

    {DecIntegerLiteral}{Identifier}
        {
            throw new Error("Illegal DecTntegerLiteral <"+yytext()+">");
        }

    /* INTEGER */
    {DecIntegerLiteral}
        { 
            type = "INTEGER";
            printString(type,yytext());
        }

    /* IDENTIFIER */
    {Identifier}
        {
            boolean findIdentifier = false;
            String newIdentifier = yytext();
            //new iden checking
            if(symbolTable.size() > 0){
                for(int i = 0;i < countingIndetifier;i++){
                    if(newIdentifier.equals(symbolTable.get(i))){
                        findIdentifier = true;
                        break;
                    }
                }
            }

            if(findIdentifier){
                System.out.printf("IDENTIFIER : \"%s\" ALREADY IN SYMBOL TABLE\n",newIdentifier);
            }
            else{
                type = "NEW IDENTIFIER";
                printString(type,newIdentifier);
                symbolTable.add(newIdentifier);
                countingIndetifier += 1;
            }  
        }
    /*String*/
    {String}
    {
        type = "String";
            printString(type,yytext()); 
    }
    {CommentContent}
        {}

    {WhiteSpace}
        {}
}
 /* error fallback */
    [^]                              
        { throw new Error("Illegal character <"+yytext()+">"); }
   