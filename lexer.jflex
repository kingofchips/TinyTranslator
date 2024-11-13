package cup.example;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.Symbol;
import java.lang.*;
import java.io.InputStreamReader;

%%

%class Lexer
%implements sym
%public
%unicode
%line
%column
%cup
%char
%{
	

    public Lexer(ComplexSymbolFactory sf, java.io.InputStream is){
		this(is);
        symbolFactory = sf;
    }
	public Lexer(ComplexSymbolFactory sf, java.io.Reader reader){
		this(reader);
        symbolFactory = sf;
    }
    
    private StringBuffer sb;
    private ComplexSymbolFactory symbolFactory;
    private int csline,cscolumn;

    public Symbol symbol(String name, int code){
		return symbolFactory.newSymbol(name, code,
						new Location(yyline+1,yycolumn+1, yychar), // -yylength()
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength())
				);
    }
    public Symbol symbol(String name, int code, String lexem){
	return symbolFactory.newSymbol(name, code, 
						new Location(yyline+1, yycolumn +1, yychar), 
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength()), lexem);
    }
    
    protected void emit_warning(String message){
    	System.out.println("scanner warning: " + message + " at : 2 "+ 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
    
    protected void emit_error(String message){
    	System.out.println("scanner error: " + message + " at : 2" + 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
%}

Newline    = \r | \n | \r\n
Whitespace = [ \t\f] | {Newline}
Number     = [0-9]+

// comments
Comment = {EndOfLineComment}
EndOfLineComment = "//".*{Newline}
CommentContent = ( [^*] | \*+[^*/] )*

ident = ([:jletter:] | "_" ) ([:jletterdigit:] | [:jletter:] | "_" )*
qchar = ("'") . ("'")


%eofval{
    return symbolFactory.newSymbol("EOF",sym.EOF);
%eofval}

%state CODESEG

%%  

<YYINITIAL> {

  {Whitespace}   {                              }
  {Comment}      {                              }    
  
  "int"          { return symbolFactory.newSymbol("INT", INT); }
  "char"         { return symbolFactory.newSymbol("CHAR", CHAR); }
  "read"         { return symbolFactory.newSymbol("READ", READ); }
  "write"        { return symbolFactory.newSymbol("WRITE", WRITE); }
  "length"       { return symbolFactory.newSymbol("LENGTH", LENGTH); }
  
  "if"           { return symbolFactory.newSymbol("IF", IF); }
  "else"         { return symbolFactory.newSymbol("ELSE", ELSE); }
  "while"        { return symbolFactory.newSymbol("WHILE", WHILE); }
  "return"       { return symbolFactory.newSymbol("RETURN", RETURN); }
  
  "+"            { return symbolFactory.newSymbol("PLUS", PLUS); }
  "-"            { return symbolFactory.newSymbol("MINUS", MINUS); }
  "*"            { return symbolFactory.newSymbol("TIMES", TIMES); }
  "/"            { return symbolFactory.newSymbol("DIVIDE", DIVIDE); }
  
  "!="           { return symbolFactory.newSymbol("NEQUAL", NEQUAL); }
  "=="           { return symbolFactory.newSymbol("EQUAL", EQUAL); }
  "!"            { return symbolFactory.newSymbol("NOT", NOT); }
  ">"            { return symbolFactory.newSymbol("GREATER", GREATER); }
  "<"            { return symbolFactory.newSymbol("LESS", LESS); }
  "="            { return symbolFactory.newSymbol("ASSIGN", ASSIGN); }
  
  "("            { return symbolFactory.newSymbol("LPAR", LPAR); }
  ")"            { return symbolFactory.newSymbol("RPAR", RPAR); }
  "{"            { return symbolFactory.newSymbol("LBRACE", LBRACE); }
  "}"            { return symbolFactory.newSymbol("RBRACE", RBRACE); }
  "["            { return symbolFactory.newSymbol("LBRACK", LBRACK); }
  "]"            { return symbolFactory.newSymbol("RBRACK", RBRACK); }
  ";"            { return symbolFactory.newSymbol("SEMICOLON", SEMICOLON); }
  ","            { return symbolFactory.newSymbol("COMMA", COMMA); }
  
  {ident}        { return symbolFactory.newSymbol("NAME", NAME, yytext()); }
  {qchar}        { return symbolFactory.newSymbol("QCHAR", QCHAR, yytext()); }
  {Number}       { return symbolFactory.newSymbol("NUMBER", NUMBER, yytext()); }
}

