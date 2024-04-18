; Input peripherals
IN_PER               EQU 40H

; Output peripherals
DISPLAY_BEGIN        EQU 60H
DISPLAY_END          EQU 223

; Stack Pointer
StackPointer         EQU 6000H

;ScreenPositions
Inserted_money_euro EQU 140         ;Display position of the inserted euro
Inserted_money_cent1 EQU 142        ;Display position of the inserted cent first digit
Inserted_money_cent2 EQU 143        ;Display position of the inserted cent second digit
Price_money_euro    EQU 156         ;Display position of the price to be paid euros
Price_money_cent    EQU 158         ;Display position of the price to be paid cents

; Constants
Display_constant      EQU 30H       ;Constant that represents 0 on the display
Cent_overflow         EQU 10        ;In case the cents have overflown, subtract 10

Station2_number       EQU 2         ;Number of the station
Station2_euro         EQU 1         ;Price in euros of the ticket
Station2_cent         EQU 50        ;Price in cents of the ticket
Station2_euro_display EQU 31H       ;Value to be displayed for the euros
Station2_cent_display EQU 3530H     ;Value to be displayed for the cents

Station3_number       EQU 3         ;Number of the station
Station3_euro         EQU 2         ;Price in euros of the ticket
Station3_cent         EQU 50        ;Price in cents of the ticket
Station3_euro_display EQU 32H       ;Value to be displayed for the euros
Station3_cent_display EQU 3530H     ;Value to be displayed for the cents

Station4_number       EQU 4         ;Number of the station
Station4_euro         EQU 3         ;Price in euros of the ticket
Station4_cent         EQU 50        ;Price in cents of the ticket
Station4_euro_display EQU 33H       ;Value to be displayed for the euros
Station4_cent_display EQU 3530H     ;Value to be displayed for the cents

Station5_number       EQU 4         ;Number of the station
Station5_euro         EQU 5         ;Price in euros of the ticket
Station5_cent         EQU 50        ;Price in cents of the ticket
Station5_euro_display EQU 35H       ;Value to be displayed for the euros
Station5_cent_display EQU 3530H     ;Value to be displayed for the cents

; Variables
Inserted_euro        EQU 8000H      ;Hold the current money inserted on memory
Inserted_cent1       EQU 8010H      ;Hold the current cents (dezens) on memory
Inserted_cent2       EQU 8020H      ;Hold the current cents (units) on memory



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
    String "  Menu Estacao  "
    String "                "
    String "1-Estacao2: 1.50"
    String "2-Estacao3: 2.50"
    String "3-Estacao4: 3.50"
    String "4-Estacao5: 5.50"
    String "5-Cancelar      "
    String "----------------"

Place 300H
GeneratePepeMessage:
    String "----------------"
    String "  Pepe Gerado   "
    String "  XXXX          "
    String "  Troco: XX.XX  "
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
    String "  X.XX          "
    String "1- Comprar      "
    String "5- Recarregar   "
    String "----------------"

Place 480H
MachineStockMenu:
    String "---Stock  3/4---"
    String "Moeda de 50 cent"
    String " XXXX           "
    String "Moeda de 20 cent"
    String " XXXX           "
    String "Moeda de 10 cent"
    String " XXXX           "
    String "1- Continuar    "
    String "----------------"

Place 500H
InsertMoneyMenu:
    String "----------------"
	String "Inserir dinheiro"
	String "Inserido:   X,XX"
	String "Preco:      X,XX"
	String "----------------"
	String "1)Inserir       "
    String "2)Pagar         "
    String "3)Cancelar      "

Place 580H
ChooseMoneyMenu:
    String "Forma Pagamento "
	String "1)5,00          "
	String "2)2,00          "
	String "3)1,00          "
	String "4)0,50          "
	String "5)0,20          "
	String "6)0,10          "  



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
    CALL CleanInsertedMemory         ;Clean the addresses that will hold the inserted values
    CALL CleanPeripherals           ;Call rotine to clean peripherals
    MOV R0, IN_PER                  ;Loads input peripheral address to R0
    MOVB R1, [R0]                   ;Reads the value on the input peripheral to R1, a byte so the first memory slot is used
    CMP R1, 1                       ;Compares R1 with the value 1
    JEQ BuyPepeScreen               ;Call rotine to handle the buy option
    CMP R1, 2                       ;Compares R1 with the value 2
    ;JEQ UseCard                          
    CMP R1, 3                       ;Compares R1 with the value 3
    ;JEQ Stock
    JMP Main_Menu_Selection         ;In case option is invalid or nor selected, repeat rotine


BuyPepeScreen:
    MOV R2, StationMenu             ;Moves to R2 the stationMenu address
    CALL SetupScreen                ;Updates the screen
BuyPepe:
    CALL CleanPeripherals           ;Call rotine to clean peripherals
    MOV R0, IN_PER                  ;Loads input peripheral address to R0
    MOVB R1, [R0]                   ;Reads the value on the input peripheral to R1, a byte so the first memory slot is used
    CMP R1, 1                       ;Compares R1 with the value 1
    JEQ Station2Screen              ;Call Station2LogicRotine
    CMP R1, 2                       ;Compares R1 with the value 2
    JEQ Station3Screen              ;Call Station3LogicRotine
    CMP R1, 3                       ;Compares R1 with the value 3
    JEQ Station4Screen              ;Call Station4LogicRotine
    CMP R1, 4                       ;Compares R1 with the value 4
    JEQ Station5Screen              ;Call Station5LogicRotine
    CMP R1, 5                       ;Compares R1 with the value 5
    ;JEQ cancelar
    JMP BuyPepe                     ;In case the option is invalid or not selected, repeat rotine


Station2Screen:
    MOV R3, Station2_number         ;So after adding money, we know to which station to return
    MOV R2, InsertMoneyMenu         ;Moves to R2 the InsertMoneyMenu address
    CALL SetupScreen                ;Updates the screen
Station2UpdatePrice:
    MOV R4, Price_money_euro        ;Set R4 with the address of the euro position on the display
    MOV R5, Station2_euro_display   ;Set R5 with the value to be shown
    MOVB [R4], R5                   ;Mov the value in R5 to the first byte pointed by R4
    MOV R4, Price_money_cent        ;Set R4 with the address of the cents in the display
    MOV R5, Station2_cent_display   ;Set R5 with the value to be shown
    MOV [R4], R5                    ;Mov the value in R5 to the address pointed to by R4
    CALL StationUpdateInsertedMoney

Station3Screen:
    MOV R3, Station3_number         ;So after adding money, we know to which station to return
    MOV R2, InsertMoneyMenu         ;Moves to R2 the InsertMoneyMenu address
    CALL SetupScreen                ;Updates the screen
Station3UpdatePrice:
    MOV R4, Price_money_euro        ;Set R4 with the address of the euro position on the display
    MOV R5, Station3_euro_display   ;Set R5 with the value to be shown
    MOVB [R4], R5                   ;Mov the value in R5 to the first byte pointed by R4
    MOV R4, Price_money_cent        ;Set R4 with the address of the cents in the display
    MOV R5, Station3_cent_display   ;Set R5 with the value to be shown
    MOV [R4], R5                    ;Mov the value in R5 to the address pointed to by R4
    CALL StationUpdateInsertedMoney

Station4Screen:
    MOV R3, Station4_number         ;So after adding money, we know to which station to return
    MOV R2, InsertMoneyMenu         ;Moves to R2 the InsertMoneyMenu address
    CALL SetupScreen                ;Updates the screen
Station4UpdatePrice:
    MOV R4, Price_money_euro        ;Set R4 with the address of the euro position on the display
    MOV R5, Station4_euro_display   ;Set R5 with the value to be shown
    MOVB [R4], R5                   ;Mov the value in R5 to the first byte pointed by R4
    MOV R4, Price_money_cent        ;Set R4 with the address of the cents in the display
    MOV R5, Station4_cent_display   ;Set R5 with the value to be shown
    MOV [R4], R5                    ;Mov the value in R5 to the address pointed to by R4
    CALL StationUpdateInsertedMoney

Station5Screen:
    MOV R3, Station5_number         ;So after adding money, we know to which station to return
    MOV R2, InsertMoneyMenu         ;Moves to R2 the InsertMoneyMenu address
    CALL SetupScreen                ;Updates the screen
Station5UpdatePrice:
    MOV R4, Price_money_euro        ;Set R4 with the address of the euro position on the display
    MOV R5, Station5_euro_display   ;Set R5 with the value to be shown
    MOVB [R4], R5                   ;Mov the value in R5 to the first byte pointed by R4
    MOV R4, Price_money_cent        ;Set R4 with the address of the cents in the display
    MOV R5, Station5_cent_display   ;Set R5 with the value to be shown
    MOV [R4], R5                    ;Mov the value in R5 to the address pointed to by R4´
    CALL StationUpdateInsertedMoney

StationUpdateInsertedMoney:
    MOV R5, Display_constant        ;Mov the value of the display constant to R5
    MOV R4, Inserted_euro           ;Mov to R4 the address in memory that will hold the euros added
    MOV R6, [R4]                    ;Mov to R6 the value pointed by the address in R4
    ADD R5, R6                      ;Add the constant so the value displayed is correct
    MOV R4, Inserted_money_euro     ;Mov to R4 the address of the inserted euros on the display
    MOVB [R4], R5                   ;Display the value of R5 in the screen position pointed by R4
    MOV R5, Display_constant        ;Mov the value of the display constant to R5
    MOV R4, Inserted_cent1          ;Address of the first cent digit on the display to R5
    MOV R6, [R4]                    ;Pass to R6 the cent value in memory pointed by R4
    ADD R5, R6                      ;Add the display constant so the value displayed is correct
    MOV R4, Inserted_money_cent1    ;Mov to R4 the screen position of the first digit of the cents on the display
    MOVB [R4], R5                   ;Display on that position the cent value stored in R5 
    MOV R5, Display_constant        ;Mov the value of the display constant to R5
    MOV R6, 0                       ;The second digit of the cents will always be 0
    ADD R5, R6                      ;Add the display constant so the value displayed is correct
    MOV R4, Inserted_money_cent2    ;Mov to R4 the screen position of the first digit of the cents on the display
    MOVB [R4], R5                   ;Display the value of the second digit of the cents
StationMenuLogic:
    CALL CleanPeripherals           ;Call rotine to clean peripherals
    MOV R0, IN_PER                  ;Loads input peripheral address to R0
    MOVB R1, [R0]                   ;Reads the value on the input peripheral to R1, a byte so the first memory slot is used
    CMP R1, 1                       ;Compares R1 with the value 1
    JEQ InsertMoneyScreen           ;If equal go to the menu that allows to insert money
    CMP R1, 2                       ;Compares R1 with the value 2
    ;JEQ Pagar
    CMP R1, 3                       ;Compares R1 with the value 3
    ;JEQ Cancelar
    JMP StationMenuLogic            ;Jump to StationMenuLogic

MoveCorrectScreen:
    CMP R3, Station2_number         ;Compare the value in R3 with the number for station 2 
    JEQ Station2Screen              ;If they are equal, call the function to present the price of station2
    CMP R3, Station3_number         ;Compare the value in R3 with the number for station 3 
    JEQ Station3Screen              ;If they are equal, call the function to present the price of station3
    CMP R3, Station4_number         ;Compare the value in R3 with the number for station 4 
    JEQ Station3Screen              ;If they are equal, call the function to present the price of station4
    CMP R3, Station5_number         ;Compare the value in R3 with the number for station 5 
    JEQ Station3Screen              ;If they are equal, call the function to present the price of station5

InsertMoneyScreen:
    MOV R2, ChooseMoneyMenu         ;Moves to R2 the ChooseMoneyMenu address
    CALL SetupScreen                ;Updates the screen
InsertMoney:
    CALL CleanPeripherals           ;Call rotine to clean peripherals
    MOV R0, IN_PER                  ;Loads input peripheral address to R0
    MOVB R1, [R0]                   ;Reads the value on the input peripheral to R1, a byte so the first memory slot is used
    CMP R1, 1                       ;Compares R1 with the value 1
    JEQ euro5added                  ;Calls logic to add 5 euros
    CMP R1, 2                       ;Compares R1 with the value 2
    JEQ euro2added                  ;Call the logic to add 2 euros
    CMP R1, 3                       ;Compares R1 with the value 3
    JEQ euro1added                  ;Call the logic to add 1 euro
    CMP R1, 4                       ;Compares R1 with the value 3
    JEQ cent50added                 ;Call the logic to add 50 cents
    CMP R1, 5                       ;Compares R1 with the value 3
    JEQ cent20added                 ;Call the logic to add 20 cents
    CMP R1, 6                       ;Compares R1 with the value 3
    JEQ cent10added                 ;Call the logic to add 10 cents
    JMP InsertMoney                 ;In case the option is invalid or not selected, repeat rotine

euro5added:
    MOV R4, Inserted_euro           ;Mov to R4 the address in memory that will hold the euros added
    MOV R5, 5                       ;Mov the value 5 to R5
    MOV R6, [R4]                    ;Mov to R6 the value stored on R4
    ADD R5, R6                      ;Sum the value already added to the value to be added
    MOV [R4], R5                    ;Put the current value on the memory address pointed by R4
    CALL MoveCorrectScreen          ;Call rotine to jump to the correct station screen
euro2added:
    MOV R4, Inserted_euro           ;Mov to R4 the address in memory that will hold the euros added
    MOV R5, 2                       ;Mov the value 2 to R5
    MOV R6, [R4]                    ;Mov to R6 the value stored on R4
    ADD R5, R6                      ;Sum the value already added to the value to be added
    MOV [R4], R5                    ;Put the current value on the memory address pointed by R4
    CALL MoveCorrectScreen          ;Call rotine to jump to the correct station screen
euro1added:
    MOV R4, Inserted_euro           ;Mov to R4 the address in memory that will hold the euros added
    MOV R5, 1                       ;Mov the value 1 to R5
    MOV R6, [R4]                    ;Mov to R6 the value stored on R4
    ADD R5, R6                      ;Sum the value already added to the value to be added
    MOV [R4], R5                    ;Put the current value on the memory address pointed by R4
    CALL MoveCorrectScreen          ;Call rotine to jump to the correct station screen
cent50added:
    MOV R4, Inserted_cent1          ;Memory address that holds how many cents have been added
    MOV R5, 5                       ;Put 5 in R5 to simbolize 50 cents
    MOV R6, [R4]                    ;Pass the cents already incerted to R6
    ADD R5, R6                      ;Add the value already incerted to the value beign incerted 
    MOV R7, Cent_overflow           ;Pass the value where an "overflow of cents" would happen         
    CMP R5, R7                      ;Compare the value of cents added ot the overflow value
    JGE HandleCentOverflow          ;In case R5 is equal or greater jump to the routine to handle the overflow
    MOV [R4], R5                    ;Put the current value on the memory address pointed by R4
    CALL MoveCorrectScreen          ;Call rotine to jump to the correct station screen
cent20added:
    MOV R4, Inserted_cent1          ;Memory address that holds how many cents have been added
    MOV R5, 2                       ;Put 5 in R5 to simbolize 50 cents
    MOV R6, [R4]                    ;Pass the cents already incerted to R6
    ADD R5, R6                      ;Add the value already incerted to the value beign incerted 
    MOV R7, Cent_overflow           ;Pass the value where an "overflow of cents" would happen         
    CMP R5, R7                      ;Compare the value of cents added ot the overflow value
    JGE HandleCentOverflow          ;In case R5 is equal or greater jump to the routine to handle the overflow
    MOV [R4], R5                    ;Put the current value on the memory address pointed by R4
    CALL MoveCorrectScreen          ;Call rotine to jump to the correct station screen
cent10added:
    MOV R4, Inserted_cent1          ;Memory address that holds how many cents have been added
    MOV R5, 1                       ;Put 5 in R5 to simbolize 50 cents
    MOV R6, [R4]                    ;Pass the cents already incerted to R6
    ADD R5, R6                      ;Add the value already incerted to the value beign incerted 
    MOV R7, Cent_overflow           ;Pass the value where an "overflow of cents" would happen         
    CMP R5, R7                      ;Compare the value of cents added ot the overflow value
    JGE HandleCentOverflow          ;In case R5 is equal or greater jump to the routine to handle the overflow
    MOV [R4], R5                    ;Put the current value on the memory address pointed by R4
    CALL MoveCorrectScreen          ;Call rotine to jump to the correct station screen

HandleCentOverflow:
    SUB R5, R7                      ;Subtract the overflow value from R5
    MOV R4, Inserted_cent1          ;Memory address that holds the inserted cents
    MOV [R4], R5                    ;Put the current value on the memory address pointed by R4
    MOV R4, Inserted_euro           ;Mov to R4 the address in memory that will hold the euros added
    MOV R5, 1                       ;Mov the value 1 to R5
    MOV R6, [R4]                    ;Mov to R6 the value stored on R4
    ADD R5, R6                      ;Sum the value already added to the value to be added
    MOV [R4], R5                    ;Put the current value on the memory address pointed by R4
    CALL MoveCorrectScreen          ;Call rotine to jump to the correct station screen

Pagar_PEPE:
    ;Verificar se têm dinheiro suficiente
    ;Se tem procede com o pagamento
    ;Se não tem apresenta mensagem de erro e volta ao menu anterior

CleanInsertedMemory:
    MOV R4, Inserted_euro           ;Mov to R4 the address of the inserted euros
    MOV R5, 0                       ;Mov to R5 the value 0
    MOV [R4], R5                    ;Set inserted euros to 0 on memory
    MOV R4, Inserted_cent1          ;Mov to R4 the address of the inserted euros
    MOV R5, 0                       ;Mov to R5 the value 0
    MOV [R4], R5                    ;Set inserted euros to 0 on memory
    MOV R4, Inserted_cent2          ;Mov to R4 the address of the inserted euros
    MOV R5, 0                       ;Mov to R5 the value 0
    MOV [R4], R5                    ;Set inserted euros to 0 on memory
    RET
    
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