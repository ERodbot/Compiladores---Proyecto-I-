package Main;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import LexicalAnalizer.LexerCup;

import java.io.BufferedWriter;
import java.io.FileWriter;

import java_cup.Lexer;
import LexicalAnalizer.sym;
import java_cup.runtime.Symbol;
import jflex.anttask.JFlexTask;


//Acá se genera el archivo Lexer.java, si se hacen modificaciones en los tokens o en el lexer.flex debería regenerarse el archivo
public class App {

    public static void main(String[] args) throws Exception {

        String pathLexerCup = System.getProperty("user.dir") + "/src/LexicalAnalizer/LexerCup.flex";
        String[] pathS = { "-parser", "Sintax", (System.getProperty("user.dir") + "/src/LexicalAnalizer/Sintax.cup") };
        generar(pathLexerCup, pathS);
        testLexer(System.getProperty("user.dir") +"/testExamples/example.txt");
    }

    public static void generar(String pathLexerCup, String[] pathS) throws IOException, Exception {
        String[] paths = { pathLexerCup };
        jflex.Main.generate(paths);
        java_cup.Main.main(pathS);

        Path pathSym = Paths.get((System.getProperty("user.dir") + "/src/LexicalAnalizer/sym.java"));
        if (Files.exists(pathSym)) {
            Files.delete(pathSym);
        }

        Files.move(Paths.get((System.getProperty("user.dir") + "/sym.java")),
                Paths.get((System.getProperty("user.dir") + "/src/LexicalAnalizer/sym.java")));

        Path pathSin = Paths.get((System.getProperty("user.dir") + "/src/LexicalAnalizer/Sintax.java"));
        if (Files.exists(pathSin)) {
            Files.delete(pathSin);
        }
        Files.move(Paths.get((System.getProperty("user.dir") + "/Sintax.java")),
                Paths.get((System.getProperty("user.dir") + "/src/LexicalAnalizer/Sintax.java")));
    }

    public static void testLexer(String scannerPath) throws IOException
    {
        Reader reader = new BufferedReader(new FileReader(scannerPath));
        reader.read();
        LexerCup lexer= new LexerCup(reader);
        int i = 0;
        Symbol token; 
        while(true)
        {
            token = lexer.next_token();

            if(token.sym !=0){
                System.out.println("Tipo de símbolo: "+ sym.terminalNames[token.sym]);
                System.out.println("Símbolo: "+lexer.yytext());
                System.out.println("Número de símbolo: "+token.sym);
                System.out.println("Encontrado en la línea "+token.left+ " y columna "+token.right);
                i++;
                System.out.println("Cantidad de lexemas encontrados: "+i);
                System.out.println("-----------------------------------------------------------");
                }
            
            else{
                break;
            }
        }

    }

}