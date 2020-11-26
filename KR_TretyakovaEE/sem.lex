%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
#ifndef YYSTYPE
#define YYSTYPE char*
#endif
#define INTEGER 288
//extern YYSTYPE yylval;
%}

%%

("Var")                 yylval=strdup(yytext);return KEY_VAR;
[0-9]+ 			yylval=strdup(yytext);return CONSTANT;
([a-zA-Z])+ 	        yylval=strdup(yytext);return IDENTIFIER;
(\[){1}			yylval=strdup(yytext);return OPEN_SQUARE_BRACKET;
(\]){1} 		yylval=strdup(yytext);return CLOSE_SQUARE_BRACKET;
(\*){1} 		yylval=strdup(yytext);return MULTIPLY;
(\/){1} 		yylval=strdup(yytext);return DIVIDE;
(\-){1} 		yylval=strdup(yytext);return MINUS;
(\+){1} 		yylval=strdup(yytext);return PLUS;
(\,){1} 		yylval=strdup(yytext);return COMMA;
(\=){1} 		yylval=strdup(yytext);return ASSIGN;
(\(){1}			yylval=strdup(yytext);return OPEN_BRACKET;
(\)){1} 		yylval=strdup(yytext);return CLOSE_BRACKET;
(\;){1}		        yylval=strdup(yytext);return DELIMITER;
\n
[ \t]+
%%

int yywrap()

{

return 1;

}
