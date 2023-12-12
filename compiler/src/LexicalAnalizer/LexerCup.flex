package LexicalAnalizer;
import java_cup.runtime.*;


%%

%class Lexer
%public
%unicode
%cup
%line
%column 

%{
    StringBuffer string = new StringBuffer();

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

//LineTerminator
LineTerminator= \|

//Parenthesis
LeftParenthesis= \(
RightParenthesis= \)
LeftBracket= \[
RightBracket= \]
LeftKey= \{
RightKey= \}h

//separator
Separator= ,

//literaldecimalinteger
LiteralDecimalInteger= (0|-?[1-9][0-9]*)

//literaldecimalfloat 
LiteralDecimalFloat= ({LiteralDecimalInteger})\.?[0-9]*

//unarian operators
Decrement = --
Increment = \+\+

//arithmetic binary operators
Sum= \+
Subtraction= \-
Multiplication=\*
Division=\/
Exponential=\*{2}
Modulo=%

//logical operators
And = \^
OrLogical = #
Not = \!


//Comments//
SingleLineComment =  \@[^\@\n]*\@
/*MultipleLineComment*/
MultipleLineComment = \/_([^_]|_+[^_/])*_\/

//eol(end of line)
LineEnder = \n|\r|\r\n

//whitespace
WhiteSpace = {LineEnder} | [ \t\f]

//inputcharacter
InputCharacter= [^\t\f]

//identifier
Identifier= [A-Za-z_][A-Za-z0-9_]*


%state STRING

%%

//reserved words 

//types
<YYINITIAL> "integer"              {return symbol(sym.NOEL)}
<YYINITIAL> "float"                {return symbol(sym.NICOLAS)} 
<YYINITIAL> "string"               {return symbol(sym.SANTA)}
<YYINITIAL> "char"                 {return symbol(sym.COLACHO)}
<YYINITIAL> "boolean"              {return symbol(sym.CLAUS)}

//control structures
<YYINITIAL> "if"                   {return symbol(sym.ELFO)}                               
<YYINITIAL> "elif"                 {return symbol(sym.HADA)}  
<YYINITIAL> "else"                 {return symbol(sym.DUENDE)} 
<YYINITIAL> "for"                  {return symbol(sym.ENVUELVE)} 
<YYINITIAL> "do"                   {return symbol(sym.HACE)} 
<YYINITIAL> "until"                {return symbol(sym.REVISA)} 
<YYINITIAL> "return"               {return symbol(sym.ENVIA)} 
<YYINITIAL> "break"                {return symbol(sym.CORTA)} 

//print,read
"print"                            {return symbol(sym.NARRA)}
"read"                             {return symbol(sym.ESCUCHA)}

//class types
<YYINITIAL> "public"               {return symbol(sym.FESTIVAL)}
<YYINITIAL> "private"              {return symbol(sym.FIESTA)}
<YYINITIAL> "abstract"             {return symbol(sym.NAVIDAD)}

//relational operators
<YYINITIAL> "=="                   {return symbol(sym.ALABASTRO)}
<YYINITIAL> "!="                   {return symbol(sym.EVERGEEN)}
<YYINITIAL> ">"                    {return symbol(sym.UPATREE)}
<YYINITIAL> "<"                    {return symbol(sym.MINSTIX)}
<YYINITIAL> ">=="                  {return symbol(sym.MARY)}
<YYINITIAL> "<=="                  {return symbol(sym.OPENSLAE)}

//asignation
"<="                               {return symbol(sym.ENTREGA)}

//literaltrue
<YYINITIAL> "true"                 {return symbol(sym.l_t_CLAUS)}

//literalfalse
<YYINITIAL> "false"                {return symbol(sym.l_f_CLAUS)}







<YYINITIAL> {
   \"                             {string.setLength(0); yybegin(STRING);}

   {SingleLineComment}             {/*skip*/}

   {MultipleLineComment}           {/*skip*/}

   /*decimal integer literal*/
   {LiteralDecimalInteger}           {return symbol(sym.l_NOEL)}

   /*decimal float literal*/
   {LiteralDecimalFloat}             {return symbol(sym.l_NICOLAS)}

   /*unarian operators*/
   {Decrement}                     {return symbol(sym.GRINCH)}
   {Increment}                     {return symbol(sym.QUIEN)}
   
   //arithmetic binary operators     
    {Sum}                          {return symbol(sym.RODOLFO)}
    {Subtraction}                  {return symbol(sym.TRUENO)}
    {Multiplication}               {return symbol(sym.RELAMPAGO)}
    {Division}                     {return symbol(sym.JUGUETON)}
    {Exponential}                  {return symbol(sym.COMETA)}
    {Modulo}                       {return symbol(sym.CUPIDO)}

    //separator                    
    {Separator}                      {return symbol(sym.CHIMENEA)}

    //logical operators
    {And}                          {return symbol(sym.GASPAR)} 
    {OrLogical}                    {return symbol(sym.MELCHOR)}
    {Not}                          {return symbol(sym.BALTASAR)}

    //parenthesis                 
    {LineTerminator}               {return symbol(sym.FINREGALO)}
    {LeftParenthesis}              {return symbol(sym.ABRECUENTO)}
    {RightParenthesis}             {return symbol(sym.CIERRACUENTO)}
    {LeftBracket}                  {return symbol(sym.ABREEMPAQUE)}
    {RightBracket}                 {return symbol(sym.CIERRAEMPAQUE)}
    {LeftKey}                      {return symbol(sym.ABREREGALO)}
    {RightKey}                      {return symbol(sym.CIERRAREGALO)}

    //eol(end of line)
    {LineEnder}                      {return symbol(sym.FINREGALO)} 

    //whitespace
    {WhiteSpace}                     {/*skip*/}

    //inputcharacter
    {InputCharacter}                 {/*skip*/}

    //identifier identifier        
    {Identifier}                     {return symbol(sym.PERSONA)}
}

<STRING> {
    \"                             { yybegin(yyinitial):
                                    return symbol(sym.l_SANTA,
                                    string.tostring()); }
    [^\n\r\"\\]+                   { string.append(yytext()); }
    \\t                            { string.append('\t' ); } 
    \\r                            { string.append('\r' ); }
    \\n                            { string.append('\n' ); }
    \\\"                           { string.append('\"' ); }
    \\                             { string.append( yytext() ); }
}


/* error fallback */
[^] {
    String errorMensaje = "Error léxico en la línea " + (yyline) + ", columna " + (yycolumn) + ": carácter no reconocido '" + yytext() + "'";
    return symbol(sym.ERROR, errorMensaje);
}
