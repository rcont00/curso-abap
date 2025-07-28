*CONCATENATE

**concatenacion 1

DATA: lv_string_a TYPE string VALUE 'Hola, que tal estas?',
      lv_string_b TYPE string VALUE 'Bien, gracias 2',
      lv_concatenacion TYPE string,
      lv_concatenacion3 TYPE string.

      lv_concatenacion = |concatenacion 1: { lv_string_a } { lv_string_b }|.
      out->write( |El valor de lv_concatenacion es {  lv_concatenacion } | ).


** concatenacion 2

    CONCATENATE lv_string_a lv_string_b INTO DATA(lv_concatenacion2) SEPARATED BY space.


** concatenacion 3

lv_concatenacion3 = 'Hola' && `` && 'Juan'.
out->write( lv_concatenacion3 ).