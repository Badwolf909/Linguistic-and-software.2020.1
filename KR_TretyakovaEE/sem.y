%{
#include <stdio.h>
#include <string.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif
#define INTEGER 288
extern YYSTYPE yylval;
extern FILE* yyin;
void yyerror (const char *str);
int yylex(void);
%}

%token KEY_VAR CONSTANT IDENTIFIER OPEN_SQUARE_BRACKET CLOSE_SQUARE_BRACKET MULTIPLY DIVIDE MINUS PLUS SEMICOLON COMMA ASSIGN OPEN_BRACKET CLOSE_BRACKET DELIMITER

%%

PROGRAM:
	VARIABLE_DECLARATION DESCRIPTION_OF_CALCULATION
;

DESCRIPTION_OF_CALCULATION:
	OPEN_SQUARE_BRACKET ASSIGNMENT_LIST CLOSE_SQUARE_BRACKET
	{printf("Begin"); printf("%s","\n"); printf("%s",$2); printf("End"); printf("%s","\n");}
;

VARIABLE_DECLARATION:
	KEY_VAR VARIABLE_LIST DELIMITER
	{printf($1); printf(" "); printf($2); printf("%s",$3); printf("\n");}
        
;

VARIABLE_LIST:
	IDENTIFIER
	| IDENTIFIER COMMA VARIABLE_LIST {$$ = strcat($1,","); $$ = strcat($$," "); $$ = strcat($$,$3);}
;

ASSIGNMENT_LIST:
	ASSIGNMENT {$$=strcat($1,"");}	
	| ASSIGNMENT ASSIGNMENT_LIST {$$=strcat($1,$2);}
;

ASSIGNMENT:
	IDENTIFIER ASSIGN EQUATION DELIMITER
        {$$ = strcat($1," "); $$ = strcat($$,$2); $$ = strcat($$," "); $$ = strcat($$,$3); $$ = strcat($$,"\n");}
;

EQUATION:
	UNARY_OPERATION SUB_EQUATION {$$ = strcat($1,$2);}
	| SUB_EQUATION
;

SUB_EQUATION:
	OPEN_BRACKET EQUATION CLOSE_BRACKET {$$ = strcat($1,$2); $$ = strcat($$,$3);}
	| OPERAND
	| SUB_EQUATION BINARY_OPERATION SUB_EQUATION {$$ = strcat($1,$2); $$ = strcat($$,$3);}
;

UNARY_OPERATION:
	MINUS
;

BINARY_OPERATION:
	MULTIPLY
	| DIVIDE
	| PLUS
	| MINUS
;

OPERAND:
	CONSTANT
	| IDENTIFIER
;

%%

void yyerror (const char *str)

{

fprintf(stderr,"Error: %s\n",str);

}

int main()

{

yyin = fopen("example.txt","r");

yyparse();

fclose(yyin);

return 0;

}
