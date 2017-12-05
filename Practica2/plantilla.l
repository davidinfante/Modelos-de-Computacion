	/**
	*		David Infante Casas
	*		3ro C / C1
	*/

	/**
	*
   *  ******* Embellecedor de textos y calculadora simple *******
   *
	*	El siguiente programa analiza el texto
	*	para darle un mejor formato mediante
	*	la adición de mayúsculas, espacios,
	*	puntos, etcétera donde corresponda.
	*	También elimina errores como números o
	*	mayúsculas en mitad de palabras donde
	*	no corresponde.
   * 
   * Además, si se escribe una operación matemática
   * simple entre números enteros (suma+, resta-,
   * multiplicación* o división/) entre símbolos #, 
   * en la cadena de salida se mostrará el resultado.
   * Ejemplos:
   * Entrada: #25+25# #50       -25#
   * Salida:      50                 25
	*
	*/

   /**
	*
   *  ******* Limitaciones del programa *******
   *
	*	El tamaño máximo del texto de entrada
	*  es de 9999 caracteres aunque puede ser
	*	aumentado el tamaño de la variable
	*	"cadena" en la sección de Declaraciones.
   * Lo mismo sucede con el número de operaciones que se almacenan.
	*	
	*	El programa no reconoce caracteres extraños
	*	como vocales con tildes, la interrogación: ¿, la
	* exclamación ¡ o la ñ.
   *
   * Al hacer uso de los signos + - * / para hacer operaciones,
   * el programa no los escribirá y los tomará como
   * signos de operación.
   *
   * El programa tiene dificultades para arreglar palabras
   * en las que aparezcan muchos números y mayúsculas
   * mezclados.
   * 
	*/


	/* ------------ Declaraciones ------------*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

char cadena[9999] = ""; //Cadena con el texto de salida
int operaciones[9999]; //Cadena con los resultados de las operaciones
char copia[99] = ""; //Cadena que copia del yytext de entrada solo los números para operar con ellos
int cont; //Contador de celdas utilizadas de cadena
int cont_o; //Contador de celdas utilizadas de operaciones
int cont_c; //Contador de celdas utilizadas de copia
int i; //Indice básico para iterar en bucles
int dato1, dato2, resultado; //Variables que almacenan los datos para operar sobre ellos
int operacion; //"Enum" que indicará el tipo de operación matemática que se requiere
void escribir_texto(char *, int, int *); //Función que muestra por pantalla el texto de entrada
%}

%%

	/* ------------ Reglas ------------*/

   /* Calculadora */

"#"[ ]*[0-9]+[ ]*   { memset(copia,0 , strlen(copia)); cont_c = 0; for (i = 1; i <= yyleng; ++i) { if (yytext != ' ' || yytext != '#') {copia[cont_c] = yytext[i]; ++cont_c;} } dato1 = atoi(copia); }
[ ]*[0-9]+[ ]*"#"  { memset(copia,0 , strlen(copia)); cont_c = 0; for (i = 0; i < yyleng; ++i) { if (yytext != ' ' || yytext != '#') {copia[cont_c] = yytext[i]; ++cont_c;} } dato2 = atoi(yytext); if (operacion == 0) {resultado = dato1 + dato2; } if (operacion == 1) { resultado = dato1 - dato2; } if (operacion == 2) {resultado = dato1 * dato2;} if (operacion == 3) {resultado = dato1 / dato2;} cadena[cont] = '#'; ++cont; operaciones[cont_o] = resultado; ++cont_o; }
"+"   { operacion = 0;}
"-"   { operacion = 1;}
"*"   { operacion = 2;}
"/"   { operacion = 3;}

	/* Poner mayúscula después de símbolo de fin de frase con símbolo de separación */

("?"|"!"|"."|".")([ ]|\n)[a-zA-Z]	{ cadena[cont] = yytext[0]; cont++; cadena[cont] = yytext[1]; cont++; cadena[cont] = toupper(yytext[2]); cont++; cadena[cont] = yytext[3]; ++cont; }
("?"|"!"|"."|".")([ ]|\n)[a-zA-Z][A-Z]+	{ cadena[cont] = yytext[0]; cont++; cadena[cont] = yytext[1]; cont++; cadena[cont] = toupper(yytext[2]); cont++; }

	/* Poner mayúscula después de símbolo de fin de frase sin símbolo de separación */

("?"|"!"|"."|".")[a-zA-Z]	{ cadena[cont] = yytext[0]; cont++; cadena[cont] = ' '; cont++; cadena[cont] = toupper(yytext[1]); cont++; cadena[cont] = yytext[2]; ++cont; }
("?"|"!"|"."|".")[a-zA-Z][A-Z]+	{ cadena[cont] = yytext[0]; cont++; cadena[cont] = ' '; cont++; cadena[cont] = toupper(yytext[1]); cont++; }

	/* Poner espacio después de símbolo y evitar ponerlo si ya está puesto*/

(","|";"|":")[ ]	{ cadena[cont] = yytext[0]; cont++; cadena[cont] = ' '; cont++; }
(","|";"|":")  { cadena[cont] = yytext[0]; cont++; cadena[cont] = ' '; cont++; }

	/* Quitar mayúsculas en mitad de palabras */

[A-Z][A-Z]+[a-z]  { if (cadena[cont-1] == '.' || cadena[cont-2] == '.' || cadena[cont-3] == '.') { cadena[cont] = yytext[0]; ++cont; } for (i = 1; i <= yyleng; i++) { if (yytext[i] >= 'a' && yytext[i] <= 'z') { cadena[cont] = yytext[i]; cont++; } } }
[a-z][A-Z]+  { for (i = 0; i <= yyleng; i++) { if (yytext[i] >= 'a' && yytext[i] <= 'z') { cadena[cont] = yytext[i]; cont++; } } }
[A-Z]+[a-z]+[A-Z]+   { for (i = 0; i <= yyleng; i++) { if (yytext[i] >= 'a' && yytext[i] <= 'z') { cadena[cont] = yytext[i]; cont++; } } }
[0-9]*[a-z]+[A-Z]+[0-9]+   { for (i = 0; i <= yyleng; i++) { if (yytext[i] >= 'a' && yytext[i] <= 'z') { cadena[cont] = yytext[i]; cont++; } } }

	/* Quitar números en mitad de palabras */

[0-9]+[a-z]	{ for (i = 0; i <= yyleng; i++) { if (yytext[i] >= 'a' && yytext[i] <= 'z') { cadena[cont] = yytext[i]; cont++; } } }
[0-9]+[A-Z]	{ for (i = 0; i <= yyleng; i++) { if (yytext[i] >= 'A' && yytext[i] <= 'Z') { cadena[cont] = yytext[i]; cont++; } } }
[a-z][0-9]+	{ for (i = 0; i <= yyleng; i++) { if (yytext[i] >= 'a' && yytext[i] <= 'z') { cadena[cont] = yytext[i]; cont++; } } }

	/* Poner punto si no hay otro símbolo y hacer \n */

[^ ("?"|"!"|"."|";"|":"|",")]\n	{ cadena[cont] = yytext[0]; cont++; cadena[cont] = '.'; ++cont; cadena[cont] = '\n'; ++cont; }
[^ ("?"|"!"|"."|";"|":"|",")]\n[a-z]	{ for (i = 0; i <= yyleng; i++) { cadena[cont] = yytext[i]; cont++; } }
[^ ("?"|"!"|"."|";"|":"|",")]\n[a-z][A-Z]	{ cadena[cont] = yytext[0]; cont++; cadena[cont] = '\n'; ++cont; yyless(2); }

   /* Capturar \n */

\n	{ cadena[cont] = '\n'; ++cont; }

   /* Capturar \t */

\t	{ cadena[cont] = '\t'; ++cont; }

   /* Capturar los espacios */

[ ] { cadena[cont] = ' '; ++cont; }

   /* Captura normal de texto */

[^ \t\n]	{ for (i = 0; i <= yyleng; i++) { cadena[cont] = yytext[i]; cont++; } }

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
   cont_o = 0;
   cont_c = 0;
	yylex();
	printf("\n");
	escribir_texto(cadena, cont, operaciones);
	printf("\n");

	return 0;
}

   /* Funcion que escribe el texto pasado como argumento en pantalla */

void escribir_texto(char * dato, int contador, int * ope) {
   int j = 0;
	for (i = 0; i < contador; ++i) {
      if (cadena[i] == '#') { printf("%d", ope[j]); ++j; }
		else {printf("%c", dato[i]);}
	}
}
