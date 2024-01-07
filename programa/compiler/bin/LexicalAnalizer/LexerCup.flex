package LexicalAnalizer;
import java_cup.runtime.*;


%%

%class LexerCup
%public
%unicode
%cup
%line
%column 



/**
    * This code gets added to the lexical analizer, working as a way to manage tokens and both strings and chars literals.
    * 
    * 
    * 
*/
%{
    StringBuffer string = new StringBuffer();

    StringBuffer charBuff = new StringBuffer();

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
RightKey= \}

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
Exponential=\*\*
Modulo=\~

//logical operators
And = \^
OrLogical = #
Not = \!


//Comments//
SingleLineComment =  \@{WhiteSpace}*[^\@\n]*
/*MultipleLineComment*/
MultipleLineComment = \/_([^_]|_+[^_/])*_\/

//eol(end of line)
LineEnder = \n|\r|\r\n

//whitespace
WhiteSpace = {LineEnder} | [ \t\f]

//identifier
Identifier= [A-Za-z_][A-Za-z0-9_]*


%state STRING

%state CHAR

%%

//reserved words 

//types
<YYINITIAL> "integer"              {return symbol(sym.NOEL, yytext());}
<YYINITIAL> "float"                {return symbol(sym.NICOLAS, yytext());} 
<YYINITIAL> "string"               {return symbol(sym.SANTA, yytext());}
<YYINITIAL> "char"                 {return symbol(sym.COLACHO, yytext());}
<YYINITIAL> "boolean"              {return symbol(sym.CLAUS, yytext());}

//control structures
<YYINITIAL> "if"                   {return symbol(sym.ELFO);}                               
<YYINITIAL> "elif"                 {return symbol(sym.HADA);}  
<YYINITIAL> "else"                 {return symbol(sym.DUENDE);} 
<YYINITIAL> "for"                  {return symbol(sym.ENVUELVE);} 
<YYINITIAL> "do"                   {return symbol(sym.HACE);} 
<YYINITIAL> "until"                {return symbol(sym.REVISA);} 
<YYINITIAL> "return"               {return symbol(sym.ENVIA);} 
<YYINITIAL> "break"                {return symbol(sym.CORTA);} 

//print,read
"print"                            {return symbol(sym.NARRA);}
"read"                             {return symbol(sym.ESCUCHA);}

//relational operators
<YYINITIAL> "=="                   {return symbol(sym.ALABASTRO);}
<YYINITIAL> "!="                   {return symbol(sym.EVERGEEN);}
<YYINITIAL> ">"                    {return symbol(sym.UPATREE);}
<YYINITIAL> "<"                    {return symbol(sym.MINSTIX);}
<YYINITIAL> ">=="                  {return symbol(sym.MARY);}
<YYINITIAL> "<=="                  {return symbol(sym.OPENSLAE);}

//asignation
"<="                               {return symbol(sym.ENTREGA);}

//void
"void"                             {return symbol(sym.SINREGALO, yytext());}

//null
"null"                             {return symbol(sym.NARIZROJA, yytext());}

//literaltrue
<YYINITIAL> "true"                 {return symbol(sym.l_t_CLAUS, yytext());}

//literalfalse
<YYINITIAL> "false"                {return symbol(sym.l_f_CLAUS, yytext());}

//main 
<YYINITIAL> "main"                 {return symbol(sym.MAINNAVIDAD);}

//function
<YYINITIAL> "function"             {return symbol(sym.RECORRIDO);}

//variables 
<YYINITIAL> "local"                {return symbol(sym.LOCALCOLOCARREGALO);}




<YYINITIAL> {
   \"                              { string.setLength(0); yybegin(STRING); }

   \'                              { charBuff.setLength(0); yybegin(CHAR);}

   {SingleLineComment}             {/*skip*/}

   {MultipleLineComment}           {/*skip*/}

   /*decimal integer literal*/
   {LiteralDecimalInteger}         {return symbol(sym.l_NOEL, yytext());}

   /*decimal float literal*/
   {LiteralDecimalFloat}           {return symbol(sym.l_NICOLAS, yytext());}

   /*unarian operators*/
   {Decrement}                     {return symbol(sym.GRINCH);}
   {Increment}                     {return symbol(sym.QUIEN);}
   
   //arithmetic binary operators     
    {Sum}                          {return symbol(sym.RODOLFO);}
    {Subtraction}                  {return symbol(sym.TRUENO);}
    {Multiplication}               {return symbol(sym.RELAMPAGO);}
    {Division}                     {return symbol(sym.JUGUETON);}
    {Exponential}                  {return symbol(sym.COMETA);}
    {Modulo}                       {return symbol(sym.CUPIDO);}

    //separator                    
    {Separator}                    {return symbol(sym.CHIMENEA);}

    //logical operators
    {And}                          {return symbol(sym.GASPAR);} 
    {OrLogical}                    {return symbol(sym.MELCHOR);}
    {Not}                          {return symbol(sym.BALTASAR);}

    //parenthesis                 
    {LineTerminator}               {return symbol(sym.FINREGALO);}
    {LeftParenthesis}              {return symbol(sym.ABRECUENTO);}
    {RightParenthesis}             {return symbol(sym.CIERRACUENTO);}
    {LeftBracket}                  {return symbol(sym.ABREEMPAQUE);}
    {RightBracket}                 {return symbol(sym.CIERRAEMPAQUE);}
    {LeftKey}                      {return symbol(sym.ABREREGALO);}
    {RightKey}                     {return symbol(sym.CIERRAREGALO);}

     //identifier identifier        
    {Identifier}                     {return symbol(sym.PERSONA, yytext());}

    //eol(end of line);
    {LineEnder}                      {/*skip*/} 

    //whitespace
    {WhiteSpace}                     {/*skip*/}

                     
}

<STRING> {
      \"                             { yybegin(YYINITIAL); 
                                       return symbol(sym.l_SANTA, 
                                       "\""+string.toString()+"\""); }
      [^\n\r\"\\]+                   { string.append( yytext() ); }
      \\t                            { string.append('\t'); }
      \\n                            { string.append('\n'); }

      \\r                            { string.append('\r'); }
      \\\"                           { string.append('\"'); }
      \\                             { string.append('\\'); }
      
}

<CHAR> {
    \' {
        if (charBuff.length() == 1 || (charBuff.length() == 2 && charBuff.charAt(0) == '\\')) {
            yybegin(YYINITIAL);
            return symbol(sym.l_COLACHO, "\'" + charBuff.toString() + "\'");
        } else {
            return symbol(sym.ERRORNOTRECOGNIZED);
        }
    }
    [^\n\r\'\\] {
        if (charBuff.length() == 0) {
            charBuff.append(yytext());
        } else {
            return symbol(sym.ERRORNOTRECOGNIZED);
        }
    }
    \\t | \\n | \\r | \\\'  {
        if (charBuff.length() == 0) {
            charBuff.append(yytext());
        } else {
            return symbol(sym.ERRORNOTRECOGNIZED);
        }
    }
}

[^]                                  {return symbol(sym.ERRORNOTRECOGNIZED);}



