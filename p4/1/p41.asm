	processor 16f877		;Procesador
	include <p16f877.inc>	;Biblioteca

	ORG 0					;Vector de reset
	GOTO INICIO

	ORG 5
INICIO: CLRF PORTA			;Limpia el puerto A
	CLRF PORTB				;Limpia el puerto B
	BSF STATUS,RP0		
	BCF STATUS,RP1			;Cambio al banco 1
	MOVLW 06H
	MOVWF ADCON1
	MOVLW 3FH				;Configura el puerto A como entrada
	MOVWF TRISA
	MOVLW H'0'				;Configura al puerto B como salida
	MOVWF TRISB
	BCF STATUS,RP0			;Cambio al banco 0

con movlw H'00'
	BTFSC PORTA,0
	movlw H'ff'
	movwf PORTB
	GOTO con
	END