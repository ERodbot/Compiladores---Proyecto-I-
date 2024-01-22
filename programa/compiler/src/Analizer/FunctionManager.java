package Analizer;

import java.util.ArrayList;

public class FunctionManager {
    private static ArrayList<FunctionIdentifier> functionIdentifiers = new ArrayList<FunctionIdentifier>();
    public void addFunctionIdentifier(FunctionIdentifier identifierF){
        functionIdentifiers.add(identifierF);
    }

    public FunctionIdentifier functionActual() {
        return functionIdentifiers.get(functionIdentifiers.size() - 1);
    }

    public FunctionIdentifier findFunction(String id){
        for(FunctionIdentifier identifierF: functionIdentifiers){
            if (identifierF.getNombre().equals(id)) {
                return identifierF;
            }
        }
        return null;
    }
    public void isNoReturnForNonVoidFunc(){
        for (FunctionIdentifier identifierF: functionIdentifiers){
            if (!identifierF.isRetornaValor() && !(identifierF.getTipoRetorno()==TypeEx.NULL)){
                System.out.println("Error semántico: no se encontró un valor de retorno para la función:" + identifierF.getNombre() + "pese a haber sido declarada como " + identifierF.getTipoRetorno().toString());
            }
        }
    }
}
