%{
#include <stdio.h>
#include <string.h>
extern FILE* yyin;
void yyerror(const char *str);
int yylex(void);
%}

%token KEY_VAR CONSTANT IDENTIFIER OPEN_SQUARE_BRACKET CLOSE_SQUARE_BRACKET MULTIPLY DIVIDE MINUS PLUS SEMICOLON COMMA ASSIGN OPEN_BRACKET CLOSE_BRACKET DELIMITER

%%

PROGRAM:
	VARIABLE_DECLARATION DESCRIPTION_OF_CALCULATION
;

DESCRIPTION_OF_CALCULATION:
        OPEN_SQUARE_BRACKET ASSIGNMENT_LIST CLOSE_SQUARE_BRACKET 
;

VARIABLE_DECLARATION:
        KEY_VAR VARIABLE_LIST DELIMITER
;

VARIABLE_LIST:
	IDENTIFIER	
	| IDENTIFIER COMMA VARIABLE_LIST
;

ASSIGNMENT_LIST:
	ASSIGNMENT
	| ASSIGNMENT ASSIGNMENT_LIST
;

ASSIGNMENT:
	IDENTIFIER ASSIGN EQUATION DELIMITER
;

EQUATION:
	UNARY_OPERATION SUB_EQUATION
	| SUB_EQUATION
;

SUB_EQUATION:
	OPEN_BRACKET EQUATION CLOSE_BRACKET	
	| OPERAND	
	| SUB_EQUATION BINARY_OPERATION SUB_EQUATION
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
