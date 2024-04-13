; Input peripherals
IN_PER        EQU 40H;

; Output peripherals
DISPLAY_BEGIN EQU 60H;
DISPLAY_END   EQU 223;

; Stack Pointer
StackPointer  EQU 6000H;


; Displays to be shown
Place 200H
MainMenu:
    String "----------------"
    String " Maquina Vendas "
    String "     Vendas     "
    String "                "
    String "1- Comprar      "
    String "2- Usar Cartao  "
    String "3- Stock        "
    String "----------------"

Place 280H
StationMenu:
    String "----------------"
    String "  Menu Estacao  "
    String "                "
    String "1-Estacao2: 1.50"
    String "1-Estacao3: 2.50"
    String "1-Estacao4: 3.50"
    String "1-Estacao5: 5.50"
    String "----------------"

Place 300H
GeneratePepeMessage:
    String "----------------"
    String "  Pepe Gerado   "
    String "  0001          "
    String "  Troco: 03.50  "
    String "----------------"

Place 380H
IntroducePepeMenu:
    String "----------------"
    String " Introduzir N.  "
    String " Pepe           "
    String "  XXXX          "
    String "1- Continuar    "
    String "5- Cancelar     "
    String "----------------"

Place 400H
PepeMenu:
    String "----------------"
    String " Saldo Pepe     "
    String "  1.50          "
    String "1- Comprar      "
    String "5- Recarregar   "
    String "----------------"

Place 480H
MachineStockMenu:
    String "---Stock 3/4----"
    String "Moeda de 50 cent"
    String " 0008           "
    String "Moeda de 20 cent"
    String " 0008           "
    String "Moeda de 10 cent"
    String " 0008           "
    String "1- Continuar    "
    String "----------------"


;Setup Instructions
Place 0H
Setup:
    MOV R0, Begin
    JMP R0


;Program Instructions
Place 3500H
Begin:
    MOV SP, StackPointer            ;Stack Pointer
    MOV R2, MainMenu                ;Load main menu adress into R2
    CALL SetupScreen                ;Call rotine to show the updated screen
    CALL Main_Menu_Selection        ;Logic for the main menu selection

Main_Menu_Selection:
    CALL CleanPeripherals           ;Call rotine to clean peripherals
    MOV R0, IN_PER                  ;Loads input peripheral address to R0
    MOVB R1, [R0]                   ;Reads the value on the input peripheral to R1, a byte so the first memory slot is used
    CMP R1, 1                       ;Compares R1 with the value 1
    JEQ BuyPepe                     ;Call rotine to handle the buy option
    CMP R1, 2                       ;Compares R1 with the value 2
    ;JEQ UseCard                          
    CMP R1, 3                       ;Compares R1 with the value 3
    ;JEQ Stock
    JMP Main_Menu_Selection         ;In case option is invalid or nor selected, repeat rotine

BuyPepe:
    CALL CleanPeripherals           ;Call rotine to clean peripherals
    MOV R0, IN_PER                  ;Loads input peripheral address to R0
    MOVB R1, [R0]                   ;Reads the value on the input peripheral to R1, a byte so the first memory slot is used
    CMP R1, 1                       ;Compares R1 with the value 1
    ;JEQ station2
    CMP R1, 2                       ;Compares R1 with the value 2
    ;JEQ station3
    CMP R1, 3                       ;Compares R1 with the value 3
    ;JEQ station4
    CMP R1, 4                       ;Compares R1 with the value 4
    ;JEQ station5
    CMP R1, 5                       ;Compares R1 with the value 5
    ;JEQ cancelar
    JMP BuyPepe                     ;In case the option is invalid or not selected, repeat rotine


SetupScreen:
    PUSH R0							;Stores R0 on the stackpointer
	PUSH R1							;Stores R1 on the stackpointer
	PUSH R2							;Stores R2 on the stackpointer
	PUSH R3							;Stores R3 on the stackpointer
	MOV R0, DISPLAY_BEGIN		    ;Moves to R0 the address of the beggining of the screen
	MOV R1, DISPLAY_END				;Moves to R1 the address of the end of the screen
ShowScreen:
    MOV R3, [R2]					;Moves to R3 the value on the address R2 (R2 holds the starting value of the screen to be put)
	MOV [R0], R3					;Moves to the value pointed by R0 (the start of the screen) the contents on R3 (the message to be shown on that line)
	ADD R2, 2						;Adds to R2 2 units, gets content from the next line
	ADD R0, 2						;Adds to R0 2 units, go to the next line on the screen
	CMP R0, R1						;Compares R0 with R1 (that holds the value of the end of the display)
	JLE ShowScreen   				;If its smaller or equal, repeat
	POP R3							;Restores R3 value
	POP R2							;Restores R2 value
	POP R1							;Restores R1 value
	POP R0							;Restores R0 value
	RET								;Goes back to the address saved on the StackPointer

CleanPeripherals:
    PUSH R0							;Stores R0 in the stackpointer
    PUSH R1                         ;Stores R1 in the stackpointer
	MOV R0, IN_PER					;Reads the address of the input peripheral
	MOV R1, 0                       ;Moves to R1 the value 0
    MOVB [R0], R1					;Moves to the value the address stored in R0 the value of R1
	POP R1                          ;Restores the value of R1
    POP R0							;Restores the value of R0
	RET								;Goes back to the address stores in the stackpointers