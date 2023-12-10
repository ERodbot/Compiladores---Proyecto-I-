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

//separator
Separator = ,

//literaldecimalinteger
LiteralDecimalInteger= (0|-?[1-9][0-9]*)

//literaldecimalfloat 
LiteralDecimalFloat= ({LiteralDecimalInteger})\.?[0-9]*

//unarian operators
Decrement = -{2}
Increment = \+{2}

//arithmetic binary operators
Sum= \+
Subtraction= \-
Multiplication=\*
Division=\/
Exponential=\*{2}
Modulo=%


/*Comments*/
SingleLineComment =  \@[^\@\n]*\@
/*MultipleLineComment*/
MultipleLineComment = \/_([^_]|_+[^_/])*_\/

//eol(end of line)
LineEnder = \n|\r|\r\n

//whitespace
Whitespace = {LineEnder} | [ \t\f]

//inputcharacter
InputCharacter= [^\t\f]

//identifier
Identifier= [A-Za-z_][A-Za-z0-9_]*


%state STRING
%%

//reserved words 

//types
<yyinitial> "integer"=              {return symbol(sym.NOEL)}
<yyinitial> "float"=                {return symbol(sym.NICOLAS)} 
<yyinitial> "string"=               {return symbol(sym.SANTA)}
<yyinitial> "char"                  {return symbol(sym.COLACHO)}
<yyinitial> "boolean"               {return symbol(sym.CLAUS)}

//control structures
<yyinitial> "if"=                  {return symbol(sym.ELFO)}                               
<yyinitial> "elif"=                {return symbol(sym.HADA)}  
<yyinitial> "else"=                {return symbol(sym.DUENDE)} 
<yyinitial> "for"=                 {return symbol(sym.ENVUELVE)} 
<yyinitial> "do"=                  {return symbol(sym.HACE)} 
<yyinitial> "until"=               {return symbol(sym.REVISA)} 
<yyinitial> "return"=              {return symbol(sym.ENVIA)} 
<yyinitial> "break"=               {return symbol(sym.CORTA)} 

//print,read
"print"=                           {return symbol(sym.NARRA)}
"read"=                            {return symbol(sym.ESCUCHA)}

//class types
<yyinitial> "public" =             {return symbol(sym.FESTIVAL)}
<yyinitial> "private" =            {return symbol(sym.FIESTA)}
<yyinitial> "abstract" =            {return symbol(sym.NAVIDAD)}

//relational operators
<yyinitial> "=="=                  {return symbol(sym.ALABASTRO)}
<yyinitial> "!="=                  {return symbol(sym.EVERGEEN)}
<yyinitial> ">"=                   {return symbol(sym.UPATREE)}
<yyinitial> "<"=                   {return symbol(sym.MINSTIX)}
<yyinitial> ">=="                   {return symbol(sym.MARY)}
<yyinitial> "<=="=                  {return symbol(sym.OPENSLAE)}

//logical operators
And = \^
Or = #
Not = !

//asignation
"<="                               {return symbol(sym.ENTREGA)}

//literaltrue
<yyinitial> "true"=                {return symbol(sym.l_t_CLAUS)}

//literalfalse
<yyinitial> "false"=               {return symbol(sym.l_f_CLAUS)}







<yyinitial> {
   "\"                             {string.setlenght(0); yybegin(STRING);}

   {SingleLineComment}             {/*skip*/}

   {MultipleLineComment}           {/*skip*/}

   /*decimal integer literal*/
   LiteralDecimalInteger           {return symbol(sym.l_NOEL)}

   /*decimal float literal*/
   LiteralDecimalFloat             {return symbol(sym.l_NICOLAS)}

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
    {Or}                           {return symbol(sym.MELCHOR)}
    {Not}                          {return symbol(sym.BALTASAR)}

    //parenthesis                 
    {LineTerminator}               {return symbol(sym.)}
    {LeftParenthesis}              {return symbol(sym.)}
    {RightParenthesis}             {return symbol(sym.)}
    {LeftBracket}                  {return symbol(sym.)}
    {RightBracket}                 {return symbol(sym.)}

    //eol(end of line)
    LineEnder                      {return symbol(sym.FINREGALO)} 

    //whitespace
    WhiteSpace                     {/*skip*/}

    //inputcharacter
    InputCharacter                 {/*skip*/}

    //identifier identifier        
    Identifier                     {return symbol(sym.PERSONA)}
}

<STRING> {
    \"                             { yybegin(yyinitial):
                                    return symbol(sym.string_literal,
                                    string.tostring()); }
    [^\n\r\"\\]+                   { string.append(yytext()); }
    \\t                            { string.append('\t' ); } 
    \\r                            { string.append('\r' ); }
    \\n                            { string.append('\n' ); }
    \\\"                           { string.append('\"' ); }
    \\                             { string.append( yytext() ); }
}


/* error fallback */
. {
    String errorMensaje = "Error léxico en la línea " + (yyline) + ", columna " + (yycolumn) + ": carácter no reconocido '" + yytext() + "'";
    return symbol(sym.ERROR, errorMensaje);
}




