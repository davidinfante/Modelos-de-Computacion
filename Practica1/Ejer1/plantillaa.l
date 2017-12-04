	/**
	*		David Infante Casas
	*		3ro C / C1
	*		Ejercicio a)
	*/

	/* ------------ Declaraciones ------------*/

%{
#include <stdio.h>
#include <stdlib.h>

int nweb, ndate, ntelf, nmat, npost, nnif;
void escribir_datos(int dato1, int dato2, int dato3, int dato4, int dato5, int dato6);
%}

%%

	/* ------------ Reglas ------------*/

(https:"//")?www\..+\..{2,3}			{ nweb++; }
(https:"//").*\..{2,3}								{ nweb++; }

[0-3]?[1-9](-|"/"|[ ])[0-1]?[1-9](-|"/"|[ ])[0-2]?[0-9]?[0-9]?[0-9]		{ ndate++; }

("+"[1-9]?[0-9]?[0-9]|"+1-"[1-9][0-9][0-9])?[ ]?[1-9][0-9][0-9][ ]?[0-9][0-9][ ]?[0-9][ ]?[0-9][ ]?[0-9][0-9]	{ ntelf++; }

[0-9][0-9][0-9][0-9](-|"/"|[ ])?[A-Za-z][A-Za-z][A-Za-z]		{ nmat++; }
[A-Za-z][A-Za-z][A-Za-z](-|"/"|[ ])?[0-9][0-9][0-9][0-9]		{ nmat++; }

[0-4][0-9][0-9][0-9][0-9]			{ npost++; }
5[0-2][0-9][0-9][0-9]					{ npost++; }

[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9](-|"/"|[ ])?[A-Za-z]		{ nnif++; }

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

	nweb = ndate = ntelf = nmat = npost = nnif = 0;
	yylex();
	printf("\n");
	escribir_datos(nweb, ndate, ntelf, nmat, npost, nnif);

	return 0;
}

void escribir_datos(int dato1, int dato2, int dato3, int dato4, int dato5, int dato6) {
	printf("Num_webs=%d\tNum_fechas=%d\tNum_telefonos=%d\nNum_matriculas=%d\tNum_codigos_postales=%d\tNum_NIF=%d\n", dato1, dato2, dato3, dato4, dato5, dato6);
}
