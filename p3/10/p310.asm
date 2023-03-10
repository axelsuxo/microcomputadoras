	processor 16f877		;Procesador
	include <p16f877.inc>	;Biblioteca

valor1 equ h'21'			;Definen valores
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 100h				;Definen constantes
cte2 equ 50h
cte3 equ 60h

	ORG 0					;Vector de reset
	GOTO INICIO

	ORG 5
INICIO:BSF STATUS,RP0		
	BCF STATUS,RP1			;Cambio al banco 1
	MOVLW H'0'				;Configura al puerto B como salida
	MOVWF TRISB
	BCF STATUS,RP0			;Cambio al banco 0
	CLRF PORTB				;Limpia el puerto B

ESTADO_1:                 	; Estado 1 del sem?foro
	MOVLW h'14'
	MOVWF PORTB
	CALL retardo

ESTADO_2:                 	; Estado 2 del sem?foro
	MOVLW h'24'
	MOVWF PORTB
	CALL retardo

ESTADO_3:                 	; Estado 3 del sem?foro
	MOVLW h'41'
	MOVWF PORTB
	CALL retardo

ESTADO_4:                 	; Estado 4 del sem?foro
	MOVLW h'42'
	MOVWF PORTB
	CALL retardo

retardo MOVLW cte1
	MOVWF valor1			;valor1=20
tres MOVLW cte2
	MOVWF valor2			;valor2=50
dos MOVLW cte3
	MOVWF valor3			;valor3=60
uno DECFSZ valor3			;Decrementa valor3, valor3=5F Z=0 salta si Z es 1
	GOTO uno				;Va dejar el loop cuando Valor3 valga 00 y Z estar?a en 0
	DECFSZ valor2			;Decrementa valor2, valar2=4F Z=0 salta si Z es 1
	GOTO dos				;Va dejar el loop cuando Valor2 valga 00 y Z estar?a en 0
	DECFSZ valor1			;Decrementa valor1, valar1=1F Z=0 salta si Z es 1
	GOTO tres				;Va dejar el loop cuando Valor1 valga 00 y Z estar?a en 0
	RETURN
	END