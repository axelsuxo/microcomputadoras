	processor 16f877		;Procesador
	include <p16f877.inc>	;Biblioteca

valor1 equ h'21'			;Definen valores
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 10h				;Definen constantes
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

loop2
	movlw h'80'
	movwf h'20'
CICLO:
	movfw h'20'
	movwf PORTB				;Mueve al puerto B lo que hay en h'20'
	rrf h'20',1				;Rotamiento a la izquierda y se guarda en h
	CALL retardo
	btfss h'00',1
	goto CICLO				;Repite el ciclo para el rotamiento
	GOTO loop2				;Reinicia la secuencia

retardo MOVLW cte1
	MOVWF valor1			;valor1=20
tres MOVLW cte2
	MOVWF valor2			;valor2=50
dos MOVLW cte3
	MOVWF valor3			;valor3=60
uno DECFSZ valor3			;Decrementa valor3, valor3=5F Z=0 salta si Z es 1
	GOTO uno				;Va dejar el loop cuando Valor3 valga 00 y Z estaría en 0
	DECFSZ valor2			;Decrementa valor2, valar2=4F Z=0 salta si Z es 1
	GOTO dos				;Va dejar el loop cuando Valor2 valga 00 y Z estaría en 0
	DECFSZ valor1			;Decrementa valor1, valar1=1F Z=0 salta si Z es 1
	GOTO tres				;Va dejar el loop cuando Valor1 valga 00 y Z estaría en 0
	RETURN
	END