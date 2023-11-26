;leitura.s
segment .data
mens db "Entre com uma string", 10
tam equ $-mens

segment .bss ;variaveis nao inicializadas
    buf resb 50 ;maximo de caracteres a serem lidos
    ncar resd 1 ;qtd de caracteres retornados pela eax
    
segment .text
    global _start
        _start:
        
        ;bloco exibir mensagem
        mov eax, 4 ;print
        mov ebx, 1 ;fd tela
        mov ecx, mens ;ponteiro
        mov edx, tam
        int 80h
        
        ;bloco recebe mensagem
        mov edx, 50
        mov ecx, buf
        mov ebx, 0 ;fd do teclado
        mov eax, 3 ;read
        int 80h
        
        mov [ncar], eax
        
        ;imprimir buf
        mov eax, 4
        mov ebx, 1
        mov ecx, buf
        mov edx, [ncar]
        int 80h
        
        mov eax, 1 ;exit
        int 80h
