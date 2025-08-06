*IF STATEMENT

"IF Statement 1:

DATA lv_num1 TYPE i VALUE 3.


IF lv_num1 = 5.
  out->write( 'la variable es 5' ). "No pasa nada porque lv_num1 = 3
ENDIF.

"IF Statement 2:

IF lv_num1 = 3. "Esto es correcto
  out->write( |La variable lv_num1 es { lv_num1 }| ). "R: La variable lv_num1 es 3
ENDIF.

"IF Statement 3, different variable name:

DATA lv_name  TYPE string VALUE 'Daniel'.


IF lv_name = 'Daniel'. "Es la correcta
  out->write( 'Hola Daniel!' ).
ELSEIF lv_name = 'Pedro'.
  out->write( 'Hola Pedro!' ). "Ignore
ELSE.
  out->write( 'No te conozco' ). "Ignore
ENDIF.


"""""""""""""""""""""""""""""""""""""""""""""""""""""
*28/07/25  - FUNCIONES DE CONTENIDO

"1. STRLEN( ) → Longitud de un texto

DATA(lv_texto) = 'Hola'.
DATA(lv_longitud) = strlen( lv_texto ).  " R: 4, contamos desde el 1.

"2. TO_UPPER( ) → Poner en MAYÚSCULAS

DATA(lv_nombre) = 'raul'.
lv_nombre = to_upper( lv_nombre ).  " R: 'RAUL'

"3. TO_LOWER( ) → Poner en minúsculas

DATA(lv_nombre) = 'DANIEL'.
lv_nombre = to_lower( lv_nombre ).  " R: 'daniel'

"4. CONDENSE → Eliminar espacios extra

DATA(lv_texto) = '  Hola     mundo  '.
CONDENSE lv_texto.  " R: 'Hola mundo'

"5. FIND → Buscar texto

DATA(lv_frase) = 'Me gusta ABAP'.
FIND 'ABAP' IN lv_frase.

"6. REPLACE → Cambiar texto

DATA(lv_texto) = 'Hola mundo'.
REPLACE 'mundo' WITH 'ABAP' INTO lv_texto.  " Resultado: 'Hola ABAP'


*¿Por qué son importantes?
*Porque cuando trabajes con datos de texto (como nombres, frases, códigos…), estas funciones te ahorran mucho trabajo y hacen que tu código sea más claro y más útil.

** Ejemplos de funciones de contenido comunes

DATA: lv_text    TYPE string,
          lv_pattern TYPE string.

    lv_text = 'El telefono del empleado es 688-345-987'.
    lv_pattern = `\d{3}-\d{3}-\d{3}`. "RegEx: Lo que queremos buscar en lv_text
    " `\d` → significa "un dígito" (número del 0 al 9)
    " `{3}` → dice que queremos exactamente 3 dígitos
    " `-` → los guiones literales


    IF contains( val = lv_text pcre = lv_pattern ). " PCRE = Perl Compatible Regular Expression
      out->write( 'el texto contiene un numero de telefono' ). "CORRECTO
    ELSE.
      out->write(  'no hay numero' ).
    ENDIF.




