%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char avaleKhat = 1;
char type[10], value[100],symboltype[10];
unsigned long int tokN=0, lineNumber=0, checker=0, t=0;
void printToken();
void tokenize(char* locType);
void addToList(char * type, char* var, unsigned long int e);
%}

words [a-zA-Z]
num [0-9]

%%
\"({words}|{num}|[ ])*\" { tokenize( "id");  printToken(); avaleKhat =  0 ;  }
[ \t]		{ avaleKhat = 0; }
[\n][ \t]*   		{ avaleKhat = 1; lineNumber++;}
cout|endl|cin|printf|enum	{ tokenize( "keyword");  printToken(); avaleKhat =  0 ;  }
asm|else|new|this|auto|enum|operator|throw|explicit|private|true|break|export|protected|try|case|extern|public|typedef|catch|false|register|typeid|reinterpret_cast|typename|class|for|return|union|const|friend|short|unsigned|const_cast|goto|signed|using|continue|if|sizeof|virtual|default|inline|static|delete|static_cast|volatile|do|long|struct|mutable|switch|while|dynamic_cast|namespace|template	{ tokenize( "keyword");  printToken(); avaleKhat =  0 ;  }
bool { checker = 1; strcpy(symboltype,"bool"); tokenize( "keyword");  printToken(); avaleKhat =  0 ;  }
char { checker = 1; strcpy(symboltype,"char"); tokenize( "keyword");  printToken(); avaleKhat =  0 ;  }
float { checker = 1; strcpy(symboltype,"float"); tokenize( "keyword");  printToken(); avaleKhat =  0 ;  }
wchar_t { checker = 1; strcpy(symboltype,"wchar"); tokenize( "keyword");  printToken(); avaleKhat =  0 ;  }
double { checker = 1; strcpy(symboltype,"double"); tokenize( "keyword");  printToken(); avaleKhat =  0 ;  }
void { checker = 1; strcpy(symboltype,"void"); tokenize( "keyword");  printToken(); avaleKhat =  0 ;  }
int { checker = 1; strcpy(symboltype,"int"); tokenize( "keyword");  printToken(); avaleKhat =  0 ;  }
{words}({words}|{num})* {
				if(checker){checker=0; addToList(symboltype, yytext, t); t++; }  tokenize( "id"); printToken(); avaleKhat =  0 ;	}
^"#include ".+ ;
{num}+.{num}+      	{ tokenize( "id"); printToken(); avaleKhat =  0 ; }
{num}+       	{ tokenize( "id"); printToken(); avaleKhat =  0 ; }

"<<"|">>"	{ 
		tokenize( "token");
		}
"<="|">="|"=="|"="|"!="|">"|"<"|"."|"\""|";"|":"|"("|")"|"{"|"}"|","|"*"|"-"|"--"|"+"|"++"|"+="|"-+"|"||"|"&&"|"_"|"#"  	{ tokenize( "token"); printToken(); avaleKhat =  0 ; }

\/\/.* ;	
\/\*(.*\n)*.*\*\/ ;
%%

int yywrap(){ return 0;} 
int main(){ 
    FILE *f;
	f = fopen("Symbol_Table.txt","w");
	fprintf(f,"#%lu \t %s \t %s \n",e, type, var);
    fclose(f);
    char filename[100];
    gets(filename);
    yyin = fopen(filename,"r");
	yylex();
    fclose(yyin);
    getchar();
    return 0;
}

void addToList(char * type, char* var, unsigned long int e){
	FILE *f;
	f = fopen("Symbol_Table.txt","a");
	fprintf(f,"#%lu \t %s \t %s \n",e, type, var);
	fclose(f);
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
}