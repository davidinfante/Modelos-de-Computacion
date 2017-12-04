	/**
	*		David Infante Casas
	*		3ro C / C1
	*		Ejercicio c)
	*/

	/* ------------ Declaraciones ------------*/

%{
#include <stdio.h>
#include <stdlib.h>

int nmayus, nminus, nmezcl, nint, sumint, nfloat;
double sumfloat;
void escribir_datos(int dato1, int dato2, int dato3, int dato4, int dato5, int dato6, double dato7);
%}

%%

	/* ------------ Reglas ------------*/

[A-Z]+			{ nmayus++; }

[a-z]+			{ nminus++; }

([A-Z]?[a-z][A-Z][a-z]?)+		{ nmezcl++; }

[0-9]+		{ nint++; sumint += atoi(yytext); }

[0-9]+\.[0-9]+		{ nfloat++; sumfloat += atof(yytext); }

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

	nmayus = nminus = nmezcl = nint = sumint = nfloat = 0;
	sumfloat = 0;
	yylex();
	printf("\n");
	escribir_datos(nmayus, nminus, nmezcl, nint, sumint, nfloat, sumfloat);

	return 0;
}

void escribir_datos(int dato1, int dato2, int dato3, int dato4, int dato5, int dato6, double dato7) {
	printf("Num_sec_MAYUS=%d\tNum_sec_minus=%d\tNum_sec_mezcla=%d\nNum_enteros=%d\tSuma_int=%d\nNum_float=%d\tSum_float=%f\n", dato1, dato2, dato3, dato4, dato5, dato6, dato7);
}
