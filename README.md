# Modelos-de-Computacion

### Método de compilación:
- lex plantilla.l (si no se tiene lex, usar flex)
- gcc lex.yy.c –o prog –ll (gcc lex.yy.c –o prog –lfl en el caso de usar flex)
- ./prog <Nombre_Fichero>

## Práctica 1:
### 4 ejercicios básicos usando LEX
### Ejercicio 1:
Crear una plantilla en Lex para encontrar direcciones de correo electrónico, de páginas web, fechas, números de teléfono, matrículas, códigos postales y NIF en un fichero texto.

### Ejercicio 2:
Hacer una plantilla Lex que tras leer un texto nos diga el número de caracteres, palabras y líneas de dicho texto, entendiéndose por palabra toda secuencia de caracteres que no posea ni espacios ni tabuladores ni retornos de carro. Se supone que toda línea está acabada por un retorno de carro (\n).

### Ejercicio 3:
Hacer una plantilla Lex que lea un fichero de texto, realice las siguientes acciones y presente los resultados por pantalla:
- Contar el número de secuencias de caracteres escritas completamente en mayúsculas.
- Contar el número de secuencias de caracteres escritas completamente en minúsculas.
- Contar el número de secuencias de caracteres que mezclen mayúsculas y minúsculas.
- Contar el número de números enteros.
- Contar el número de números reales (Deberá aceptar números reales escritos con punto decimal (34.54, 3.00) y números con exponente (1.5E4, 2e- 4, ...))
- Calcular la suma de todos los números enteros encontrados.
- Calcular la suma de todos los números reales encontrados

### Ejercicio 4:
Hacer una plantilla Lex, de manera que se cifre el texto de entrada, convirtiendo cada palabra en su inversa. El concepto de palabra es el mismo que en el apartado b).
