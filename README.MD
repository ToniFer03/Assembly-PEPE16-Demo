# Code written in assembly for a PEPE16 processor for demo porpouses

## Table of contents
- [Function of the code](#a-function-code-that-immitates-a-ticket-machine-in-a-metro-system-done-in-the-context-of-a-university-project)
- [Commit Rules](#rules-to-follow-before-a-commit)
- [Branches](#rules-for-branches)
- [Requirements](#requirements)
- [Setup](#how-to-setup-the-tools)
- [User Manual](#how-to-use-the-code)


## A function code that immitates a ticket machine in a metro system, done in the context of a university project

This project was written in assembly language of a PEPE16 processor, it´s meant to immitate a ticket machine found in
a Metro Station. It allows the user to buy a ticket, use a pre-paid card and check the stock of coins and notes in the
machine at any moment.
It was a project to gain familiarity with the workings of a CPU as well as with coding in low level using assembly.


## Rules to follow before a commit

The commits must follow this rules:

    type [scope optional]: description

The commits must be atomic, only one objective

### Types

The available types with their respective emojis:  
🏗️build - Changes to the project build  
🔄️ci - Changes to the continuous integration cycle  
📄docs - Changes to project documentation  
🎨style - Changes related to the styling of the code  
✨feat - Changes that add new features  
🐛fix - Changes to fix errors (bugs) in the code  
🏎️perf - Changes to improve performance of the project  
🧹refactor - Refactoring of the code  
🔙revert - Reverting a previous commit  
🧮test - Changes to the unit tests of the code  
💡chore - Changes that do not alter the project code

### Scope:

The name of the component affected by the changes, example:
Compiler, readme, forms

### Description:

Brief description of the changes made, must be in english, present verb form of the imperative and without a full stop, example:
feat(validations): implement messageServer-side validations


## Rules for Branches

Must be used when implementing a new feature, working on a new release or fixing a bug in the code, when finished the development on that branch it can be merged with the main branch.
There are two types of branches always present on the repository:

    main/master
    dev/name-of-developer

There can also exist temporary branches like:

    feat/<nome-da-funcionalidade>
    bug/<descrição-do-erro>
    release/<ID da release>
    <ID do issue>/<descrição-do-issue>

The branch names must be short and explain its purpose, can't contain special characters of white spaces;


## Requirements

- [Java 8 or newer](https://www.java.com/en/download/)


## How to setup the Tools

1. Clone the repository
2. Go into the Tools folder and open "Simulador.jar"
3. On the top left corner click "File" and the "Load"
4. Choose the file "pepe.cmod" on the Tools folder of the repository
5. Change from "Design" to "Simulation" on the Top left corner
6. Expand the window of the simulator to the left and click on the module called "Pepe"
7. Click on the folder with the green arrow on the top row
8. Load the "Metro_Machine_Assembly.asm" in the repository
9. On the previous window click on the "Memory Bank" to the right of the "Pepe" module.


##  How to use the code

- To run the program in the Pepe window with the code you will select the "Run simulation" on the top left corner
and the "Step instruction" the first time you load the program and every time after you input into the input cedule.
- On the "Memory Bank" window, the Row with Memory Adress 0050, the first cedule is the main input cedule you will
write the option you want in here and press enter to interact with the program.
- When asked for a ticket number the first collumn of memory addresses 0010, 0020, 0030, 0040 function as the inputs for the ticket number.  
Example: Ticket number 2378 would be inputed as:
    - 2 in first collumn of memory address 0010;
    - 3 in first collumn of memory address 0020;
    - 7 in first collumn of memory address 0030;
    - 8 in first collumn of memory address 0040;