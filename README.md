# lexer-automata-project-2565-1
# Jflex installation 
1.Download jflex file and extracting file to your directory
2.edit jflex .bat file 
JAVA_HOME="your java jre or jdk" (example.C:\Program Files (x86)\Java\jdk1.8.0_291)
JFLEX+HOME="your jflex path" (example.C:\jflex-1.8.2)
and edit execute command to "java -Xmx128m -jar %JFLEX_HOME%\lib\jflex-full-1.8.2.jar %1 %2 %3 %4 %5 %6 %7 %8 %9"
3.add jflex/bin to your path on environment

# How to Execute on terminal
1. jflex Lexer.jflex
2. javac Lexer.java
3. java Lexer yourfile.txt
