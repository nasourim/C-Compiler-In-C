%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
char avaleKhat = 1;
char type[10], value[100];
unsigned long int tokN=0, lineNumber=0;
void printToken();
void tokenize(char* locType);
%}
%option yylineno
words [a-zA-Z]
num [0-9]+

%%
\"({words}|{num}|[ ])*\" { yylval.string = strdup(yytext); return STRING;  }
[ \t]		
[\n][ \t]*   		{ lineNumber++;}
cout 		{ return COUT; }
endl		{ return ENDL;}
cin 		{ return CIN;}
public		{ return PUBLIC;}
private		{ return PRIVATE;}
protected 	{ return PROTECTED;}
int			{ return INT;}
float 		{ return FLOAT;}
char 		{ return CHAR;}
void 		{ return VOID;}
double 		{ return DOUBLE;}
bool		{ return BOOL;}
for 		{ return FOR;}
while		{ return WHILE;}
if			{ return IF;}
else		{ return ELSE;}
switch		{ return SWITCH;}
case		{ return CASE;}
break		{ return BREAK;}
default		{ return DEFAULT;}
do			{ return DO;}
return		{ return RETURN;}
true		{ return TRUE;}
false		{ return FALSE;}
printf  	{ return PRINTF;}
struct 		{ return STRUCT;}
class 		{ return CLASS;}
^"#include ".+ ;

"<<"		{ return LEFTOP; }
">>" 		{ return RIGHTOP; }
"/" 		{ return TAGHSIM; }
"<="    	{ return KMOSAVI; }
">="    	{ return BMOSAVI; }
"=="    	{ return MOSAVII; }
"!="    	{ return NAMOSAVI; }
"="    	{ return MOSAVI; }
"!"			{ return NAGHIZ; }
">"			{ return BOZORGTARI; }
"<"			{ return KOOCHAKTARI; }
"."     	{ return NOGHTE;}
";"     	{ return SEMICOLON;}
":"     	{ return DONOGHTE;}
"("     	{ return PBAZ;}
")"     	{ return PBASTE;}
"{"     	{ return KBAZ;}
"}"     	{ return KBASTE;}
"["     	{ return BBAZ;}
"]"     	{ return BBASTE;}
","     	{ return COMMA;}
"*"     	{ return STAR;}
"-"     	{ return MANFI;}
"--"     	{ return DOMANFI;}
"+"     	{ return JAM;}
"++"     	{ return DOJAM;}
"+="     	{ return JAMMOSAVI;}
"-="     	{ return MANFIMOSAVI;}
"||"     	{ return ORS;}
"&&"     	{ return ANDS;}
"#"     	{ return HASHS;}
"\""     	{ return QUOTE;}
{words}		{ return ID; }
{words}({words}|{num})* { return ID ; }
{num}+.{num}+      	{ return NUMBER ; }
{num} { return NUMBER ; }
\/\/.* ;	
\/\*(.*\n)*.*\*\/ ;
%%

/*int main(){ 
    char filename[100];
    gets(filename);
    yyin = fopen(filename,"r");
	yylex();
    fclose(yyin);
    getchar();
    return 0;
}

void printToken(){
	if(avaleKhat == 1){
		if(tokN != 1){
			printf("\n");
		}
        printf("{ %s, %s} ",type,value);
    } else {
		printf(", { %s, %s} ",type,value);
	}
}

void tokenize(char* locType){
	strcpy(type,locType);
	strcpy(value,yytext);
	tokN++;
}*/