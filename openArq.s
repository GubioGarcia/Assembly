;openArq.s
segment .data
    nomearq db "teste", 0
    mensf db "Falha na abertura do arquivo", 10
    tam equ $-mensf

segment .bss
    fd1 resb 1 ;descritor do arquivo
    
segment .text
    global _start
        _start:
        
        ;bloco abertura do arquivo
        mov eax, 5 ;open
        mov ebx, nomearq ;ponteiro arq
        mov ecx, 2 ;modo de acesso (leitura e escrita)
        mov edx, 0q77 ;permissoes (esta em octa)
        int 80h
        
        ;bloco logico se
        cmp eax, 0
        jl erroabrir
        
        mov [fd1], al
        
        ;bloco para impressao do descritor do arquivo
        add [fd1], byte 48
        mov eax, 4
        mov ebx, 1
        mov ecx, fd1
        mov edx, 1
        
        int 80h
        jmp fim
        
        erroabrir: ;imprimir mens de falha 
        mov eax, 4
        mov ebx, 1
        mov ecx, mensf
        mov edx, tam
        int 80h
        
        fim:
        mov eax, 1 ;exit
        int 80h
