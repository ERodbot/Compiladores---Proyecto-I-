package Main;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import Analizer.LexerCup;
import Analizer.Sintax;
import Analizer.sym;

import java_cup.Lexer;
import java_cup.runtime.Symbol;
import jflex.anttask.JFlexTask;

import java.io.IOException;


//Acá se genera el archivo Lexer.java, si se hacen modificaciones en los tokens o en el lexer.flex debería regenerarse el archivo
public class App {

    public static void main(String[] args) throws Exception {

        String pathLexerCup = System.getProperty("user.dir") + "/src/Analizer/LexerCup.flex";
        String[] pathS = { "-parser", "Sintax", (System.getProperty("user.dir") + "/src/Analizer/Sintax.cup") };
        generar(pathLexerCup, pathS);
        test(System.getProperty("user.dir") +"/testExamples/ejemplo código 1.sintactico 2.txt");
    }

    public static void generar(String pathLexerCup, String[] pathS) throws IOException, Exception {
        String[] paths = { pathLexerCup };
        jflex.Main.generate(paths);
        java_cup.Main.main(pathS);

        Path pathSym = Paths.get((System.getProperty("user.dir") + "/src/Analizer/sym.java"));
        if (Files.exists(pathSym)) {
            Files.delete(pathSym);
        }

        Files.move(Paths.get((System.getProperty("user.dir") + "/sym.java")),
                Paths.get((System.getProperty("user.dir") + "/src/Analizer/sym.java")));

        Path pathSin = Paths.get((System.getProperty("user.dir") + "/src/Analizer/Sintax.java"));
        if (Files.exists(pathSin)) {
            Files.delete(pathSin);
        }
        Files.move(Paths.get((System.getProperty("user.dir") + "/Sintax.java")),
                Paths.get((System.getProperty("user.dir") + "/src/Analizer/Sintax.java")));
    }

    public static void test(String scannerPath) throws IOException, Exception {

        String tokenListPath = (System.getProperty("user.dir") +"/testExamples/tokenList.txt");
        lexAnalize(tokenListPath, scannerPath);
        sintaxAnilize(scannerPath);

    }



    public static void sintaxAnilize(String scannerPath) throws IOException, Exception{
        Reader reader = new BufferedReader(new FileReader(scannerPath));
        reader.read();
        LexerCup lexer = new LexerCup(reader);
        
        reader = new BufferedReader(new FileReader(scannerPath));
        reader.read();
        lexer = new LexerCup(reader);
        Sintax sintax = new Sintax(lexer);
        sintax.parse();
    }


    public static void lexAnalize(String tokenListPath, String scannerPath) throws IOException, Exception{

        Reader reader = new BufferedReader(new FileReader(scannerPath));
        reader.read();
        LexerCup lexer = new LexerCup(reader);
        
        int i = 0;
        Symbol token;
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(tokenListPath))) {
            String header = String.format("%-20s %-20s %-20s %-20s %-20s %n", "Tipo de símbolo", "Símbolo", "Número de símbolo", "Línea", "Columna");
            String divider = "-------------------------------------------------------------------------------------------"; 

            writer.write(header);
            writer.write(divider + "\n");
            System.out.println(header);
            System.out.println(divider);
        
            while (true) {
                token = lexer.next_token();
        
                if (token.sym != 0) {
                    String symbolType = sym.terminalNames[token.sym];
                    String symbol = (token.sym == 16|token.sym==17) ? token.value.toString() : lexer.yytext();
                    int symbolNumber = token.sym;
                    int line = token.left;
                    int column = token.right;
        
                    // Print table row
                    String row = String.format( "%-20s %-20s %-20s %-20d %-20d %n", symbolType, symbol.toString(), symbolNumber, line, column);
                    System.out.println(row);
                    writer.write(row);
                    i++;
        
                    
                } else {
                    break;
                }
            }
            System.out.println("Cantidad de lexemas encontrados: " + i);
            System.out.println(divider + "\n\n\n");
            writer.write(divider);

        } catch (IOException e) {
            System.err.println("Error writing the file: " + e.getMessage());
        }
    }
    
}