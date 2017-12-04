	/**
	*		David Infante Casas
	*		3ro C / C1
	*		Ejercicio d)
	*/

	/* ------------ Declaraciones ------------*/

%{
#include <stdio.h>
#include <stdlib.h>

char cadena[999] = "";
int cont;
int i;
void escribir_datos(char *, int);
%}

%%

	/* ------------ Reglas ------------*/

[^ \t\n]+		{ for (i = yyleng; i >= 0; i--) { cadena[cont] = yytext[i]; cont++; } cadena[cont] = ' '; cont++; }

%%

	/* ------------ Procedimientos ------------*/

int main (int argc, char *argv[]) {

	if (argc == 2) {
		yyin = fopen (argv[1], "rt");
		if (yyin == NULL) {
			printf ("El fichero %s no se puede abrir\n", argv[1]);
			exit(-1);
		}
	}
	else yyin = stdin;

	cont = 0;
	yylex();
	printf("\n");
	escribir_datos(cadena, cont);
	printf("\n");

	return 0;
}

void escribir_datos(char * dato, int contador) {
	for (i = 0; i < contador; ++i) {
		printf("%c", dato[i]);
	}
}
