package Main;


import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;



//Acá se genera el archivo Lexer.java, si se hacen modificaciones en los tokens o en el lexer.flex debería regenerarse el archivo
public class App {

    public static void main(String[] args) throws Exception {

        String pathLexerCup = System.getProperty("user.dir") + "/src/LexicalAnalizer/LexerCup.flex";
        String[] pathS = { "-parser", "Sintax", (System.getProperty("user.dir") + "/src/LexicalAnalizer/Sintax.cup") };
        generar(pathLexerCup, pathS);
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

}