package Analizer;

public class SymbolT {
    private String lexema, tipo, valor;

    public SymbolT(String lex, String type, String val){
        lexema = lex;
        tipo = type;
        valor = val;
    }

    public String getLexema() {
        return this.lexema;
    }

    public String getValor() {
        return this.valor;
    }

    public String getTipo() {
        return this.tipo;
    }

    public String toString(){
        return String.format("%-20s %-20s %-20s", valor, tipo, lexema );
    }
}
