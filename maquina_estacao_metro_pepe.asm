; Input peripherals
IN_PER               EQU 40H

; Output peripherals
DISPLAY_BEGIN        EQU 60H
DISPLAY_END          EQU 223

; Stack Pointer
StackPointer         EQU 6000H

; ScreenPositions
Inserted_money_euro EQU 140         ;Display position of the inserted euro
Inserted_money_cent1 EQU 142        ;Display position of the inserted cent first digit
Inserted_money_cent2 EQU 143        ;Display position of the inserted cent second digit
Price_money_euro    EQU 156         ;Display position of the price to be paid euros
Price_money_cent    EQU 158         ;Display position of the price to be paid cents

; Constants
Display_constant      EQU 30H       ;Constant that represents 0 on the display
Cent_overflow         EQU 10        ;In case the cents have overflown, subtract 10

Station2_number       EQU 2         ;Number of the station
Station2_price        EQU 150       ;Price of the ticket in cents

Station3_number       EQU 3         ;Number of the station
Station3_price        EQU 250       ;Price of the ticket in cents

Station4_number       EQU 4         ;Number of the station
Station4_price        EQU 350       ;Price of the ticket in cents

Station5_number       EQU 4         ;Number of the station
Station5_price        EQU 550       ;Price of the ticket in cents

; Variables
Inserted_money       EQU 8000H      ;Hold the current money inserted on memory
Price_pay            EQU 8030H      ;Hold the price to be payed



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
    String "  Troco: 00.00  "
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
    String "  0.00          "
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
	String "Inserido:   0,00"
	String "Preco:      0,00"
	String "----------------"
	String "1)Inserir       "
    String "2)Pagar         "
    String "3)Cancelar      "

Place 580H
ChooseMoneyMenu:
    String "Valor Pagamento "
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
    CALL Clean_Inserted_Memory      ;Clean the addresses that will hold the inserted values
    CALL Clean_Peripherals          ;Call rotine to clean peripherals
    MOV R0, IN_PER                  ;Loads input peripheral address to R0
    MOVB R1, [R0]                   ;Reads the value on the input peripheral to R1, a byte so the first memory slot is used
    CMP R1, 1                       ;Compares R1 with the value 1
    JEQ Buy_Pepe_Screen             ;Call rotine to handle the buy option
    CMP R1, 2                       ;Compares R1 with the value 2
    ;JEQ UseCard                          
    CMP R1, 3                       ;Compares R1 with the value 3
    ;JEQ Stock
    JMP Main_Menu_Selection         ;In case option is invalid or nor selected, repeat rotine


Buy_Pepe_Screen:
    MOV R2, StationMenu             ;Moves to R2 the stationMenu address
    CALL SetupScreen                ;Updates the screen
Buy_Pepe:
    CALL Clean_Peripherals          ;Call rotine to clean peripherals
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
    JEQ Main_Menu_Selection         ;Goes back to the main menu
    JMP Buy_Pepe                    ;In case the option is invalid or not selected, repeat rotine


Station2Screen:
    MOV R3, Station2_number         ;Put in R3 the number of the station we are working on
    MOV R4, Station2_price          ;Put in R4 the price of the ticket on that station
    MOV R2, InsertMoneyMenu         ;Moves to R2 the InsertMoneyMenu address
    CALL SetupScreen                ;Updates the screen

Station3Screen:
    MOV R3, Station3_number         ;So after adding money, we know to which station to return
    MOV R4, Station3_price          ;Put in R4 the price of the ticket on that station
    MOV R2, InsertMoneyMenu         ;Moves to R2 the InsertMoneyMenu address
    CALL SetupScreen                ;Updates the screen

Station4Screen:
    MOV R3, Station4_number         ;So after adding money, we know to which station to return
    MOV R4, Station4_price          ;Put in R4 the price of the ticket on that station
    MOV R2, InsertMoneyMenu         ;Moves to R2 the InsertMoneyMenu address
    CALL SetupScreen                ;Updates the screen

Station5Screen:
    MOV R3, Station5_number         ;So after adding money, we know to which station to return
    MOV R4, Station5_price          ;Put in R4 the price of the ticket on that station
    MOV R2, InsertMoneyMenu         ;Moves to R2 the InsertMoneyMenu address
    CALL SetupScreen                ;Updates the screen

StationUpdatePrice:
    MOV R5, R4                      ;Put the price of the ticket on R5
    MOV R6, 100                     ;Put in R6 100, so we can separate the price between euros and cents
    DIV R5, R6                      ;Division between the price and 100, to get the value in euros
    MOV R6, Display_constant        ;Put the constant to add for the values to be displayed on R6
    ADD R5, R6                      ;Apply the constant to display the value
    MOV R7, Price_money_euro        ;Move the address of the price in euros of the ticket on the display to R7
    MOVB [R7], R5                   ;Update the price on the display
    MOV R5, R4                      ;Put the price of the ticket on R5
    MOV R6, 100                     ;Put in R6 100, so we can separate the price between euros and cents
    MOD R5, R6                      ;Rest of the division between R5 and R6 to get the value of cents
    MOV R6, 10                      ;Put in R6 10, so we can get the first digit of the cents
    DIV R5, R6                      ;Get the first digit of the cents
    MOV R6, Display_constant        ;Put the constant to add for the values to be displayed on R6
    ADD R5, R6                      ;Apply the constant to display the value
    MOV R7, Price_money_cent        ;Move the address of the price in cents of the ticket on the display to R7
    MOVB [R7], R5                   ;Update the price on the display
StationUpdateInsertedMoney:
    MOV R4, Inserted_money          ;Address that stores how much money has been inserted
    MOV R5, [R4]                    ;Put the value of how much has been inserted in R5
    MOV R6, 100                     ;Put in R6 100, so we can separate the price between euros and cents
    DIV R5, R6                      ;Division between the price and 100, to get the value in euros
    MOV R6, Display_constant        ;Put the constant to add for the values to be displayed on R6
    ADD R5, R6                      ;Apply the constant to display the value
    MOV R7, Inserted_money_euro     ;Move the address of the price in euros of the ticket on the display to R7
    MOVB [R7], R5                   ;Update the price on the display
    MOV R5, [R4]                    ;Put the value of how much has been inserted in R5
    MOV R6, 100                     ;Put in R6 100, so we can separate the price between euros and cents
    MOD R5, R6                      ;Rest of division between the price and 100, to get the value in cents
    MOV R6, 10                      ;Put in R6 10, so we can get the first digit of the cents
    DIV R5, R6                      ;Get the first digit of the cents
    MOV R6, Display_constant        ;Put the constant to add for the values to be displayed on R6
    ADD R5, R6                      ;Apply the constant to display the value
    MOV R7, Inserted_money_cent1    ;Move the address of the price in euros of the ticket on the display to R7
    MOVB [R7], R5                   ;Update the price on the display
StationMenuLogic:
    CALL Clean_Peripherals           ;Call rotine to clean peripherals
    MOV R0, IN_PER                  ;Loads input peripheral address to R0
    MOVB R1, [R0]                   ;Reads the value on the input peripheral to R1, a byte so the first memory slot is used
    CMP R1, 1                       ;Compares R1 with the value 1
    JEQ InsertMoneyScreen           ;If equal go to the menu that allows to insert money
    CMP R1, 2                       ;Compares R1 with the value 2
    ;JEQ Pagar
    CMP R1, 3                       ;Compares R1 with the value 3
    JEQ Main_Menu_Selection         ;Goes back to the main menu
    JMP StationMenuLogic            ;Jump to StationMenuLogic

Move_Correct_Station:
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
    CALL Clean_Peripherals          ;Call rotine to clean peripherals
    MOV R0, IN_PER                  ;Loads input peripheral address to R0
    MOVB R1, [R0]                   ;Reads the value on the input peripheral to R1, a byte so the first memory slot is used
    CMP R1, 1                       ;Compares R1 with the value 1
    JEQ Add_5_Euros                 ;Calls logic to add 5 euros
    CMP R1, 2                       ;Compares R1 with the value 2
    JEQ Add_2_Euros                 ;Call the logic to add 2 euros
    CMP R1, 3                       ;Compares R1 with the value 3
    JEQ Add_1_Euro                  ;Call the logic to add 1 euro
    CMP R1, 4                       ;Compares R1 with the value 3
    JEQ Add_50_cents                ;Call the logic to add 50 cents
    CMP R1, 5                       ;Compares R1 with the value 3
    JEQ Add_20_cents                ;Call the logic to add 20 cents
    CMP R1, 6                       ;Compares R1 with the value 3
    JEQ Add_10_cents                ;Call the logic to add 10 cents
    JMP InsertMoney                 ;In case the option is invalid or not selected, repeat rotine

Add_5_Euros:
    MOV R5, 500                     ;Mov the value 500 to R5
    CALL Add_Inserted_Money_Memory  ;Call rotine to jump to the correct station screen
Add_2_Euros:
    MOV R5, 200                     ;Mov the value 200 to R5
    CALL Add_Inserted_Money_Memory  ;Call rotine to jump to the correct station screen
Add_1_Euro:
    MOV R5, 100                     ;Mov the value 100 to R5
    CALL Add_Inserted_Money_Memory  ;Call rotine to jump to the correct station screen
Add_50_cents:
    MOV R5, 50                      ;Put 5 in R5 to simbolize 50 cents
    CALL Add_Inserted_Money_Memory  ;Call rotine to jump to the correct station screen
Add_20_cents:
    MOV R5, 20                      ;Put 5 in R5 to simbolize 50 cents
    CALL Add_Inserted_Money_Memory  ;Call rotine to jump to the correct station screen
Add_10_cents:
    MOV R5, 10                      ;Put 5 in R5 to simbolize 50 cents
    CALL Add_Inserted_Money_Memory  ;Call rotine to jump to the correct station screen

Add_Inserted_Money_Memory:
    MOV R4, Inserted_money          ;Memory address that holds how many cents have been added
    MOV R6, [R4]                    ;Pass the cents already incerted to R6
    ADD R5, R6                      ;Add the value already incerted to the value beign incerted 
    MOV [R4], R5                    ;Put the current value on the memory address pointed by R4
    CALL Move_Correct_Station       ;Call rotine to jump to the correct station screen



Buy_Pepe_Ticket:
    ;Compara valor inserido nos euros com o valor do preço
    ;Se maior salta para parte com o dinheiro suficiente
    ;Se igual continua
    ;Comparar valor inserido nos centimos como o valor do preço
    ;Se maior ou igual salta para a parte com o dinheiro suficiente
    ;Se tem procede com o pagamento, e criar um pepe com um código único e saldo
    ;Se não tem apresenta mensagem de erro e volta ao menu anterior

Not_Enough_Money:
    ;Lógica para caso não tenha dinheiro suficiente

Enough_Money:
    ;Lógica para caso exista dinheiro suficiente

Clean_Inserted_Memory:
    MOV R4, Inserted_money          ;Mov to R4 the address of the inserted money
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

Clean_Peripherals:
    PUSH R0							;Stores R0 in the stackpointer
    PUSH R1                         ;Stores R1 in the stackpointer
	MOV R0, IN_PER					;Reads the address of the input peripheral
	MOV R1, 0                       ;Moves to R1 the value 0
    MOVB [R0], R1					;Moves to the value the address stored in R0 the value of R1
	POP R1                          ;Restores the value of R1
    POP R0							;Restores the value of R0
	RET								;Goes back to the address stores in the stackpointers