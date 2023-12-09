package LexicalAnalizer;
import java_cup.runtime.Symbol;
%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ \t\r]+
newline=[\n]+
E=[@|!|$|&|\|`|~|*]+
Exponente = [eE] [\+\-]? 0|[1-9][0-9]*
%{
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
%}
%%

/* Definición de palabras reservadas */
"ARRAY" { yytext(); return new Symbol(sym.ReservadaArray, yychar, yyline, yytext()); }
"BEGIN" { yytext(); return new Symbol(sym.ReservadaBegin, yychar, yyline, yytext()); }
"BOOLEAN" { yytext(); return new Symbol(sym.ReservadaBoolean, yychar, yyline, yytext()); }
"BYTE" { yytext(); return new Symbol(sym.ReservadaByte, yychar, yyline, yytext()); }
"CASE" { yytext(); return new Symbol(sym.ReservadaCase, yychar, yyline, yytext()); }
"CHAR" { yytext(); return new Symbol(sym.ReservadaChar, yychar, yyline, yytext()); }
"CONST" { yytext(); return new Symbol(sym.ReservadaConst, yychar, yyline, yytext()); }
"DO" { yytext(); return new Symbol(sym.ReservadaDo, yychar, yyline, yytext()); }
"DOWNTO" { yytext(); return new Symbol(sym.ReservadaDownto, yychar, yyline, yytext()); }
"ELSE" { yytext(); return new Symbol(sym.ReservadaElse, yychar, yyline, yytext()); }
"END" { yytext(); return new Symbol(sym.ReservadaEnd, yychar, yyline, yytext()); }
"FALSE" { yytext(); return new Symbol(sym.ReservadaFalse, yychar, yyline, yytext()); }
"FILE" { yytext(); return new Symbol(sym.ReservadaFile, yychar, yyline, yytext()); }
"FOR" { yytext(); return new Symbol(sym.ReservadaFor, yychar, yyline, yytext()); }
"FORWARD" { yytext(); return new Symbol(sym.ReservadaForward, yychar, yyline, yytext()); }
"FUNCTION" { yytext(); return new Symbol(sym.ReservadaFunction, yychar, yyline, yytext()); }
"GOTO" { yytext(); return new Symbol(sym.ReservadaGoto, yychar, yyline, yytext()); }
"IF" { yytext(); return new Symbol(sym.ReservadaIf, yychar, yyline, yytext()); }
"IN" { yytext(); return new Symbol(sym.ReservadaIn, yychar, yyline, yytext()); }
"INLINE" { yytext(); return new Symbol(sym.ReservadaInline, yychar, yyline, yytext()); }
"INT" { yytext(); return new Symbol(sym.ReservadaInt, yychar, yyline, yytext()); }
"LABEL" { yytext(); return new Symbol(sym.ReservadaLabel, yychar, yyline, yytext()); }
"LONGINT" { yytext(); return new Symbol(sym.ReservadaLongInt, yychar, yyline, yytext()); }
"NIL" { yytext(); return new Symbol(sym.ReservadaNil, yychar, yyline, yytext()); }
"OF" { yytext(); return new Symbol(sym.ReservadaOf, yychar, yyline, yytext()); }
"PACKED" { yytext(); return new Symbol(sym.ReservadaPacked, yychar, yyline, yytext()); }
"PROCEDURE" { yytext(); return new Symbol(sym.ReservadaProcedure, yychar, yyline, yytext()); }
"PROGRAM" { yytext(); return new Symbol(sym.ReservadaProgram, yychar, yyline, yytext()); }
"READ" { yytext(); return new Symbol(sym.ReservadaRead, yychar, yyline, yytext()); }
"REAL" { yytext(); return new Symbol(sym.ReservadaReal, yychar, yyline, yytext()); }
"RECORD" { yytext(); return new Symbol(sym.ReservadaRecord, yychar, yyline, yytext()); }
"REPEAT" { yytext(); return new Symbol(sym.ReservadaRepeat, yychar, yyline, yytext()); }
"SET" { yytext(); return new Symbol(sym.ReservadaSet, yychar, yyline, yytext()); }
"SHORTINT" { yytext(); return new Symbol(sym.ReservadaShortInt, yychar, yyline, yytext()); }
"STRING" { yytext(); return new Symbol(sym.ReservadaString, yychar, yyline, yytext()); }
"THEN" { yytext(); return new Symbol(sym.ReservadaThen, yychar, yyline, yytext()); }
"TO" { yytext(); return new Symbol(sym.ReservadaTo, yychar, yyline, yytext()); }
"TRUE" { yytext(); return new Symbol(sym.ReservadaTrue, yychar, yyline, yytext()); }
"TYPE" { yytext(); return new Symbol(sym.ReservadaType, yychar, yyline, yytext()); }
"UNTIL" { yytext(); return new Symbol(sym.ReservadaUntil, yychar, yyline, yytext()); }
"VAR" { yytext(); return new Symbol(sym.ReservadaVar, yychar, yyline, yytext()); }
"WHILE" { yytext(); return new Symbol(sym.ReservadaWhile, yychar, yyline, yytext()); }
"WITH" { yytext(); return new Symbol(sym.ReservadaWith, yychar, yyline, yytext()); }
"WRITE" { yytext(); return new Symbol(sym.ReservadaWrite, yychar, yyline, yytext()); }


{espacio} |
"(*"~"*)" | 
"//"[^\r\n]*|
"{"~"}" {/*Ignore*/}

//Error string que esta en varias lineas
\"[^\"]*\n[^\"\n]*\" { yytext(); return new Symbol(sym.ReservadaWrite, yychar, yyline, yytext()); }

//Error string que abre comillas y no cierra o comentario que abre y no cierra
^\"[^\"\n]*$ { yytext(); return new Symbol(sym.Error, yychar, yyline, yytext()); }

//Error comentario que abre con { pero no cierra
^"{"[^"}"~]*$ { yytext(); return new Symbol(sym.Error, yychar, yyline, yytext()); }

//Error comentario que abre con (* pero no cierra
^"(\*"[^"\*)"~]*$ { yytext(); return new Symbol(sym.Error, yychar, yyline, yytext()); }

//Caso de cambio de linea y espacios en blanco
{newline} { yytext(); return new Symbol(sym.CambioLinea, yychar, yyline, yytext()); }


//Caracteres
\#[0-9]+ { yytext(); return new Symbol(sym.Caracter, yychar, yyline, yytext()); }




//Operadores
"=" { yytext(); return new Symbol(sym.OperadorIgual, yychar, yyline, yytext()); }
"," { yytext(); return new Symbol(sym.OperadorComa, yychar, yyline, yytext()); }
";" { yytext(); return new Symbol(sym.OperadorPuntoYComa, yychar, yyline, yytext()); }
"++" { yytext(); return new Symbol(sym.OperadorIncremento, yychar, yyline, yytext()); }
"--" { yytext(); return new Symbol(sym.OperadorDecremento, yychar, yyline, yytext()); }
">=" { yytext(); return new Symbol(sym.OperadorMayorOIgualQue, yychar, yyline, yytext()); }
">" { yytext(); return new Symbol(sym.OperadorMayorQue, yychar, yyline, yytext()); }
"<=" { yytext(); return new Symbol(sym.OperadorMenorOIgualQue, yychar, yyline, yytext()); }
"<" { yytext(); return new Symbol(sym.OperadorMenorQue, yychar, yyline, yytext()); }
"<>" { yytext(); return new Symbol(sym.OperadorDiferente, yychar, yyline, yytext()); }
"+" { yytext(); return new Symbol(sym.OperadorSuma, yychar, yyline, yytext()); }
"-" { yytext(); return new Symbol(sym.OperadorResta, yychar, yyline, yytext()); }
"*" { yytext(); return new Symbol(sym.OperadorMultiplicacion, yychar, yyline, yytext()); }
"/" { yytext(); return new Symbol(sym.OperadorDivision, yychar, yyline, yytext()); }
"(" { yytext(); return new Symbol(sym.OperadorParentesisIzquierdo, yychar, yyline, yytext()); }
")" { yytext(); return new Symbol(sym.OperadorParentesisDerecho, yychar, yyline, yytext()); }
"[" { yytext(); return new Symbol(sym.OperadorCorcheteIzquierdo, yychar, yyline, yytext()); }
"]" { yytext(); return new Symbol(sym.OperadorCorcheteDerecho, yychar, yyline, yytext()); }
":=" { yytext(); return new Symbol(sym.OperadorAsignacion, yychar, yyline, yytext()); }
"." { yytext(); return new Symbol(sym.OperadorPunto, yychar, yyline, yytext()); }
":" { yytext(); return new Symbol(sym.OperadorDosPuntos, yychar, yyline, yytext()); }
"+=" { yytext(); return new Symbol(sym.OperadorSumaAsignacion, yychar, yyline, yytext()); }
"-=" { yytext(); return new Symbol(sym.OperadorRestaAsignacion, yychar, yyline, yytext()); }
"*=" { yytext(); return new Symbol(sym.OperadorMultiplicacionAsignacion, yychar, yyline, yytext()); }
"/=" { yytext(); return new Symbol(sym.OperadorDivisionAsignacion, yychar, yyline, yytext()); }
">>" { yytext(); return new Symbol(sym.OperadorDesplazamientoDerecha, yychar, yyline, yytext()); }
"<<" { yytext(); return new Symbol(sym.OperadorDesplazamientoIzquierda, yychar, yyline, yytext()); }
"<<=" { yytext(); return new Symbol(sym.OperadorDesplazamientoIzquierdaAsignacion, yychar, yyline, yytext()); }
">>=" { yytext(); return new Symbol(sym.OperadorDesplazamientoDerechaAsignacion, yychar, yyline, yytext()); }
"NOT" { yytext(); return new Symbol(sym.OperadorNot, yychar, yyline, yytext()); }
"OR" { yytext(); return new Symbol(sym.OperadorOr, yychar, yyline, yytext()); }
"AND" { yytext(); return new Symbol(sym.OperadorAnd, yychar, yyline, yytext()); }
"XOR" { yytext(); return new Symbol(sym.OperadorXor, yychar, yyline, yytext()); }
"DIV" { yytext(); return new Symbol(sym.OperadorDiv, yychar, yyline, yytext()); }
"MOD" { yytext(); return new Symbol(sym.OperadorMod, yychar, yyline, yytext()); }


//Errores
//Error de string que empieza por numero
{D}{L}({L}|{D})* {yytext(); return new Symbol(sym.Error, yychar, yyline, yytext());}

//Error de string que empieza por simbolo raro
{E}({L}|{D})* {yytext(); return new Symbol(sym.Error, yychar, yyline, yytext());}

//Error de string que contiene simbolo raro
({L}|{D})*{E}{E}*({L}|{D})* {yytext(); return new Symbol(sym.Error, yychar, yyline, yytext());}

//Error de strings multilinea
\"[^\"\n]*\n[^\"\n]*\" {yytext(); return new Symbol(sym.Error, yychar, yyline, yytext());}

//Error flotante que no tiene nada antes del punto
\.{D}+ {yytext(); return new Symbol(sym.Error, yychar, yyline, yytext());}

//Error notacion cientifica que no tiene nada despues de la e
(-?)[0-9].[0-9][0-9]*E+$ {yytext(); return new Symbol(sym.Error, yychar, yyline, yytext());}

//Error notacion cinetifica sin nada despues del punto
(-?)[0-9].E(-?)[1-9][0-9]* {yytext(); return new Symbol(sym.Error, yychar, yyline, yytext());}

//Error notacion cientifica de punto despues de la E
(-?)[0-9].[0.9][0.9]*E(-?)[1-9]\.[0.9]* {yytext(); return new Symbol(sym.Error, yychar, yyline, yytext());}

//Error flotante que no tiene nada despues del punto
{D}*\. {yytext(); return new Symbol(sym.Error, yychar, yyline, yytext());}

{L}({L}|{D})* {
    yytext();
    if (yytext().length() < 128){
        return new Symbol(sym.Identificador, yychar, yyline, yytext());
    }
    return new Symbol(sym.Error, yychar, yyline, yytext());
}

//ENTEROS
0|[1-9][0-9]* {yytext(); return new Symbol(sym.Entero, yychar, yyline, yytext());}

//FLOTANTES
(0|[1-9][0-9]*)\.(0|[1-9][0-9]*) {yytext(); return new Symbol(sym.Flotante, yychar, yyline, yytext());}

//NOTACION CIENTIFICA
(-?)[0-9].[0.9][0.9]*E(-?)[1-9][0-9]* {yytext(); return new Symbol(sym.Flotante, yychar, yyline, yytext());}

//CARACTERES
\"[a-zA-Z0-9_]\" {yytext(); return new Symbol(sym.Caracter, yychar, yyline, yytext());}

//STRINGS
\"[a-zA-Z0-9_ ]+*\" {yytext(); return new Symbol(sym.String, yychar, yyline, yytext());}

. {yytext(); return new Symbol(sym.Error, yychar, yyline, yytext());}