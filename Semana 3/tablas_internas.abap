CLASS zcl_eje_tab_internas_rc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_eje_tab_internas_rc IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

*EJERCICIO TABLAS INTERNAS

*Una biblioteca quiere guardar información sobre los libros que tiene. Para ello, crea un programa que:

*Defina un tipo de estructura ty_libro con estos campos:
*Título (tipo string)
*Autor (tipo string)
*Número de páginas (tipo i)

*Declare una tabla interna lt_libros y una variable ls_libro de ese tipo.

*Añada tres libros usando INSERT ... INDEX para colocarlos en posiciones concretas.

*Recorra la tabla con un LOOP AT y muestre:

*"Libro corto: <título>" si tiene menos de 150 páginas
*"Libro largo: <título>" si tiene más de 500 páginas
*"Libro estándar: <título>" en otro caso
*Finalmente, muestra toda la tabla con out->write.

"RESULTADO:

*"1. Definir estructura tipo libro

    TYPES: BEGIN OF ty_libro,
            titulo TYPE string,
            autor TYPE string,
            paginas TYPE i,
           END OF ty_libro.

*"2. Declarar tabla interna y estructura

    DATA: lt_libros TYPE STANDARD OF ty_libro,
          ls_libro TYPE ty_libro.

*"3. Anadir libros en posiciones concretas

*" 4. Recorrer la tabla y mostrar según cantidad de páginas

*" 5. Mostrar toda la tabla

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Variaciones del append


"AÑADIR REGISTROS CON EL APPEND
"Añade un registro al final de la tabla interna, solo se usa en las standard. hace los mismo que los inserte, mejor usar los insert.

*    TYPES: BEGIN OF ty_persona,
*             nombre TYPE string,
*             edad   TYPE i,
*           END OF ty_persona.
*
*  TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
**
*    DATA: lt_personas TYPE ty_tabla_personas,
*          ls_persona  TYPE ty_persona.
**
*
*
*    ls_persona-nombre = 'Daniel'.
*    ls_persona-edad  = '23'.
*
*
*
*    APPEND ls_persona TO lt_personas.
*
*    out->write( lt_personas ).

""" declaracion lineal del append

*    TYPES: BEGIN OF ty_persona,
*             nombre TYPE string,
*             edad   TYPE i,
*           END OF ty_persona.
*
* TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
*
*    DATA: lt_personas TYPE ty_tabla_personas.
*
*APPEND VALUE #(
*
*        nombre = 'Daniel'
*        edad   = 15
*
* ) to lt_personas.

""""""
"copiar contenido de unta tabla a otra

*Append lines of lt_personas into table lt_personas2.
*
*APPEND lines of lt_personas to 1 into table lt_personas2.


"AÑADIR REGISTROS CON EL VALUE

*    TYPES: BEGIN OF ty_persona,
*             nombre TYPE string,
*             edad   TYPE i,
*           END OF ty_persona.
*
*    TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
*
*
*    DATA(lt_persona) = VALUE ty_tabla_personas(
*    ( nombre = 'Ana' edad = 25 )
*    ( nombre = 'Javier' edad = 45 )
*    ( nombre = 'Lucia' edad = 22 )
*
*
*    ).
*
*    out->write( lt_persona ).
*
*    DATA ls_persona TYPE ty_persona.
*
*    LOOP AT lt_persona INTO ls_persona.
*
*      out->write( |Nombre: { ls_persona-nombre }, Edad: { ls_persona-edad }| ).
*
*    ENDLOOP.

"extraemos todo de la base de datos / la tabla externa
*data lt_aeropuerto type STANDARD TABLE OF /dmo/airport.
*
*lt_aeropuerto = value #(
*
*        (
*        client = 100
*        airport_id = 'FRA'
*        name = 'Frankfurt Airport'
*        city = 'Frankfurt/Main'
*        country = 'DE'
*        )
*
*                (
*        client = 100
*        airport_id = 'RRA'
*        name = 'Frankfurt Airport'
*        city = 'Frankfurt/Main'
*        country = 'RE'
*        )
*).
*
*out->write( lt_aeropuerto ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Read table con indice
"SELECT for external tables, it does not work for internal tables

*SELECT FROM /dmo/airport
*FIELDS *
*WHERE country = 'DE'
*INTO TABLE @DATA(lt_flights).
*
*
*IF sy-subrc = 0. "queremos saber si tuvo exito
*
*   READ TABLE lt_flights INTO DATA(ls_flights) INDEX 1.
*   out->write( lt_flights ).
*   "READ TABLE lt_flights ASSIGNING FIELD-SYMBOL(<lfs_flight>) index 3.
*
*
*ENDIF.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"la forma moderna de usar del read table con indice

*SELECT FROM /dmo/airport
*FIELDS *
*WHERE country = 'DE'
*INTO TABLE @DATA(lt_flights).
*
*DATA(ls_data) = lt_flights[ 2 ].
*DATA(ls_data2) = VALUE #( lt_flights[ 20 ] default lt_flights[ 1 ] ). "si no aparece el 20, con default mostramos la entrada 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Read table with key

"READ TABLE
    "Read table con indice


*    SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country = 'DE'
*    INTO TABLE @DATA(lt_flights).
*
*    IF sy-subrc = 0.
*
*      READ TABLE lt_flights INTO DATA(ls_flights) INDEX 4.
**      out->write( data = lt_flights name = `tabla de vuelos` ).
**      out->write( data = ls_flights name = `Estructura vuelos` ).
*
*      READ TABLE lt_flights INTO DATA(ls_flights2) INDEX 4 TRANSPORTING airport_id city .
*      out->write( data = ls_flights2 name = `Estructura vuelos` ).
*
*
*    ENDIF.

""""

*   SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country = 'DE'
*    INTO TABLE @DATA(lt_flights).
*
*    IF sy-subrc = 0.
*
*      READ TABLE lt_flights ASSIGNING FIELD-SYMBOL(<lfs_flight>) index 3.
*        out->write( data = <lfs_flight> name = `<lfs_flight>` ).
*
*
*    ENDIF.


   """""""""
"la forma moderna de usar del read table con indiceç
*   SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country = 'DE'
*    INTO TABLE @DATA(lt_flights).
*
*DATA(ls_data) = lt_flights[ 2 ].
*out->write( data = ls_data name = `ls_data` ).
*
*
*DATA(ls_data2) = value #( lt_flights[ 20 ] default lt_flights[ 1 ] ) .


 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"READ TABLE CON CLAVE

*   SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country = 'DE'
*    INTO TABLE @DATA(lt_flights).


* IF sy-subrc = 0.
*
* READ TABLE lt_flights into data(ls_flight) WITH KEY city = 'Berlin'.
*out->write( data = lt_flights name = `lt_flights` ).
*
*out->write( data = ls_flight name = `ls_flight` ).
*
*
*endif.

"forma moderna de hacer lo anterior


*SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country = 'DE'
*    INTO TABLE @DATA(lt_flights).
*
**DATA(ls_flight2) = lt_flights[ airport_id = 'MUC' ].
**out->write( data = ls_flight2 name = `ls_flight2` ).
*
*"""
*DATA(ls_flight2) = lt_flights[ airport_id = 'MUC' ]-name.
*out->write( data = ls_flight2 name = `ls_flight2` ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"EJERCICIO
*Crear un tipo de estructura ty_pasajero con los campos:

*nombre (string)
*edad (i)

*Declarar una tabla interna de pasajeros lt_pasajeros y cargarla con VALUE con 4 registros. Uno de ellos debe tener edad < 18.

*Insertar un pasajero nuevo en la segunda posición con INSERT ... INDEX.

"4. Crear una segunda tabla lt_pasajeros_jovenes que contenga solo los pasajeros menores de edad (usa APPEND dentro de un LOOP).

*Leer el pasajero en la posición 3 usando READ TABLE ... INDEX con ASSIGNING y mostrarlo con out->write, solo si sy-subrc = 0.

*Simular un listado de vuelos haciendo un SELECT sobre /dmo/airport con país 'DE' y guardar los resultados en lt_vuelos.

*Si hay resultados (sy-subrc = 0), mostrar el aeropuerto con airport_id = 'MUC' usando READ TABLE moderno:
*DATA(ls_vuelo) = lt_vuelos[ airport_id = 'MUC' ].
*Mostrar por pantalla todas las estructuras relevantes.

"1. Definir estructura simple/individual: ty_pasajero

* TYPES: BEGIN OF ty_pasajero,
*             name TYPE string,
*             edad TYPE i,
*           END OF ty_pasajero.
*
*" 2. Declarar tabla interna lt_pasajeros con 4 registros
*
*      "Forma moderna:
**    DATA(lt_pasajeros) = VALUE STANDARD TABLE OF ty_pasajero(
**      ( name = 'Laura'  edad = 32 )
**      ( name = 'Carlos' edad = 45 )
**      ( name = 'Marta'  edad = 16 )
**      ( name = 'Andres' edad = 28 )
**    ).
*
*
*      "Forma compatible con mi eclipse (antigua):
*      DATA lt_pasajeros TYPE STANDARD TABLE OF ty_pasajero.
*
*      lt_pasajeros = VALUE #(           "# it means copy the last TYPE
*        ( name = 'Laura'  edad = 32 )
*        ( name = 'Carlos' edad = 45 )
*        ( name = 'Marta'  edad = 16 )
*        ( name = 'Andres' edad = 28 )
*      ).
*
*
*"3. Insertar un nuevo pasajero en la segunda posicion
*
*DATA(ls_nuevo) = VALUE ty_pasajero( name = 'Julian' edad = 22 ). "creamos S
*INSERT ls_nuevo INTO lt_pasajeros INDEX 2. "introduce S into T
*
*"4. Crear  NUEVA TABLA de pasajeros jovenes <18
*
*DATA: lt_pasajeros_jovenes TYPE STANDARD TABLE OF ty_pasajero,
*      ls_pasajero TYPE ty_pasajero.
*
*LOOP AT lt_pasajeros INTO ls_pasajero.
*    IF ls_pasajero-edad < 18.
*        APPEND ls_pasajero TO lt_pasajeros_jovenes.
*   ENDIF.
*ENDLOOP.
*
* " 5. Leer el pasajero en la posición 3 con READ TABLE ASSIGNING
*    DATA: ref_pasajero TYPE REF TO ty_pasajero.
*    READ TABLE lt_pasajeros INDEX 3 ASSIGNING FIELD-SYMBOL(<fs_pasajero>).
*    IF sy-subrc = 0.
*      out->write( |Pasajero en posición 3: { <fs_pasajero>-name }, Edad: { <fs_pasajero>-edad }| ).
*    ENDIF.
*
*    " 6. Simular listado de vuelos: SELECT de /dmo/airport en Alemania
*    SELECT FROM /dmo/airport
*           FIELDS *
*           WHERE country = 'DE'
*           INTO TABLE @DATA(lt_vuelos).
*
*    " 7. Si hay resultados, mostrar el aeropuerto con ID 'MUC'
*    IF sy-subrc = 0.
*      TRY.
*          DATA(ls_vuelo) = lt_vuelos[ airport_id = 'MUC' ].
*          out->write( |Aeropuerto MUC: { ls_vuelo-name } ({ ls_vuelo-city })| ).
*        CATCH cx_sy_itab_line_not_found.
*          out->write( 'No se encontró el aeropuerto con ID MUC.' ).
*      ENDTRY.
*    ENDIF.
*
*    " 8. Mostrar todas las estructuras relevantes
*    out->write( ' Lista completa de pasajeros:' ).
*    out->write( lt_pasajeros ).
*
*    out->write( ' Pasajeros menores de edad:' ).
*    out->write( lt_pasajeros_jovenes ).
*
*    out->write( '️ Aeropuertos en Alemania:' ).
*    out->write( lt_vuelos ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*TYPES: BEGIN OF ty_pasajero,
*         nombre TYPE string,
*         edad   TYPE i,
*         email  TYPE /dmo/email_address,
*       END OF ty_pasajero.
*
*DATA: lt_pasajeros     TYPE STANDARD TABLE OF ty_pasajero,
*      lt_pasajeros2    TYPE STANDARD TABLE OF ty_pasajero,
*      ls_pasajero      TYPE ty_pasajero,
*      lt_pasajeros_aux TYPE STANDARD TABLE OF ty_pasajero,
*      lv_nombre_upper  TYPE string.
*
*" Añadir pasajeros usando APPEND VALUE
*APPEND VALUE #( nombre = 'Ana' edad = 28 email = 'ana@viajes.com' ) TO lt_pasajeros.
*APPEND VALUE #( nombre = 'Pedro' edad = 17 email = 'pedro@viajes.com' ) TO lt_pasajeros.
*APPEND VALUE #( nombre = 'Lucía' edad = 34 email = 'lucia@viajes.com' ) TO lt_pasajeros.
*APPEND VALUE #( nombre = 'Marcos' edad = 15 email = 'marcos@viajes.com' ) TO lt_pasajeros.
*
*" Insertar a Carlos en la segunda posición
*INSERT VALUE #( nombre = 'Carlos' edad = 22 email = 'carlos@viajes.com' ) INTO lt_pasajeros INDEX 2.
*
*" Copiar pasajeros menores de 30 años a lt_pasajeros2
*LOOP AT lt_pasajeros INTO ls_pasajero.
*  IF ls_pasajero-edad < 30.
*    APPEND ls_pasajero TO lt_pasajeros2.
*  ENDIF.
*ENDLOOP.
*
*" Leer pasajero en posición 3 y mostrar su nombre en mayúsculas
*READ TABLE lt_pasajeros INDEX 3 INTO ls_pasajero.
*IF sy-subrc = 0.
*  lv_nombre_upper = to_upper( val = ls_pasajero-nombre ).
*  out->write( |Nombre en mayúsculas: { lv_nombre_upper }| ).
*ENDIF.
*
*"Parte 2
*
*DATA: lt_aeropuertos TYPE STANDARD TABLE OF /dmo/airport,
*      lt_alemanes    TYPE STANDARD TABLE OF /dmo/airport,
*      ls_aeropuerto  TYPE /dmo/airport.
*
*" Insertar manualmente aeropuertos
*APPEND VALUE #( airport_id = 'FRA' city = 'Frankfurt' country = 'DE' ) TO lt_aeropuertos.
*APPEND VALUE #( airport_id = 'MUC' city = 'Munich' country = 'DE' ) TO lt_aeropuertos.
*APPEND VALUE #( airport_id = 'BCN' city = 'Barcelona' country = 'ES' ) TO lt_aeropuertos.
*
*
*" Copiar aeropuertos alemanes
*LOOP AT lt_aeropuertos INTO ls_aeropuerto WHERE country = 'DE'.
*  APPEND ls_aeropuerto TO lt_alemanes.
*ENDLOOP.
*
*" Acceder al aeropuerto con ID = 'MUC' y mostrar la ciudad
*READ TABLE lt_aeropuertos INTO ls_aeropuerto WITH KEY airport_id = 'MUC'.
*IF sy-subrc = 0.
*  out->write( |Ciudad del aeropuerto MUC: { ls_aeropuerto-city }| ).
*ENDIF.

*
*PARTE 3 – FUNCIONES DE TEXTO
*Declara una variable lv_texto con el siguiente contenido:
*'El pasajero Pedro con email pedro@viajes.com ha comprado el billete'.
*Extrae:
*El nombre del pasajero con substring_between usando "pasajero " y " con".
*El correo electrónico usando expresión regular (\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b) y la función match.
*Reemplaza el nombre del pasajero por 'XXXXX' con replace.

*DATA(lv_texto) = |El pasajero Pedro con email pedro@viajes.com ha comprado el billete.|.
*
*    " 1. Buscar posición donde empieza 'pasajero '
*    DATA lv_inicio TYPE i.
*    FIND 'pasajero ' IN lv_texto MATCH OFFSET lv_inicio.
*    lv_inicio = lv_inicio + strlen( 'pasajero ' ).
*
*    " 2. Buscar posición donde empieza ' con email'
*    DATA lv_fin TYPE i.
*    FIND ' con email' IN lv_texto MATCH OFFSET lv_fin.
*
*    " 3. Extraer nombre usando offset y longitud
*    DATA lv_len TYPE i.
*    lv_len = lv_fin - lv_inicio.
*    DATA(lv_nombre_pasajero) = lv_texto+lv_inicio(lv_len).
*
*    " 4. Extraer email con expresión regular
*    DATA lv_email TYPE string.
*    DATA lv_offset TYPE i.
*    DATA lv_length TYPE i.

    "REGEX is deprecated
"probar el codigo de Dani, para que no de error
**     " 9. Texto de entrada
*    DATA(lv_texto) = 'El pasajero Pedro con email pedro@viajes.com ha comprado el billete'.
*
*    " 10. Extraer nombre del pasajero entre "pasajero " y " con"
*    DATA(lv_temp) = substring_after( val = lv_texto sub = 'pasajero ' ).
*    DATA(lv_nombre) = substring_before( val = lv_temp sub = ' con' ).
*
*    out->write( |Nombre extraído: { lv_nombre }| ).
*
*    " Extraer el email con expresión regular usando MATCH
*    DATA(lv_pattern_email) = `\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b`.
*    DATA(lv_email) = match( val = lv_texto pcre = lv_pattern_email occ = '1' ).
*
*    out->write( |Email extraído: { lv_email }| ).
*
*    " 11. Reemplazar el nombre por 'XXXXX'
*    DATA(lv_texto_oculto) = replace( val = lv_texto sub = lv_nombre with = 'XXXXX' ).
*    out->write( |Texto con nombre oculto: { lv_texto_oculto }| ).

*    FIND REGEX '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b'
*      IN lv_texto
*      MATCH OFFSET lv_offset
*      MATCH LENGTH lv_length.
*
*    IF sy-subrc = 0.
*      lv_email = lv_texto+lv_offset(lv_length).
*    ENDIF.
*
*    " 5. Reemplazar nombre por 'XXXXX'
*    DATA(lv_texto_oculto) = replace( val = lv_texto sub = lv_nombre_pasajero with = 'XXXXX' occ = 1 ).
*
*    " 6. Mostrar resultados
*    out->write( |Nombre extraído: { lv_nombre_pasajero }| ).
*    out->write( |Email extraído: { lv_email }| ).
*    out->write( |Texto anonimizado: { lv_texto_oculto }| ).
*
*
*
**BONUS (opcional, para los más rápidos):
**Concatenar los nombres de todos los pasajeros de la tabla lt_pasajeros2 en una sola cadena separados por coma, y mostrarla con out->write.
*
*DATA(lv_nombres_concatenados) = ``.
*
*LOOP AT lt_pasajeros2 INTO ls_pasajero.
*  IF lv_nombres_concatenados IS INITIAL.
*    lv_nombres_concatenados = ls_pasajero-nombre.
*  ELSE.
*    lv_nombres_concatenados = |{ lv_nombres_concatenados }, { ls_pasajero-nombre }|.
*  ENDIF.
*ENDLOOP.
*
*
*out->write( lv_nombres_concatenados ).



"""""""""""""""""""""""""""
"06/08/2025
"Corresponding - se asignan automaticamente los valores de una tabla a otra que esta vacia, solo los campos que correspondan en las tablas



*TYPES:BEGIN OF ty_flights,
*        carrier_id    TYPE /dmo/carrier_id,
*        connection_id TYPE /dmo/connection_id,
*        flight_date   TYPE /dmo/flight_date,
*        animales      TYPE string,  "ejemplo, aparece columna vacia
*        currency_code TYPE /dmo/currency_code,
*      END OF ty_flights.
*
*DATA: lt_my_flights TYPE STANDARD TABLE OF ty_flights.
*" ls_my_flight type ty_flights.
*""""""""
*SELECT FROM /dmo/flight
* FIELDS *
* WHERE currency_code = 'EUR'
* INTO TABLE @DATA(lt_flights).

"""""""""""

*MOVE-CORRESPONDING lt_flights TO lt_my_flights.
*
*out->write( data = lt_flights name = `tabla lt_flights` ).
*out->write( |\n| ).
*   out->write( data = lt_my_flights name = `tabla lt_my_flights` ).

""""""""""""""""
"Version moderna de move corresponding:
"keeping target lines -- copiar los datos de una segunda tabla y ponerlos debajo de la primera 


"""""""
"move corresponding moderno
*    TYPES:BEGIN OF ty_flights,
*            carrier_id    TYPE /dmo/carrier_id,
*            connection_id TYPE /dmo/connection_id,
*            flight_date   TYPE /dmo/flight_date,
*            animales      TYPE string,
*            currency_code TYPE /dmo/currency_code,
*          END OF ty_flights.
*
*    DATA: lt_my_flights TYPE STANDARD TABLE OF ty_flights.
*    " ls_my_flight type ty_flights.
*
*    """"""""
*    SELECT FROM /dmo/flight
*    FIELDS *
*    WHERE currency_code = 'EUR'
*    INTO TABLE @DATA(lt_flights).
*
*
*    lt_my_flights = CORRESPONDING #( lt_flights ).
*
*
*    
*
*
*    out->write( data = lt_flights name = `tabla lt_flights` ).
*    out->write( |\n| ).
*    out->write( data = lt_my_flights name = `tabla  lt_my_flights` ).
 
""""""""""""""
"keeping trget lines
 
*  TYPES:BEGIN OF ty_flights,
*            carrier_id    TYPE /dmo/carrier_id,
*            connection_id TYPE /dmo/connection_id,
*            flight_date   TYPE /dmo/flight_date,
*            animales      TYPE string,
*            currency_code TYPE /dmo/currency_code,
*          END OF ty_flights.
* 
*    DATA: lt_my_flights TYPE STANDARD TABLE OF ty_flights.
*    " ls_my_flight type ty_flights.
* 
*    """"""""
*    SELECT FROM /dmo/flight
*    FIELDS *
*    WHERE currency_code = 'EUR'
*    INTO TABLE @DATA(lt_flights).
* 
* 
*    lt_my_flights = CORRESPONDING #( lt_flights ).
* 
* 
*    MOVE-CORRESPONDING lt_flights TO lt_my_flights KEEPING TARGET LINES.
* 
* 
*    out->write( data = lt_flights name = `tabla lt_flights` ).
*    out->write( |\n| ).
*    out->write( data = lt_my_flights name = `tabla  lt_my_flights` ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"chequeo de registros
 
 
 
*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @DATA(lt_flights).
    """""""""""""""""""""""""""""""""""""""""""  esto y lo de arriba son dos formas de hacer exactamente lo mismo
*    DATA lt_flights TYPE STANDARD TABLE OF /dmo/flight.
*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @lt_flights.
* 
*out->write( lt_flights ).
* 
*    IF sy-subrc = 0.
* 
*      READ TABLE lt_flights WITH KEY connection_id = '0403' TRANSPORTING NO FIELDS.
* 
* 
* 
* 
*      IF sy-subrc = 0.
* 
*        out->write( 'el vuelo existe en la base de datos' ).
*      ELSE.
*        out->write( 'el vuelo NO existe en la base de datos' ).
*      ENDIF.
* 
*    ENDIF.
    
    
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"forma moderna
 
*DATA lt_flights TYPE STANDARD TABLE OF /dmo/flight.
*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @lt_flights.
* 
*out->write( lt_flights ).
* 
*    IF sy-subrc = 0.
* 
* 
*    IF line_exists( lt_flights[ connection_id = '0404' ] ) .
* 
*        out->write( 'el vuelo existe en la base de datos' ).
*      ELSE.
*        out->write( 'el vuelo NO existe en la base de datos' ).
*      ENDIF.
* 
*    ENDIF.

 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "indice de un registro
 
    "line_index
    "devuelve el numero de linea donde se encuentra ese vuelo/registro.
*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @DATA(lt_flights).
*
*
*    READ TABLE lt_flights WITH KEY connection_id = '0403' TRANSPORTING NO FIELDS.
 
*    DATA(lv_index) = sy-tabix.
*    out->write( data = lt_flights name = `lt_flights` ).
*    out->write( lv_index ).
 
    "froma moderna
*    SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE carrier_id = 'LH'
*     INTO TABLE @DATA(lt_flights).
*
*    DATA(lv_index) = line_index( lt_flights[ connection_id = '0401' ] ).
*
*    out->write( data = lt_flights name = `lt_flights` ).
*    out->write( lv_index ).
*    
*    
*    "lines, numero total de lineas en la tabla
*    data(lv_num) = lines( lt_flights ).
*    out->write( data = lv_num name = `lv_num` ).
 
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "indice de un registro
 
    "line_index
    "devuelve el numero de linea donde se encuentra ese vuelo/registro.
*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @DATA(lt_flights).
*
*
*    READ TABLE lt_flights WITH KEY connection_id = '0403' TRANSPORTING NO FIELDS.
 
*    DATA(lv_index) = sy-tabix.
*    out->write( data = lt_flights name = `lt_flights` ).
*    out->write( lv_index ).
 
    "froma moderna
*    SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE carrier_id = 'LH'
*     INTO TABLE @DATA(lt_flights).
*
*    DATA(lv_index) = line_index( lt_flights[ connection_id = '0401' ] ).
*
*    out->write( data = lt_flights name = `lt_flights` ).
*    out->write( lv_index ).
*    
*    
*    "lines, numero total de lineas en la tabla
*    data(lv_num) = lines( lt_flights ).
*    out->write( data = lv_num name = `lv_num` ).


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
 "Loop at
 
* TYPES: BEGIN OF ty_persona,
*             nombre TYPE string,
*             edad   TYPE i,
*           END OF ty_persona.
*
*    TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
*
*
*    DATA(lt_persona) = VALUE ty_tabla_personas(
*    ( nombre = 'Ana' edad = 25 )
*    ( nombre = 'Javier' edad = 45 )
*    ( nombre = 'Lucia' edad = 22 )
*
*
*
*    ).
*
*    out->write( lt_persona ).
*
*    DATA ls_persona TYPE ty_persona.
*
*    LOOP AT lt_persona INTO ls_persona where nombre = 'Ana' .
*
*      out->write( |Nombre: { ls_persona-nombre }, Edad: { ls_persona-edad }| ).
 
    " ENDLOOP.
    "loop con assigning field-symbol
 
 
*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @DATA(lt_flights).
*
*    DATA ls_flight TYPE /dmo/flight.
*
*"loop "normal"
*
*    LOOP AT lt_flights INTO ls_flight.
*
*      out->write( data = ls_flight name = `ls_flight` ).
*    ENDLOOP.
*    
*
*    """"""""""""""""""""""""""""""
*
*"loop con where y field-symbol
*    LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<fs_flight>) WHERE connection_id = '0403'.
*
*      "out->write( data = <fs_flight> name = `<fs_flight>` ).
*    ENDLOOP.
*    out->write( |\n| ).
*    out->write( |\n| ).
*
*
*"loop con where y estructura creada en linea para almacenar valores  
*    LOOP AT lt_flights INTO DATA(ls_flight2) WHERE connection_id = '0403'.
*
*      out->write( data = ls_flight2 name = `fs_flight2` ).
*
*    ENDLOOP.
 
 
*  SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @DATA(lt_flights).
* 
*    DATA ls_flight TYPE /dmo/flight.
*    
*    LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<fs_flight>) from 3 to 8.
* 
*     <fs_flight>-currency_code = 'COP'.
*    ENDLOOP.
*    out->write( data = lt_flights name = `lt_flights` ).
* 


ENDMETHOD.


ENDCLASS.