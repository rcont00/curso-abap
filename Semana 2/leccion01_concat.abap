*CONCATENATE

**concatenation 1

DATA: lv_string_a TYPE string VALUE 'Hola, que tal estas?',
      lv_string_b TYPE string VALUE 'Bien, gracias.',
      lv_concatenation TYPE string,
      lv_concatenacion3 TYPE string.

      lv_concatenation = |{ lv_string_a } { lv_string_b }|.


** Concatenation: Method 2
    "creamos nueva variable directamente en la linea:lv_concatenacion2
    
    CONCATENATE lv_string_a lv_string_b INTO DATA(lv_concatenacion2) SEPARATED BY space.
       


** Concatenation: Method 3

lv_concatenacion3 = 'Hola' && ` ` && 'Juan'.
out->write( lv_concatenacion3 ).

**Result:

out->write( |Metodo 1 concatenacion es: {  lv_concatenation } | ). "R: Metodo 1 concatenacion es: Hola, que tal estas? Bien, gracias. 
out->write( |Metodo 2 concatenacion es: { lv_concatenacion2 }|  ). "R: Metodo 2 concatenacion es: Hola, que tal estas? Bien, gracias.
out->write( |Metodo 3 concatenacion es: { lv_concatenacion3 }|  ). "R: Metodo 3 concatenacion es: Hola Juan