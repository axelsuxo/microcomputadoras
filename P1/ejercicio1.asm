	PROCESSOR 16f877 		;indica la versión del procesador
	INCLUDE <p16f877.inc>	;incluye libreria version del procesador

K equ H'26'					;declaracion de K en registro 26
L equ H'27'					;declaracion de L en registro 27
	
	ORG 0					;especifica un origen
	GOTO INICIO				;código del programa
	ORG 5					;indica origen para inicio del programa

INICIO: MOVLW H'05'			;mueve literal a w de valor 05
		ADDWF K,0			;suma a w valor de K
		MOVWF L				;mueve a L valor de w
		GOTO INICIO			;regresa a inicio
		
		END					;directiva de fin