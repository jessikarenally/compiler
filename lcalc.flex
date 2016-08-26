/* --------------------------Usercode Section------------------------ */
   
import java_cup.runtime.*;
      
%%
   
/* -----------------Options and Declarations Section----------------- */

%class Lexer
%line
%column
%cup
   
%{   
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
   

compilation_unit = {package_statement} | {import_statement} | {type_declaration}
package_statement  = "package" {package_name}  ";" 
import_statement  = "import" {package_name}  "."  "*"  ";"  | {class_name} ";"  | {interface_name} ";"  
type_declaration  = {doc_comment} {class_declaration} ";"| {doc_comment} {interface_declaration} ";" 
doc_comment  =  "/**"  "... text ..."  "*/"  
class_declaration  = {modifier} "class" {identifier} "extends" {class_name} "implements" {interface_name} "," {interface_name}  "{"  < {field_declaration} > "}" 
interface_declaration  = {modifier} "interface" {identifier} "extends" {interface_name} "," {interface_name}  "{" {field_declaration}  "}"
field_declaration  = doc_comment  method_declaration | doc_comment constructor_declaration | doc_comment variable_declaration  | static_initializer |  ";" 
method_declaration  = modifier type identifier "(" parameter_list ")"  ""  "]" statement_block  /  modifier type identifier "(" parameter_list ")" ";" 

%%
/* ------------------------Lexical Rules Section---------------------- */
   
<YYINITIAL> {
   
    ";"                { return symbol(sym.SEMI); }
   
    "+"                { System.out.print(" + "); return symbol(sym.PLUS); }
    "-"                { System.out.print(" - "); return symbol(sym.MINUS); }
    "*"                { System.out.print(" * "); return symbol(sym.TIMES); }
    "/"                { System.out.print(" / "); return symbol(sym.DIVIDE); }
    "("                { System.out.print(" ( "); return symbol(sym.LPAREN); }
    ")"                { System.out.print(" ) "); return symbol(sym.RPAREN); }


   
    {dec_int_lit}      { System.out.print(yytext());
                         return symbol(sym.NUMBER, new Integer(yytext())); }
   
    {dec_int_id}       { System.out.print(yytext());
                         return symbol(sym.ID, new Integer(1));}
   
    {WhiteSpace}       { /* just skip what was found, do nothing */ }   
}

[^]                    { throw new Error("Illegal character <"+yytext()+">"); }