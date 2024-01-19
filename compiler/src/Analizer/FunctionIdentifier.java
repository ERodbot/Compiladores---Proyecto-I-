package Analizer;

public class FunctionIdentifier {
    /* Define la firma de una funcion, es decir, su nombre y los tipos de sus parametros. 
     * Adicionalmente, se define el tipo de retorno de la funcion, y tiene un atributo
     * Indicando si la función logra retornar un valor o no.
    */
    private String nombre;
    private TypeEx tipoRetorno;
    private boolean retornaValor;
    private TypeEx[] tiposParametros;

    public FunctionIdentifier(String nombre, TypeEx tipoRetorno, boolean retornaValor, TypeEx[] tiposParametros) {
        this.nombre = nombre;
        this.tipoRetorno = tipoRetorno;
        this.retornaValor = retornaValor;
        this.tiposParametros = tiposParametros;
    }

    public String getNombre() {
        return nombre;
    }

    public TypeEx getTipoRetorno() {
        return tipoRetorno;
    }

    public boolean isRetornaValor() {
        return retornaValor;
    }

    public TypeEx[] getTiposParametros() {
        return tiposParametros;
    }

    public void addTipoParametro(TypeEx tipo) {
        TypeEx[] newTiposParametros = new TypeEx[tiposParametros.length + 1];
        for (int i = 0; i < tiposParametros.length; i++) {
            newTiposParametros[i] = tiposParametros[i];
        }
        newTiposParametros[tiposParametros.length] = tipo;
        tiposParametros = newTiposParametros;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void setTipoRetorno(TypeEx tipoRetorno) {
        this.tipoRetorno = tipoRetorno;
    }

    public void setRetornaValor(boolean retornaValor) {
        this.retornaValor = retornaValor;
    }

    public void setTiposParametros(TypeEx[] tiposParametros) {
        this.tiposParametros = tiposParametros;
    }
}

