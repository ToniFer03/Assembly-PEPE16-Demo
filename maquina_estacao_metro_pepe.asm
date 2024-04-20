; Input peripherals
IN_PER                                      EQU 0050H   ;Main input, for selecting options in menus
TICKET_NUMBER_1                             EQU 0010H   ;For the first digit of the Pepe ticket (X000)
TICKET_NUMBER_2                             EQU 0020H   ;For the second digit of the Pepe ticket (0X00)
TICKET_NUMBER_3                             EQU 0030H   ;For the thid digit of the Pepe ticket (00X0)
TICKET_NUMBER_4                             EQU 0040H   ;For the fourth digit of the Pepe ticket (000X)

; Output peripherals
DISPLAY_BEGIN                               EQU 0060H   ;Position that the display begins
DISPLAY_END                                 EQU 00DFH   ;Position that the display ends

; Stack Pointer
StackPointer                                EQU 6000H   ;Pointer to the stack memory

; ScreenPositions
Display_Position_Inserted_Euro              EQU 008CH   ;Display position of the inserted euro
Display_Position_Inserted_Cent              EQU 008EH   ;Display position of the inserted cent first digit
Display_Position_Price_Euro                 EQU 009CH   ;Display position of the price to be paid euros
Display_Position_Price_Cent                 EQU 009EH   ;Display position of the price to be paid cents
Display_Position_Ticket_Number_Thousand     EQU 0082H   ;First digit of the ticket number
Display_Position_Ticket_Number_Hundreds     EQU 0083H   ;Second digit of the ticket number
Display_Position_Ticket_Number_Dozens       EQU 0084H   ;Third digit of the ticket number
Display_Position_Ticket_Number_Units        EQU 0085H   ;Fourth digit of the ticket number
Display_Position_Ticket_Change_Euro         EQU 0099H   ;Euro digit of the change
Display_Position_Ticket_Change_Cent         EQU 009BH   ;First cent digit of the change
Display_Position_Ticket_Balance_Euro        EQU 0082H   ;Display position of the pepe balance
Display_Position_Ticket_Balance_Cent        EQU 0084H   ;Display position of the cents balance
Display_Position_Ticket_New_Balance_Euro    EQU 00A7H   ;Display position that has the new balance in euros on the screen
Display_Position_Ticket_New_Balance_Cent    EQU 00A9H   ;Display position that has the new balance in cents on the screen


; Constants
Display_Constant                            EQU 30H     ;Constant that represents 0 on the display
Cent_overflow                               EQU 10      ;In case the cents have overflown, subtract 10

Station2_number                             EQU 2       ;Number of the station
Station2_price                              EQU 150     ;Price of the ticket in cents

Station3_number                             EQU 3       ;Number of the station
Station3_price                              EQU 250     ;Price of the ticket in cents

Station4_number                             EQU 4       ;Number of the station
Station4_price                              EQU 350     ;Price of the ticket in cents

Station5_number                             EQU 5       ;Number of the station
Station5_price                              EQU 550     ;Price of the ticket in cents

; Variables
Memory_Address_Inserted_Memory              EQU 8000H   ;Hold the current money inserted on memory
Memory_Address_Price_Pay                    EQU 8010H   ;Hold the price to be payed

; PEPE Ticket Base Memories
Memory_Address_Number_Tickets_Created       EQU 8FF0H   ;Will hold the number of tickets that have been created
Memory_Address_Ticket_Number                EQU 9000H   ;Will hold the number of the pepe code
Memory_Address_Ticket_Balance               EQU 9010H   ;Will hold the charge of the PEPE ticket
Memory_Interval_Between_Tickets             EQU 0020H   ;The difference between memory address of 2 pepe tickets  



; Displays to be shown
Place 200H
Main_Menu:
    String "----------------"
    String " Maquina Vendas "
    String "     Vendas     "
    String "                "
    String "1- Comprar      "
    String "2- Usar Cartao  "
    String "3- Stock        "
    String "----------------"

Place 280H
Choose_Station_Menu:
    String "  Menu Estacao  "
    String "                "
    String "1-Estacao2: 1.50"
    String "2-Estacao3: 2.50"
    String "3-Estacao4: 3.50"
    String "4-Estacao5: 5.50"
    String "5-Cancelar      "
    String "----------------"

Place 300H
Generated_Ticket_Menu:
    String "----------------"
    String "  Pepe Gerado   "
    String "  XXXX          "
    String "  Troco: 0.00   "
    String "1- Continuar    "
    String "----------------"

Place 380H
Introduce_Ticket_Number_Menu:
    String "----------------"
    String " Introduzir N.  "
    String " Pepe           "
    String "  XXXX          "
    String "1- Continuar    "
    String "5- Cancelar     "
    String "----------------"

Place 400H
Ticket_Menu:
    String "----------------"
    String " Saldo Pepe     "
    String "  0.00          "
    String "1- Comprar      "
    String "2- Recarregar   "
    String "----------------"

Place 480H
Machine_Coin_Stock_Menu:
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
Pay_Menu:
    String "----------------"
	String "Inserir dinheiro"
	String "Inserido:   0,00"
	String "Preco:      0,00"
	String "----------------"
	String "1)Inserir       "
    String "2)Pagar         "
    String "3)Cancelar      "

Place 580H
Choose_Inserted_Value_Menu:
    String "Valor Pagamento "
	String "1)5,00          "
	String "2)2,00          "
	String "3)1,00          "
	String "4)0,50          "
	String "5)0,20          "
	String "6)0,10          "

Place 600H
Not_Enough_Money_Message:
    String "----------------"
	String "  Sem Dinheiro  "
	String "   Suficiente   "
	String "Para o Pagamento"
	String "----------------"
	String "1)Voltar atras  "
    String "2)Cancelar      "

Place 680H
Pepe_Ticket_Buy_Success:
    String "----------------"
    String "Compra efetuada "
    String "com Sucesso     "
    String "                "
    String "Saldo: 0.00     "
    String "1- Continuar    "
    String "----------------"

Place 700H
Pepe_Ticket_Recharge_Success:
    String "----------------"
    String "Carregamento do "
    String "ticket validado "
    String "                "
    String "Saldo: 0.00     "
    String "1- Continuar    "
    String "----------------"

Place 780H
No_Ticket_With_That_Number:
    String "----------------"
	String "  Nao existe    "
	String "    ticket      "
	String " com tal numero "
	String "----------------"
	String "1)Voltar atras  "
    String "2)Cancelar      "


;Setup Instructions
Place 0H
Setup:
    MOV R0, Begin
    JMP R0


;Program Instructions
Place 3500H
Begin:
    MOV SP, StackPointer                            ;Stack Pointer
    CALL Main_Menu_Screen                           ;Call the routine to start the program

Main_Menu_Screen:
    MOV R2, Main_Menu                               ;Load the memory address of the main menu screen to R2
    CALL Setup_Show_Screen                          ;Call the routine to display the menu on the screen
Main_Menu_Selection:
    CALL Clean_Inserted_Memory                      ;Call routine responsible to clean the address that holds the inserted money
    CALL Read_Main_Input_Peripheric                 ;Call routine to read the input and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Buy_Ticket_Screen                           ;Call routine to handle the buy option
    CMP R1, 2                                       ;Compares R1 with the value 2
    JEQ Intermediate1_Use_Card                      ;Call routine to handle the use card option                         
    CMP R1, 3                                       ;Compares R1 with the value 3
    ;JEQ Stock
    JMP Main_Menu_Selection                         ;In case option is invalid or nor selected, repeat rotine

;Use_Card_screen, appears out of bounds when using jumps so this is a work around
Intermediate1_Use_Card:
    CALL Use_Card_Screen                            ;Call routine to handle the use card option

Buy_Ticket_Screen:
    MOV R2, Choose_Station_Menu                     ;Moves to R2 the Choose_Station_Menu address
    CALL Setup_Show_Screen                          ;Updates the screen
Buy_Ticket:
    CALL Read_Main_Input_Peripheric                 ;Call routine to read the input and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Station_2_Screen                            ;Call Station2LogicRotine
    CMP R1, 2                                       ;Compares R1 with the value 2
    JEQ Station_3_Screen                            ;Call Station3LogicRotine
    CMP R1, 3                                       ;Compares R1 with the value 3
    JEQ Station_4_Screen                            ;Call Station4LogicRotine
    CMP R1, 4                                       ;Compares R1 with the value 4
    JEQ Station_5_Screen                            ;Call Station5LogicRotine
    CMP R1, 5                                       ;Compares R1 with the value 5
    JEQ Main_Menu_Screen                            ;If canceled is choosen, go back to the main menu
    JMP Buy_Ticket                                  ;In case the option is invalid or not selected, repeat rotine


Station_2_Screen:
    MOV R3, Station2_number                         ;Put in R3 the number of the station we are working on
    MOV R4, Station2_price                          ;Put in R4 the price of the ticket on that station
    MOV R5, Memory_Address_Price_Pay                ;Memory address that will hold the price to be payed in this station
    MOV [R5], R4                                    ;Update the memory address with the price to be payed
    CALL Pay_Menu_Screen                            ;Call routine present menu to pay without a card

Station_3_Screen:
    MOV R3, Station3_number                         ;So after adding money, we know to which station to return
    MOV R4, Station3_price                          ;Put in R4 the price of the ticket on that station
    MOV R5, Memory_Address_Price_Pay                ;Memory address that will hold the price to be payed in this station
    MOV [R5], R4                                    ;Update the memory address with the price to be payed
    CALL Pay_Menu_Screen                            ;Call routine present menu to pay without a card

Station_4_Screen:
    MOV R3, Station4_number                         ;So after adding money, we know to which station to return
    MOV R4, Station4_price                          ;Put in R4 the price of the ticket on that station
    MOV R5, Memory_Address_Price_Pay                ;Memory address that will hold the price to be payed in this station
    MOV [R5], R4                                    ;Update the memory address with the price to be payed
    CALL Pay_Menu_Screen                            ;Call routine present menu to pay without a card

Station_5_Screen:
    MOV R3, Station5_number                         ;So after adding money, we know to which station to return
    MOV R4, Station5_price                          ;Put in R4 the price of the ticket on that station
    MOV R5, Memory_Address_Price_Pay                ;Memory address that will hold the price to be payed in this station
    MOV [R5], R4                                    ;Update the memory address with the price to be payed
    CALL Pay_Menu_Screen                            ;Call routine present menu to pay without a card


Pay_Menu_Screen:
    MOV R2, Pay_Menu                                ;Moves to R2 the Pay_Menu address
    CALL Setup_Show_Screen                          ;Updates the screen
Update_Price_In_Pay_Menu:
    MOV R5, R4                                      ;Put the price of the ticket on R5
    MOV R1, Display_Position_Price_Euro             ;Put the screen address that displays the euro (price) on R1
    MOV R4, Display_Position_Price_Cent             ;Put the screen address that displays the first digit of the cents (price)
    CALL Update_Money_Value_Screen                  ;Call routine responsible for updating those values on screen
Update_Inserted_Money_In_Pay_Menu:
    MOV R1, Display_Position_Inserted_Euro          ;Put the screen address that displays the euro (inserted) on R1
    MOV R4, Display_Position_Inserted_Cent          ;Put the screen address that displays the first digit of the cents (inserted)
    MOV R7, Memory_Address_Inserted_Memory          ;Memory address that stores how much money has been inserted until now
    MOV R5, [R7]                                    ;Put the value of how much has been inserted in R5
    CALL Update_Money_Value_Screen                  ;Call routine responsible for updating those values on screen
Pay_Menu_Logic:
    CALL Read_Main_Input_Peripheric                 ;Call routine to read the input and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Insert_Money_Screen                         ;If equal go to the menu that allows to insert money
    CMP R1, 2                                       ;Compares R1 with the value 2
    JEQ Proceed_Payment_Menu                        ;Menu to prooced with the payment
    CMP R1, 3                                       ;Compares R1 with the value 3
    JEQ Main_Menu_Screen                            ;Goes back to the main menu
    JMP Pay_Menu_Logic                              ;Jump to Pay_Menu_Logic

Move_Correct_Station:
    CMP R3, Station2_number                         ;Compare the value in R3 with the number for station 2 
    JEQ Station_2_Screen                            ;If they are equal, call the function to present the price of station2
    CMP R3, Station3_number                         ;Compare the value in R3 with the number for station 3 
    JEQ Station_3_Screen                            ;If they are equal, call the function to present the price of station3
    CMP R3, Station4_number                         ;Compare the value in R3 with the number for station 4 
    JEQ Station_4_Screen                            ;If they are equal, call the function to present the price of station4
    CMP R3, Station5_number                         ;Compare the value in R3 with the number for station 5 
    JEQ Station_5_Screen                            ;If they are equal, call the function to present the price of station5

Insert_Money_Screen:
    MOV R2, Choose_Inserted_Value_Menu              ;Moves to R2 the Choose_Inserted_Value_Menu address
    CALL Setup_Show_Screen                          ;Updates the screen
Insert_Money:
    CALL Read_Main_Input_Peripheric                 ;Call routine to read the input and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Add_5_Euros                                 ;Calls logic to add 5 euros
    CMP R1, 2                                       ;Compares R1 with the value 2
    JEQ Add_2_Euros                                 ;Call the logic to add 2 euros
    CMP R1, 3                                       ;Compares R1 with the value 3
    JEQ Add_1_Euro                                  ;Call the logic to add 1 euro
    CMP R1, 4                                       ;Compares R1 with the value 3
    JEQ Add_50_cents                                ;Call the logic to add 50 cents
    CMP R1, 5                                       ;Compares R1 with the value 3
    JEQ Add_20_cents                                ;Call the logic to add 20 cents
    CMP R1, 6                                       ;Compares R1 with the value 3
    JEQ Add_10_cents                                ;Call the logic to add 10 cents
    JMP Insert_Money                                ;In case the option is invalid or not selected, repeat rotine

Add_5_Euros:
    MOV R5, 500                                     ;Mov the value 500 to R5
    CALL Update_Inserted_Value_In_Memory            ;Call rotine to jump to the correct station screen
Add_2_Euros:
    MOV R5, 200                                     ;Mov the value 200 to R5
    CALL Update_Inserted_Value_In_Memory            ;Call rotine to jump to the correct station screen
Add_1_Euro:
    MOV R5, 100                                     ;Mov the value 100 to R5
    CALL Update_Inserted_Value_In_Memory            ;Call rotine to jump to the correct station screen
Add_50_cents:
    MOV R5, 50                                      ;Put 50 in R5 to simbolize 50 cents
    CALL Update_Inserted_Value_In_Memory            ;Call rotine to jump to the correct station screen
Add_20_cents:
    MOV R5, 20                                      ;Put 20 in R5 to simbolize 20 cents
    CALL Update_Inserted_Value_In_Memory            ;Call rotine to jump to the correct station screen
Add_10_cents:
    MOV R5, 10                                      ;Put 10 in R5 to simbolize 10 cents
    CALL Update_Inserted_Value_In_Memory            ;Call rotine to jump to the correct station screen

Update_Inserted_Value_In_Memory:
    MOV R4, Memory_Address_Inserted_Memory          ;Memory address that holds how many cents have been added
    MOV R6, [R4]                                    ;Pass the cents already incerted to R6
    ADD R5, R6                                      ;Add the value already incerted to the value beign incerted 
    MOV [R4], R5                                    ;Update the inserted value on the memory
    CALL Move_Correct_Station                       ;Call rotine to jump to the correct station screen


;Main_Menu_Screen, appears out of bounds when using jumps so this is a work around
Intermediate1_Main_Menu:
    CALL Main_Menu_Screen                           ;Call Main_Menu_Selection


Proceed_Payment_Menu:
    MOV R4, Memory_Address_Inserted_Memory          ;Address of the memory that holds the inserted money
    MOV R5, [R4]                                    ;Pass the value of inserted money to R5
    MOV R4, Memory_Address_Price_Pay                ;Address of the memory that hols the price needed to pay
    MOV R6, [R4]                                    ;Pass the price to pay to R6
    CMP R5, R6                                      ;Compare the inserted money with the price to pay
    JLT Not_Enough_Money_Screen                     ;If the price is not enouth call the routine to handle it
    CALL Enough_Money                               ;Otherwise call the routine to handle the creation of the PEPE

Not_Enough_Money_Screen:
    MOV R2, Not_Enough_Money_Message                ;Moves to R2 the Not_Enough_Money_Message address
    CALL Setup_Show_Screen                          ;Updates the screen
Not_Enough_Money:
    CALL Read_Main_Input_Peripheric                 ;Routine to Read the input for the input peripheric and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Move_Correct_Station                        ;Go back to the menu, to insert more money
    CMP R1, 2                                       ;Compares R1 with the value 2
    JEQ Intermediate1_Main_Menu                     ;Go back to the main menu when canceled is selected
    JMP Not_Enough_Money                            ;In case the option is invalid or not selected, repeat rotine

Enough_Money:
    MOV R4, Memory_Address_Number_Tickets_Created   ;Address where the number of tickets that exists is stored
    MOV R7, [R4]                                    ;Pass the number of tickets that exist to R7
    MOV R8, R7                                      ;Make a copy of the value to R8
    MOV R9, Memory_Interval_Between_Tickets         ;The interval between each tickets memory
    MUL R8, R9                                      ;Multiply the number of tickets by the interval
    MOV R9, Memory_Address_Ticket_Number            ;Pass the address of the first ticket memory to R9
    ADD R9, R8                                      ;Add R8 to the first ticket address to get the empty addres to store ticket information
    ADD R7, 1                                       ;Add 1 to the tickets created 
    MOV [R4], R7                                    ;Update the value of tickets created
    MOV [R9], R7                                    ;Give the new ticket a number
    MOV R1, 10H                                     ;Address to be added to pass to the balance address of the ticket
    ADD R9, R1                                      ;Go to the new ticket balance
    MOV [R9], R6                                    ;Store the tickets balance on memory
    SUB R5, R6                                      ;Subtract the inserted money by the price, to get the change to give the user
Present_Ticket_Screen:
    MOV R2, Generated_Ticket_Menu                   ;Moves to R2 the Choose_Inserted_Value_Menu address
    CALL Setup_Show_Screen                          ;Updates the screen
Update_Ticket_Number_Screen:
    MOV R4, Display_Constant                        ;Display constant that when added displays the correct value on screen
    MOV R1, 10                                      ;Value to divide by, to get each digit
    MOV R10, Display_Position_Ticket_Number_Units   ;Display position of the first digit of the ticket number
    CALL Get_Ticket_Number_Apply_Constant           ;Call the routine that, separates the digit, and updates the correct screen position
    DIV R7, R1                                      ;Remove the units digit
    MOV R10, Display_Position_Ticket_Number_Dozens  ;Display position of the second digit of the ticket number
    CALL Get_Ticket_Number_Apply_Constant           ;Routine to get the ticket digit and apply a constant
    DIV R7, R1                                      ;Remove the dozens digit
    MOV R10, Display_Position_Ticket_Number_Hundreds;Display position of the third digit of the ticket number
    CALL Get_Ticket_Number_Apply_Constant           ;Routine to get the ticket digit and apply a constant
    DIV R7, R1                                      ;Remove the hundreds digit
    MOV R10, Display_Position_Ticket_Number_Thousand;Display position of the fourth digit of the ticket number
    CALL Get_Ticket_Number_Apply_Constant           ;Routine to get the ticket digit and apply a constant
Update_Change_Screen_Pay_Menu:
    MOV R1, Display_Position_Ticket_Change_Euro     ;Put the screen address that displays euro of the change
    MOV R4, Display_Position_Ticket_Change_Cent     ;Put the screen address that displays the first digit of the cents
    CALL Update_Money_Value_Screen                  ;Call the routine responsible for separating the value and updating the screen
Present_Ticket:
    CALL Read_Main_Input_Peripheric                 ;Routine to Read the input for the input peripheric and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Intermediate1_Main_Menu                     ;Go to the main menu
    CALL Present_Ticket                             ;In case no option is choosen repeat routine


Use_Card_Screen:
    MOV R2, Introduce_Ticket_Number_Menu            ;Moves to R2 the Introduce_Ticket_Number_Menu address
    CALL Setup_Show_Screen                          ;Updates the screen
Use_Card:
    CALL Read_Main_Input_Peripheric                 ;Routine to Read the input for the input peripheric and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Continue_Ticket                             ;Continue to the ticket with the number selected
    CMP R1, 5                                       ;Compares R1 with the value 1
    JEQ Intermediate1_Main_Menu                     ;Go to the main menu
    CALL Use_Card                                   ;In case no option is choosen repeat routine

Continue_Ticket:
    MOV R3, 0                                       ;Set R3 to 0
    MOV R0, TICKET_NUMBER_1                         ;Loads address of first digit into R0
    MOV R7, 1000                                    ;Move 1000 to R7 to get the correct ticket number
    CALL Get_Correct_Ticket_Number                  ;Call aux function to help put togheter the ticket number
    MOV R0, TICKET_NUMBER_2                         ;Loads address of first digit into R0
    MOV R7, 100                                     ;Move 100 to R7 to get the correct ticket number
    CALL Get_Correct_Ticket_Number                  ;Call aux function to help put togheter the ticket number
    MOV R0, TICKET_NUMBER_3                         ;Loads address of first digit into R0
    MOV R7, 10                                      ;Move 10 to R7 to get the correct ticket number
    CALL Get_Correct_Ticket_Number                  ;Call aux function to help put togheter the ticket number
    MOV R0, TICKET_NUMBER_4                         ;Loads address of first digit into R0
    MOV R7, 1                                       ;Move 1 to R7 to get the units
    CALL Get_Correct_Ticket_Number                  ;Call aux function to help put togheter the ticket number
    MOV R4, Memory_Address_Number_Tickets_Created   ;Address that contains the number of Pepe Tickets created
    MOV R5, [R4]                                    ;Mov to R5 the number of PEPE ticktets created
    CMP R5, R3                                      ;See if the number is valid
    JLT No_Valid_Ticket_Number_Screen               ;In case the number is invalid present error message
    MOV R5, 0                                       ;To compare if the ticket number is not 0
    CMP R5, R3                                      ;Compare 0 and R3
    JEQ No_Valid_Ticket_Number_Screen               ;In case ticket number is 0 present error message
Get_Balance_Pepe_Ticket:
    MOV R7, 1                                       ;To subtract one from the number of tickets to get the correct memory address
    SUB R3, R7                                      ;Do the subtraction
    MOV R5, Display_Constant                        ;Display constant that when added displays the correct value on screen
    MOV R9, Memory_Interval_Between_Tickets         ;Get the memory interval between each ticket
    MUL R3, R9                                      ;Multiply the number of tickets by the interval
    MOV R9, Memory_Address_Ticket_Number            ;Pass the address of the first ticket memory to R9
    ADD R9, R3                                      ;Get the address to start modifying in R9
    MOV R7, 10H                                     ;To go to the balance of a ticket
    ADD R9, R7                                      ;Pass to the memory address that contains the balance
    MOV R5, [R9]                                    ;Get the balance of the ticket to R5
Accepted_Ticket_Screen:
    MOV R2, Ticket_Menu                             ;Moves to R2 the Ticket_Menu address
    CALL Setup_Show_Screen                          ;Updates the screen
Update_Change_Screen:
    MOV R1, Display_Position_Ticket_Balance_Euro    ;Display position of the euro digit of the ticket balance
    MOV R4, Display_Position_Ticket_Balance_Cent    ;Display position of the first digit of the cents of the ticket balance
    MOV R5, [R9]                                    ;Get the balance of the ticket to R5
    CALL Update_Money_Value_Screen
Accepted_Ticket:
    CALL Read_Main_Input_Peripheric                 ;Call routine to read the input and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Buy_With_Pepe_Card_Screen                   ;Go to the Buy_With_Pepe_Card_Screen
    CMP R1, 2                                       ;Compares R1 with the value 2
    JEQ Recharge_Pepe_Card_Screen                   ;Go to the Recharge_Pepe_Card_Screen
    CALL Accepted_Ticket                            ;In case no option is choosen repeat routine


Intermediate2_Main_Menu:
    CALL Intermediate1_Main_Menu                    ;Call the main menu


No_Valid_Ticket_Number_Screen:
    MOV R2, No_Ticket_With_That_Number              ;Moves to R2 the No_Ticket_With_That_Number address
    CALL Setup_Show_Screen                          ;Updates the screen
No_Valid_Ticket_Number:
    CALL Read_Main_Input_Peripheric                 ;Routine to Read the input for the input peripheric and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Use_Card_Screen                             ;Go back to insert another ticket number
    CMP R1, 2                                       ;Compares R1 with the value 1
    JEQ Intermediate2_Main_Menu                     ;Go to the main menu
    CALL No_Valid_Ticket_Number                     ;In case no option is choosen repeat routine


Buy_With_Pepe_Card_Screen:
    MOV R2, Choose_Station_Menu                     ;Moves to R2 the Choose_Station_Menu address
    CALL Setup_Show_Screen                          ;Updates the screen
Buy_With_Pepe_Card:
    CALL Read_Main_Input_Peripheric                 ;Call routine to read the input and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Get_Station2_Price                          ;Calls logic to get the price for station 2
    CMP R1, 2                                       ;Compares R1 with the value 2
    JEQ Get_Station3_Price                          ;Calls logic to get the price for station 3
    CMP R1, 3                                       ;Compares R1 with the value 3
    JEQ Get_Station4_Price                          ;Calls logic to get the price for station 4
    CMP R1, 4                                       ;Compares R1 with the value 3
    JEQ Get_Station5_Price                          ;Calls logic to get the price for station 5
    CMP R1, 5                                       ;Compares R1 with the value 3
    JEQ Intermediate2_Main_Menu                     ;Cancel option, go to the main menu
    JMP Buy_With_Pepe_Card                          ;In case the option is invalid or not selected, repeat rotine

Get_Station2_Price:
    MOV R5, Station2_price                          ;Move the station 2 price to R5
    CALL Verify_Enough_Money                        ;Call routine to verify the ticket has enough money to pay for that station

Get_Station3_Price:
    MOV R5, Station3_price                          ;Move the station 2 price to R5
    CALL Verify_Enough_Money                        ;Call routine to verify the ticket has enough money to pay for that station

Get_Station4_Price:
    MOV R5, Station4_price                          ;Move the station 2 price to R5
    CALL Verify_Enough_Money                        ;Call routine to verify the ticket has enough money to pay for that station

Get_Station5_Price:
    MOV R5, Station5_price                          ;Move the station 2 price to R5
    CALL Verify_Enough_Money                        ;Call routine to verify the ticket has enough money to pay for that station


Verify_Enough_Money:
    MOV R6, [R9]                                    ;Move the ticket balance to R6
    CMP R6, R5                                      ;Compare the balance with the price on R5
    JGE Enough_Money_Pepe_Screen                    ;In case the balance is enough proceed to buy
Not_Enough_Money_Pepe_Screen:
    MOV R2, Not_Enough_Money_Message                ;Moves R2 the Not_Enough_Money_Message address
    CALL Setup_Show_Screen                          ;Updates the screen
Not_Enough_Money_Pepe:
    CALL Read_Main_Input_Peripheric                 ;Call routine to read the input and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Use_Card_Screen                             ;Go back to the screen to select the ticket number
    CMP R1, 2                                       ;Compares R1 with the value 2
    JEQ Intermediate2_Main_Menu                     ;Call Main_Menu_Selection
    JMP Not_Enough_Money_Pepe                       ;In case the option is invalid or not selected, repeat rotine


Enough_Money_Pepe_Screen:
    MOV R2, Pepe_Ticket_Buy_Success                 ;Moves to R2 the Pepe_Ticket_Buy_Success address
    CALL Setup_Show_Screen                          ;Updates the screen
Update_Balance_Ticket:
    MOV R6, [R9]                                    ;Get the balance of the ticket
    SUB R6, R5                                      ;Subtract the price of the station from the balance
    MOV [R9], R6                                    ;Update on memory the balance of the ticket
    MOV R5, [R9]                                    ;Move the ticket balance to R5
Present_Balance_Screen:
    MOV R1, Display_Position_Ticket_New_Balance_Euro;Display position of the euro digit of the ticket balance   
    MOV R4, Display_Position_Ticket_New_Balance_Cent;Display position of the first digit of cents on the ticket balance
    MOV R5, [R9]                                    ;Move the ticket balance to R5
    CALL Update_Money_Value_Screen                  ;Call routine responsible for separating the value and updating the value on screen
Enough_Money_Pepe:
    CALL Read_Main_Input_Peripheric                 ;Call routine to read the input and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Intermediate2_Main_Menu                     ;Call Intermediate2_Main_Menu
    CALL Enough_Money_Pepe                          ;In case the option is invalid or not selected, repeat rotine



Recharge_Pepe_Card_Screen:
    MOV R2, Choose_Inserted_Value_Menu              ;Load Choose_Inserted_Value_Menu adress into R2
    CALL Setup_Show_Screen                          ;Call rotine to show the updated screen
Recharge_Pepe_Card:
    CALL Read_Main_Input_Peripheric                 ;Call routine to read the input and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Add_5_Euros_Pepe                            ;Calls logic to add 5 euros to the ticket
    CMP R1, 2                                       ;Compares R1 with the value 2
    JEQ Add_2_Euros_Pepe                            ;Call the logic to add 2 euros to the ticket
    CMP R1, 3                                       ;Compares R1 with the value 3
    JEQ Add_1_Euro_Pepe                             ;Call the logic to add 1 euro to the ticket
    CMP R1, 4                                       ;Compares R1 with the value 3
    JEQ Add_50_cents_Pepe                           ;Call the logic to add 50 cents to the ticket
    CMP R1, 5                                       ;Compares R1 with the value 3
    JEQ Add_20_cents_Pepe                           ;Call the logic to add 20 cents to the ticket
    CMP R1, 6                                       ;Compares R1 with the value 3
    JEQ Add_10_cents_Pepe                           ;Call the logic to add 10 cents to the ticket
    JMP Recharge_Pepe_Card                          ;In case the option is invalid or not selected, repeat rotine

Add_5_Euros_Pepe:
    MOV R5, 500                                     ;Mov the value 500 to R5
    CALL Add_Money_Pepe_Ticket                      ;Call rotine to add that quantity to the ticket in question
Add_2_Euros_Pepe:
    MOV R5, 200                                     ;Mov the value 200 to R5
    CALL Add_Money_Pepe_Ticket                      ;Call rotine to add that quantity to the ticket in question
Add_1_Euro_Pepe:
    MOV R5, 100                                     ;Mov the value 100 to R5
    CALL Add_Money_Pepe_Ticket                      ;Call rotine to add that quantity to the ticket in question
Add_50_cents_Pepe:
    MOV R5, 50                                      ;Put 50 in R5 to simbolize 50 cents
    CALL Add_Money_Pepe_Ticket                      ;Call rotine to add that quantity to the ticket in question
Add_20_cents_Pepe:
    MOV R5, 20                                      ;Put 20 in R5 to simbolize 20 cents
    CALL Add_Money_Pepe_Ticket                      ;Call rotine to add that quantity to the ticket in question
Add_10_cents_Pepe:
    MOV R5, 10                                      ;Put 10 in R5 to simbolize 10 cents
    CALL Add_Money_Pepe_Ticket                      ;Call rotine to add that quantity to the ticket in question

Add_Money_Pepe_Ticket: 
    MOV R6, [R9]                                    ;Mov the current balance of the ticket to R6
    ADD R6, R5                                      ;Sum the value to add to the current balance
    MOV [R9], R6                                    ;Update the value on memory
Recharge_Ticket_Success_Screen:
    MOV R2, Pepe_Ticket_Recharge_Success            ;Load Pepe_Ticket_Recharge_Success adress into R2
    CALL Setup_Show_Screen                          ;Call rotine to show the updated screen
Update_Recharge_Ticket_Balance_Screen:
    MOV R1, Display_Position_Ticket_New_Balance_Euro;Display position of the euro digit of the ticket balance   
    MOV R4, Display_Position_Ticket_New_Balance_Cent;Display position of the first digit of cents on the ticket balance
    MOV R5, [R9]                                    ;Move the ticket balance to R5
    CALL Update_Money_Value_Screen                  ;Call routine responsible for separating the value and updating the value on screen
Recharge_Ticket_Success:
    CALL Read_Main_Input_Peripheric                 ;Call routine to read the input and pass it to R1
    CMP R1, 1                                       ;Compares R1 with the value 1
    JEQ Intermediate2_Main_Menu                     ;Call Intermediate2_Main_Menu
    CALL Recharge_Ticket_Success                    ;In case the option is invalid or not selected, repeat rotine



;Routine responsible for reading the value on the main input peripheral and passing it to R1
Read_Main_Input_Peripheric:
    CALL Clean_Peripherals                          ;Call rotine to clean peripherals
    MOV R0, IN_PER                                  ;Loads input peripheral address to R0
    MOVB R1, [R0]                                   ;Reads the value on the input peripheral to R1, a byte so the first memory slot is used
    RET

;Routine responsible for cleaning the memory slot that holds the inserted money
Clean_Inserted_Memory:
    MOV R4, Memory_Address_Inserted_Memory          ;Mov to R4 the address of the inserted money
    MOV R5, 0                                       ;Mov to R5 the value 0
    MOV [R4], R5                                    ;Set inserted euros to 0 on memory
    RET

;Routine responsible for putting togheter the correct ticket number
;R3 will hold the result of the ticket number
;R0 will hold the memory address of the input for a digit of the ticket number
;R7 will hold the number to multiply to put the digit on the correct position
Get_Correct_Ticket_Number:
    MOVB R4, [R0]                                   ;Reads the value on the input peripheral to R1, a byte so the first memory slot is used
    MUL R4, R7                                      ;Get the 1000's number
    ADD R3, R4                                      ;Sum the value to R3
    RET                                             ;Go back to the last instruction

;Routine responsible for getting the last digit of the ticket number, and updating the value on screen
;R1 is 100
;R4 is the display constant
;R10 is the address to be updated
Get_Ticket_Number_Apply_Constant:
    MOV R8, R7                                      ;Make a copy of the ticket number
    MOD R8, R1                                      ;Divide by 100 to get the second digit
    ADD R8, R4                                      ;Apply the display constant
    MOVB [R10], R8                                  ;Update the value on the screen
    RET                                             ;Go back to the last routine

;Routine responsible for receiving a certain numerical value and the screen 
;address of the euro and cent places, and updating those places with the correct 
;numbers (example receives 150, and puts one on the euro place and 5 on the cent place)
;R1 is the address to the euro place
;R4 the address to the cents place
;R5 the numerical value
Update_Money_Value_Screen:
    PUSH R6
    PUSH R7
    PUSH R8
    PUSH R9
    PUSH R10
    MOV R6, R5                                      ;Move money to R6
    MOV R7, R1                                      ;Move the address that needs to be updated on screen for euros
    MOV R8, R4                                      ;Move address that needs to be updated on screen for cents
    MOV R9, Display_Constant                        ;Value of the display constant to R9
    MOV R10, 100                                    ;Value to be used to separate euros from cents
    DIV R6, R10                                     ;Separate euros from cents
    ADD R6, R9                                      ;Add display value so it is used correctly
    MOVB [R7], R6                                   ;Update the value on screen for the euros
    MOV R6, R5                                      ;Move money to R6
    MOD R6, R10                                     ;Get the value in cents for the change
    MOV R10, 10                                     ;Value to be used to get the first digit of the cents
    DIV R6, R10                                     ;Separate first digit of the cents
    ADD R6, R9                                      ;Add display value so it is used correctly
    MOVB [R8], R6                                   ;Update the value on screen for the cents
    POP R10
    POP R9
    POP R8
    POP R7
    POP R6
    RET
    
;Routines that will present the new screen when called
Setup_Show_Screen:
    PUSH R0							                ;Stores R0 on the stackpointer
	PUSH R1							                ;Stores R1 on the stackpointer
	PUSH R2							                ;Stores R2 on the stackpointer
	PUSH R3							                ;Stores R3 on the stackpointer
	MOV R0, DISPLAY_BEGIN		                    ;Moves to R0 the address of the beggining of the screen
	MOV R1, DISPLAY_END				                ;Moves to R1 the address of the end of the screen
Show_Screen:
    MOV R3, [R2]					                ;Moves to R3 the value on the address R2 (R2 holds the starting value of the screen to be put)
	MOV [R0], R3					                ;Moves to the value pointed by R0 (the start of the screen) the contents on R3 (the message to be shown on that line)
	ADD R2, 2						                ;Adds to R2 2 units, gets content from the next line
	ADD R0, 2						                ;Adds to R0 2 units, go to the next line on the screen
	CMP R0, R1						                ;Compares R0 with R1 (that holds the value of the end of the display)
	JLE Show_Screen   				                ;If its smaller or equal, repeat
	POP R3							                ;Restores R3 value
	POP R2							                ;Restores R2 value
	POP R1							                ;Restores R1 value
	POP R0							                ;Restores R0 value
	RET								                ;Goes back to the address saved on the StackPointer

;Routine to clean the main input peripheral when called
Clean_Peripherals:
    PUSH R0							                ;Stores R0 in the stackpointer
    PUSH R1                                         ;Stores R1 in the stackpointer
	MOV R0, IN_PER					                ;Reads the address of the input peripheral
	MOV R1, 0                                       ;Moves to R1 the value 0
    MOVB [R0], R1					                ;Moves to the value the address stored in R0 the value of R1
	POP R1                                          ;Restores the value of R1
    POP R0							                ;Restores the value of R0
	RET								                ;Goes back to the address stores in the stackpointers