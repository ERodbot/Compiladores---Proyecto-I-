package Analizer;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class SymbolTableManager {
    public static HashMap<String, SymbolTable> listaTablasSimbolos = new HashMap<String, SymbolTable>();
    public static String currentHash = "";
    String MarkdownFilePath = (System.getProperty("user.dir") +"/testExamples/SymbolTable.md");
    
    public void imprimirTablaSimbolos(){
        System.out.println("Iniciando el guardado");
        for (String key: listaTablasSimbolos.keySet()){

            System.out.println("\n\n\n°-------------------------------------------------------------------------------------°");
            System.out.println("\n\t\t\t\tTabla de simbolos: " + key + "\n");
            System.out.println("\t~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            System.out.println("\t\t\t\t\tValores:");
            System.out.println("\t~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
            SymbolTable val = listaTablasSimbolos.get(key);
            System.out.println("\t\t" + String.format("%-20s %-20s %-20s", "valor", "tipo", "lexema") + "\n");
            for (SymbolTObj item: val.getSymbolTable()) {
                System.out.println("\t\t" + item.toString());
            }
            System.out.println("\n\t~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
            System.out.println("");
            System.out.println("°-------------------------------------------------------------------------------------°");
        }
        System.out.println("Completado el guardado");
    }


    public void guardarTablaSimbolos(){
        System.out.println("Iniciando el guardado");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(MarkdownFilePath))) {
            for (Map.Entry<String, SymbolTable> entry : listaTablasSimbolos.entrySet()) {
                writer.write("## " + entry.getKey() + "\n\n");
                writer.write("| Valor | Tipo | Lexema |\n");
                writer.write("|-------|------|--------|\n");
                for (SymbolTObj symbol : entry.getValue().getSymbolTable()) {
                    writer.write("| " + symbol.getValor() + " | " + symbol.getTipo() + " | " + symbol.getLexema() + " |\n");
                }
                writer.write("\n");
            }
            System.out.println("Markdown file created successfully: " + MarkdownFilePath);
        } catch (IOException e) {
            System.err.println("Error writing the file: " + e.getMessage());
        }
        System.out.println("Completado el guardado");
    }

    public void definirHash(String hash) {
        currentHash = hash;
        listaTablasSimbolos.put(hash, new SymbolTable());
    }

    public void anadirSimbolo(SymbolTObj sym){
        listaTablasSimbolos.get(currentHash).getSymbolTable().add(sym);
    }

    public TypeEx getIdType(String id, boolean isError, String line, String col){
       for(SymbolTObj sym : listaTablasSimbolos.get(currentHash).getSymbolTable()) {
            if (sym.getValor().equals(id)){
                return Expresion.tipoFromString(sym.getTipo()); }
        }
        if (isError){
            System.out.println("Error semántico: la variable con id: " + id +" en la linea " + line + "columna" + col +"no puede ser encontrado ");
        }
        return TypeEx.NULL; 
    }
    public void popPila(){
        listaTablasSimbolos.get(currentHash).controlStackPop();
    }
    public void pushPila(String cadena){
        listaTablasSimbolos.get(currentHash).controlStackPush(cadena);
    }
    public void validarScopeSalto(String line, String col,String tipoSalto){
        String top = listaTablasSimbolos.get(currentHash).controlStackNonIfTop();
        if (top == null){
            if (tipoSalto=="Return"){
                System.out.println("Error semántico: return fuera de estrucutra de control valida. " +  "en la linea " + line + " columna " + col);
            }
            if (tipoSalto=="Break"){  
                System.out.println("Error semántico: break fuera de estrucutra de control valida. " +  "en la linea " + line + " columna " + col);
            }
        }
    }

    
}
