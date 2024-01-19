package Analizer;
import java.util.ArrayList;

import java_cup.symbol;


public class SymbolTable {
    private ArrayList<SymbolTObj> symbolTable;
    private int currentSize;
    private ArrayList<String> controlStack = new ArrayList<String>();


    public SymbolTable(){
        this.symbolTable = new ArrayList<SymbolTObj>();
        this.currentSize = 0;
    }

    public ArrayList<SymbolTObj> getSymbolTable(){
        return symbolTable;
    }

    public void setSymbolTable(ArrayList<SymbolTObj> symbolTable){
        this.symbolTable = symbolTable;
    }

    public int getSize(){
        return currentSize;
    }

    public String controlStackTop(){
        if (controlStack.size() > 0){
            return controlStack.get(controlStack.size() -1 );
        }
        return null;
    }

     public String controlStackNonIfTop() {
        for (int i = controlStack.size() - 1; i >= 0; i--) {
            if (!controlStack.get(i).startsWith("if")) {
                return controlStack.get(i);
            }
        }
        return null;
    }

    public String controlStackPop(){
        if (controlStack.size() > 0){
            return controlStack.remove(controlStack.size() -1 );
        }
        return null;
    }

    public void controlStackPush(String value){
        controlStack.add(value);
    }

    public void increaseSize(int size){
        this.currentSize += size;
    }

    public void imprimirTablaSimbolos(){
        for (SymbolTObj value: symbolTable){
            System.out.println(value.toString());
        }
        System.out.println();
    }
}
