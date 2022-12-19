 processor 16f877
  include<p16f877.inc>

valor1 equ h'20'
valor2 equ h'21'
valor3 equ h'22'
cte1 equ 20h
cte2 equ 50h
cte3 equ 60h

A5 equ H'60'
B10 equ H'61'
S5 equ H'62'
S10 equ H'63'

  org 0
  goto INICIO
  org 5

INICIO:
       CLRF PORTA
       BSF STATUS,RP0  ;Cambio al Banco 1
       BCF STATUS,RP1 
       MOVLW 06H
       MOVWF ADCON1  ;Los puertos a y e son digitales
       MOVLW H'07'   ;El puerto A se configura como entrada B'00001111'
       MOVWF TRISA   ;ENTRADA=1 Y SALIDA=0
       MOVLW H'00'
       MOVWF PORTB   ;EL PORTB ES LA SALIDA
       
       BCF STATUS,RP0 ;Ahora el banco de memoria es el 0
       
       DATO:
           CLRF PORTB
           MOVLW B'00000101'
           MOVWF A5
           MOVLW B'00001010'
           MOVWF B10
           MOVLW B'00000110'           
           MOVWF S5
           MOVLW B'00001011'
           MOVWF S10
           BTFSS PORTA,0 ;Verifica el bit 0 del PORTA
           GOTO DATO0  ; 0
           GOTO DATO1  ; 1
       
       DATO0:
           BTFSS PORTA,1 
           GOTO DATO00 
           GOTO ANTIHORARIO1 
       DATO1:
           BTFSS PORTA,1 
           GOTO HORARIO1 
           GOTO HORARIO2
       DATO00:
           BTFSS PORTA,2 
           GOTO DETENIDO 
           GOTO ANTIHORARIO2
       HORARIO1:
           CALL PASO1
           CALL PASO2
           CALL PASO3
           CALL PASO4
           DECFSZ S5 
           GOTO HORARIO1 
           GOTO DATO
       HORARIO2:
           CALL PASO1
           CALL PASO2
           CALL PASO3
           CALL PASO4
           DECFSZ A5 
           GOTO HORARIO2 
           GOTO DATO              
       ANTIHORARIO1:
           CALL PASO4
           CALL PASO3
           CALL PASO2
           CALL PASO1
           DECFSZ S10 
           GOTO ANTIHORARIO1 
           GOTO DATO
       ANTIHORARIO2:
           CALL PASO4
           CALL PASO3
           CALL PASO2
           CALL PASO1
           DECFSZ B10 
           GOTO ANTIHORARIO2 
           GOTO DATO
       DETENIDO:
           MOVLW B'00000000'
           MOVWF PORTB
           CALL RETARDO
           GOTO DATO
       PASO1:
           MOVLW B'00001001'
           MOVWF PORTB
           CALL RETARDO
           RETURN                
       PASO2:
           MOVLW B'00000011'
           MOVWF PORTB
           CALL RETARDO
           RETURN
       PASO3:
           MOVLW B'00000110'
           MOVWF PORTB
           CALL RETARDO
           RETURN
       PASO4:
           MOVLW B'00001100'
           MOVWF PORTB
           CALL RETARDO
           GOTO DATO
       
       RETARDO:
           MOVLW cte1
           MOVWF valor1
       TRES:
           MOVLW cte2
           MOVWF valor2
       DOS:
           MOVLW cte3
           MOVWF valor3
       UNO:
           DECFSZ valor3
           GOTO UNO
           DECFSZ valor2
           GOTO DOS
           DECFSZ valor1
           GOTO TRES
           RETURN
     
     END
                
      