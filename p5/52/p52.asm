  processor 16f877
  include<p16f877.inc>

;Valores para los retrasos anidados
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 5h 
cte2 equ 60h
cte3 equ 30h

;valores para los retrasos de cada "estado de duración"
contadorEdo1 equ 0x24
contadorEdo2 equ 0x25

  org 0h
  goto INICIO
  org 05h

INICIO:
       CLRF PORTA
       BSF STATUS,RP0  ;Cambio al Banco 1
       BCF STATUS,RP1 
       MOVLW h'0'
       MOVWF TRISB     ;Configura Puerto B como salida
       CLRF PORTB      ;Limpia los bits de Puerto 1
            
       MOVLW 06h       ;Configura puertos A y E como digitales
       MOVWF ADCON1 
       MOVLW 3fh       ;Configura el Puerto A como entrada
       MOVWF TRISA
       BCF STATUS,RP0  ;Regresa al Banco 0
      
LOOP:
	MOVFW PORTA
	XORLW 0X00 ; Revisamos si se solicita el estado 0 (Motores parados)
	BTFSC STATUS, Z 
	GOTO ESTADO0

	MOVFW PORTA
	XORLW 0X01 ; Revisamos si se solicita el estado 1 (5 segundos horario)
	BTFSC STATUS, Z 
	GOTO ESTADO1
     
	MOVFW PORTA
	XORLW 0X02 ; Revisamos si se solicita el estado 2 (10 anti-horario)
	BTFSC STATUS, Z 
	GOTO ESTADO2
	
	MOVFW PORTA
	XORLW 0X03 ; Revisamos si se solicita el estado 3 (5 vueltas horario)
	BTFSC STATUS, Z 
	GOTO ESTADO3
	
	MOVFW PORTA
	XORLW 0X04 ; Revisamos si se solicita el estado 3 (5 vueltas horario)
	BTFSC STATUS, Z 
	GOTO ESTADO4
   
ESTADO0:
	CLRF PORTB
	GOTO LOOP
     
ESTADO1:
	MOVLW 0x0A; Repetir el patrón 10 veces
	MOVWF contadorEdo1
	GOTO LOOP_ESTADO_1
	
LOOP_ESTADO_1
	;CALL retardo	
	MOVLW b'00001000'
	MOVWF PORTB
	CALL retardo
	
	MOVLW b'00000100'
	MOVWF PORTB
	CALL retardo
	
	MOVLW b'00000010'
	MOVWF PORTB
	CALL retardo
	
	MOVLW b'00000001'
	MOVWF PORTB

	decf contadorEdo1
	BTFSS STATUS,Z
	GOTO LOOP_ESTADO_1;
	GOTO LOOP

ESTADO2:
	MOVLW 0x14; Repetir el patrón 20 veces
	MOVWF contadorEdo2
	GOTO LOOP_ESTADO_2

LOOP_ESTADO_2
	;CALL retardo	
	MOVLW b'00000001'
	MOVWF PORTB
	;CALL retardo
	
	MOVLW b'00000010'
	MOVWF PORTB
	CALL retardo
	
	MOVLW b'00000100'
	MOVWF PORTB
	CALL retardo
	
	MOVLW b'00001000'
	MOVWF PORTB

	decf contadorEdo2
	BTFSS STATUS,Z
	GOTO LOOP_ESTADO_2;
	GOTO LOOP
	
ESTADO3:
	MOVLW 0x0A; Repetir el patrón 5 veces 
	MOVWF contadorEdo1
	GOTO LOOP_ESTADO_1

ESTADO4:
	MOVLW 0x0A; Repetir el patrón 10 veces 
	MOVWF contadorEdo2
	GOTO LOOP_ESTADO_2
retardo 
     movlw cte1      
     movwf valor1
tres movwf cte2
     movwf valor2
dos  movlw cte3
     movwf valor3
uno  decfsz valor3 
     goto uno 
     decfsz valor2
     goto dos
     decfsz valor1   
     goto tres
     return
     end