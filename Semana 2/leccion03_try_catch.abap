*31/07/2025 -TRY/CATCH STATEMENT - safety
** Que hace este codigo?
***Intenta dividir un número entre cero, lo cual siempre produce un error en programación, y captura ese error para que el programa no se detenga de forma abrupta.



"1. Codigo erroneo: Shows "Abap Runtime Error" pop up - click on "show" - go to EXCEPTION - find there the name of your error: CX_SY_ZERODIVIDE

DATA: lv_num1 TYPE i VALUE 10,
      lv_num2 TYPE i VALUE 0,
      lv_res TYPE f."Float - numero decimal


      lv_res = lv_num1 / lv_num2.
      "R Pop UP: ERROR - EXCEPTION CX_SY_ZERODIVIDE
      out->write( |Linea 232: { lv_res }| ). "Esta linea no se ejecuta, porque hay un error en la linea anterior. En vez de eso, vemos el pop up.


"2. Ahora ya sabemos el nombre del error - CX_SY_ZERODIVIDE. 