package Analizer;

import javax.sound.sampled.AudioFileFormat.Type;

enum TypeEx {
     INT,
     FLOAT,
     CHAR,
     STRING,
     BOOL,
     CHAR_ARRAY,
     INT_ARRAY,
     NULL
};

public class Expresion {
   private TypeEx type; 
   private Object value;
   private String direction;

   public Expresion(Object value, TypeEx type){
        this.type = type;
        this.value = value;
   }

   public Expresion(Object value, TypeEx type,String direction){
        this.type = type;
        this.value = value;
        this.direction = direction;
   }

   public Object getValue(){
     return this.value;
   }

   public void setValue(Object value){
     this.value = value;
   }

   public TypeEx getType(){
        return type;
   }

   public void setType(TypeEx type){
     this.type = type;
   }

   public static TypeEx tipoFromString(String tipo) {
     switch (tipo) {
         case "int":
             return TypeEx.INT;
         case "float":
             return TypeEx.FLOAT;
         case "string":
             return TypeEx.STRING;
         case "bool":
             return TypeEx.BOOL;
         case "char":
             return TypeEx.CHAR;
         case "char[]":
             return TypeEx.CHAR_ARRAY;
         case "int[]":
             return TypeEx.INT_ARRAY;
         default:
             return TypeEx.NULL;
     }
   }

   public static TypeEx toArray(TypeEx type){
     switch (type) {
            case INT:
                return TypeEx.INT_ARRAY;
            case CHAR:
                return TypeEx.CHAR_ARRAY;
            default:
                return TypeEx.NULL;
        }
   }

   public static TypeEx fromArr(TypeEx type){
        switch (type) {
            case INT_ARRAY:
                return TypeEx.INT;
            case CHAR_ARRAY:
                return TypeEx.CHAR;
            default:
                return TypeEx.NULL;
        }
    }

   public void setDirection(String direction){
        this.direction = direction;
   }

   public String getDirection(){
        return this.direction;
   }
}



