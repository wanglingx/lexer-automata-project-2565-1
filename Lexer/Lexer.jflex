import java.util.ArrayList;
import java.util.List;

%%
%class Lexer
%public
%unicode
%standalone

%{
    List<String> symbolTable = new ArrayList<String>();  
    String type[] = {"Operator","Semicolon","Parenthese","Keywords","Integer","Identifier","New Identifier","String"};

    static void printString(String type,String value){
        System.out.println(type+" : "+value);
    }
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
            printString(type[0],yytext());
        }
        
    /* SEMICOLON and PARENTHESE */
    {ParentheseAndSemicolon}
        {
            if(yytext().equals(";"))

                printString(type[1],yytext());

            else
                printString(type[2],yytext());
            
        }
        
    /* KEYWORDS */
    {Keywords}
        {
            printString(type[3],yytext());
        }

    /* INTEGER */
    {DecIntegerLiteral}
        { 
            printString(type[4],yytext());
        }

    {DecIntegerLiteral}{Identifier}
        {
            throw new Error("Illegal DecTntegerLiteral <"+yytext()+">");
        }

    /* IDENTIFIER */
    {Identifier}
        {
            boolean findIdentifier = false;
            String newIdentifier = yytext();
            //new iden checking
            if(symbolTable.size() > 0){
                for(int i = 0;i < symbolTable.size() ;i++){
                    if(newIdentifier.equals(symbolTable.get(i))){
                        findIdentifier = true;
                        break;
                    }
                }
            }

            if(findIdentifier){
                System.out.printf("Identifier : \"%s\" Already in symbol table\n", newIdentifier);
            }
            else{
                printString(type[6],newIdentifier);
                symbolTable.add(newIdentifier);
            }  
        }

    /*String*/
    {String}
    {
            printString(type[7],yytext()); 
    }
    {CommentContent}
        {}

    {WhiteSpace}
        {}
}
 /* error fallback */
    [^]                              
        { throw new Error("Illegal character <"+yytext()+">"); }
   