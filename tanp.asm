%include "io.inc"
section .data

msg1 db "Enter the DNA String: ",0
msg2 db "DNA string length: ",0
msg3 db "Frequency of A: ",0
msg4 db "Frequency of C: ",0
msg5 db "Frequency of G: ",0
msg6 db "Frequency of T: ",0
msg7 db "Reverse complement of the DNA string: ",0
msg8 db "Error, null input!", 0
msg9 db "Wrong input.", 0

A dd 0
C dd 0
G dd 0
T dd 0
Total dd 0
DNA times 256 db 0 ;if 2, then type AT, it will only read A, thus 2 = 1 char lang
;DNA db "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC",0
;DNA db "ACGT", 0
Exit times 2 db 0
section .text
global CMAIN
CMAIN:
    MOV BYTE [A], 0
    MOV BYTE [C], 0
    MOV BYTE [G], 0
    MOV BYTE [T], 0
    MOV BYTE [Total], 0
    mov ebp, esp; for correct debugging
    
    PRINT_STRING msg1
    GET_STRING DNA, 256
    LEA EBX, [DNA]
    
    
CheckNull:    
    MOV EAX, [DNA] 
    CMP EAX, 0x00 ;checks if null input
    JE IsNull
    
CheckString:
    MOV EAX, 0 ;set EAX to empty
    MOV AL, [EBX] ;put the first character of EBX to AL for compare
    
    CMP AL, 0x00  ;if null, stop checking the string of DNA
    JE ShowAmount
    
    CMP AL, 0x41  ;if current character is a
    JE AddA  
      
    CMP AL, 0x43
    JE AddC  
        
    CMP AL, 0x47
    JE AddG  
        
    CMP AL, 0x54
    JE AddT  
    JNE IsWrong   ;else its not a DNA letter, so tell user wrong input
    
ShowAmount:
    ;NEWLINE
    PRINT_STRING msg2  
    PRINT_UDEC 4, [Total] ;print 1 byte of , meron din PRINT_HEX
    
    NEWLINE
    PRINT_STRING msg3
    PRINT_UDEC 4, [A]
    
    NEWLINE
    PRINT_STRING msg4
    PRINT_UDEC 4, [C]
    
    NEWLINE
    PRINT_STRING msg5
    PRINT_UDEC 4, [G]
    
    NEWLINE
    PRINT_STRING msg6
    PRINT_UDEC 4, [T]
    

Reverse:
    MOV EBX, 0    ;reset EBX to reuse
    LEA EBX, [DNA]
    LEA ECX, [Total]
    
    NEWLINE
    PRINT_STRING msg7
    NEWLINE
    
    GoMax: ;gets how many letters the input is
         CMP BYTE [ECX], 0 ;if done scanning, go print
         JE PrintReverse
         
         INC EBX         ;add 1 to how many char the letter is
         DEC BYTE [ECX]  ;if(i=0; i<LEA ECX, [TOTAL]; i++)
         JMP GoMax        ;EBX++
    
    PrintReverse:
        DEC EBX     
        MOV AL, [EBX]
    
        CMP AL, 0x00    
        JE Finish
    
        CMP AL, 0x41
        JE PrintT
      
        CMP AL, 0x43
        JE PrintG
        
        CMP AL, 0x47
        JE PrintC
        
        CMP AL, 0x54
        JE PrintA
    
    
    
Finish:
    GET_STRING Exit, 2
    xor eax, eax
    ret
    
IsNull:
    PRINT_STRING msg8
    xor eax, eax
    ret

IsWrong:
    NEWLINE
    PRINT_STRING msg9
    xor eax, eax
    ret
    
AddA:
    INC BYTE [A]
    INC BYTE [Total]
    ;PRINT_CHAR [EBX]
    INC EBX
    JMP CheckString
    
AddC:
    INC BYTE [C]
    INC BYTE [Total]
    ;PRINT_CHAR [EBX]
    INC EBX
    JMP CheckString
    
    
AddG:
    INC BYTE [G]
    INC BYTE [Total]
    ;PRINT_CHAR [EBX]
    INC EBX
    JMP CheckString
    
    
AddT:
    INC BYTE [T]
    INC BYTE [Total]
    ;PRINT_CHAR [EBX]
    INC EBX
    JMP CheckString

PrintA:
    PRINT_CHAR 0x41 
    JMP PrintReverse
    
PrintC:
    PRINT_CHAR 0x43 
    JMP PrintReverse
    
PrintG:
    PRINT_CHAR 0x47
    JMP PrintReverse
    
PrintT:
    PRINT_CHAR 0x54
    JMP PrintReverse
    

    
