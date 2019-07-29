%{
#include <stdio.h>

#define YYERROR_VERBOSE
void yyerror(const char *msg);

%}

%union {
    int     number;
    char    caracter;
    char*   string;
}

%start program
%token STRING ID NUMBER COUT ENDL CIN PUBLIC NAMOSAVI MOSAVI
%token PRIVATE PROTECTED INT FLOAT CHAR VOID DOUBLE BOOL
%token FOR WHILE IF ELSE SWITCH CASE BREAK DEFAULT DO RETURN
%token TRUE FALSE PRINTF STRUCT CLASS LEFTOP RIGHTOP KMOSAVI BMOSAVI
%token MOSAVII NAGHIZ BOZORGTARI KOOCHAKTARI NOGHTE SEMICOLON DONOGHTE PBAZ
%token PBASTE KBAZ KBASTE COMMA STAR MANFI DOMANFI JAM DOJAM JAMMOSAVI MANFIMOSAVI
%token ORS ANDS HASHS QUOTE TAGHSIM BBASTE BBAZ

%%

program:
	|Function
    |Declaration 
	|program Function
    |program Declaration 
;

Declaration: Type ID MOSAVI NUMBER SEMICOLON 
	| Assignment SEMICOLON  	
	| FunctionCall SEMICOLON  	
	| ArrayUsage SEMICOLON	
	| Type ArrayUsage SEMICOLON   
	| error	
;

WhileStatement: WHILE PBAZ Expression PBASTE Statement  
	| WHILE PBAZ Expression PBASTE KBAZ Statement KBASTE 
;

ForStatement: FOR PBAZ Declaration Expression SEMICOLON Expression PBASTE KBAZ Statement KBASTE
       | FOR PBAZ Expression SEMICOLON Expression SEMICOLON Expression PBASTE Statement
;

IfStatement : IF PBAZ Expression PBASTE Statement 
	| IF PBAZ Expression PBASTE Statement ElseStatement
;

SwitchStatement : SWITCH PBAZ ID PBASTE CaseStatement
		|SWITCH PBAZ ID PBASTE KBAZ CaseStatement KBASTE
		|SWITCH PBAZ ID PBASTE
;

CaseStatement : CASE Expression DONOGHTE Statement
			|CASE Expression DONOGHTE Statement CaseStatement
			|CASE Expression DONOGHTE CaseStatement
;

Statement:	Declaration
	| ForStatement Statement
	| WhileStatement
	| ForStatement
	| IfStatement
	| COutstatement
	| CInstatement
	| SwitchStatement
	| WhileStatement Statement
	| Declaration Statement
	| IfStatement Statement
	| COutstatement Statement
	| CInstatement Statement
	| RETURN Assignment SEMICOLON
	| BREAK
;

ElseStatement : ELSE Statement
	| ELSE KBAZ Statement KBASTE
;


COutstatement: COUT RIGHTOP STRING RIGHTOP ENDL
	|COUT RIGHTOP ID RIGHTOP ENDL
	|COUT RIGHTOP NUMBER RIGHTOP ENDL
;

CInstatement: CIN LEFTOP ID
	|CIN LEFTOP STRING
	|CIN LEFTOP NUMBER
;

Expression: Assignment
	| Expression KMOSAVI Expression 
	| Expression BMOSAVI Expression
	| Expression NAMOSAVI Expression
	| Expression MOSAVII Expression
	| Expression BOZORGTARI Expression
	| Expression KOOCHAKTARI Expression
	| NAGHIZ Expression
	| ArrayUsage
;

Assignment: 
	| NUMBER 
	| ID
	| ArrayUsage
	| ID MOSAVI Assignment
	| Type ID MOSAVI Assignment
	| ID MOSAVI FunctionCall
	| ID MOSAVI STRING
	| ArrayUsage MOSAVI Assignment
	| ID COMMA Assignment
	| NUMBER COMMA Assignment
	| ID KOOCHAKTARI Assignment
	| ID BOZORGTARI Assignment
	| ID BMOSAVI Assignment
	| ID KMOSAVI Assignment
	| ID JAM Assignment
	| ID MANFI Assignment
	| ID STAR Assignment
	| ID TAGHSIM Assignment
	| ID DOJAM Assignment
	| NUMBER JAM Assignment
	| NUMBER MANFI Assignment
	| NUMBER STAR Assignment
	| NUMBER TAGHSIM Assignment	
	| PBAZ Assignment PBASTE
	| MANFI PBAZ Assignment PBASTE
	| DOJAM
	| DOMANFI
;

Function: FunctionCall KBAZ Statement KBASTE 
		| Type FunctionCall KBAZ Statement KBASTE 
		| Type ID PBAZ ArgList PBASTE  KBAZ Statement KBASTE 
		| Type ID PBAZ  PBASTE  Statement  
		| ID PBAZ ArgList PBASTE Statement  
;
	
FunctionCall : ID PBAZ PBASTE
	| ID PBAZ Parameters PBASTE
;

Parameters: Parameters COMMA Parameter
	| Parameter
;

ArrayUsage: ID BBAZ NUMBER BBASTE
;

ArgList:  ArgList COMMA Arg
	| Arg
;
	
Arg: Type ID 	
;

Parameter: ID
;

Type: 
	| INT
	| BOOL
	| FLOAT
	| DOUBLE
	| CHAR
	| VOID
;

%%
#include "lex.yy.c"

void yyerror(const char *msg){
	extern yylineno;
	printf("ERROR(PARSER): %s  | Line: %d \n", msg, yylineno);
	}

int main()
{
/*
	#ifdef YYDEBUG
		yydebug = 1;
	#endif
*/
    char filename[100];
    gets(filename);
    yyin = fopen(filename,"r");
	printf("STARTING COMPILE...");
    if(!yyparse())
		printf("\nParsing complete\n");
	else{
		printf("\nParsing failed");
		printf(" %d\n", lineNumber);
	}
	fclose(yyin);
	getchar();
    return 0;
}
