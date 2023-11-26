;copiarArq.s
segment .data
    nomearq db "teste", 0
    arqdest db "dest", 0
    mensfabrir db "Falha na abertura do arquivo", 10
    tam1 equ $-mensfabrir
    mensfcriar db "Falha na criacao do arquivo", 10
    tam2 equ $-mensfcriar

segment .bss
    fd1 resd 1 ;descritor do arquivo
    fd2 resd 1
    buf1 resb 250
    buf2 resb 250
    
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
        mov [fd1], eax
        
        ;bloco criação de arquivo
        mov eax, 8
        mov ebx, arqdest
        mov ecx, 0q77
        cmp eax, 0
        jl errocriar
        mov [fd2], eax
        
        ;bloco leitura fd1
        mov eax, 3
        mov ebx, fd1
        mov ecx, buf1
        mov edx, 20
        int 80h
        
        ;bloco escritra fd2
        mov eax, 4
        mov ebx, fd2
        mov ecx, [buf2]
        mov edx, 20
        int 80h
        jp fim
        
        erroabrir: ;imprimir mens de falha 
        mov eax, 4
        mov ebx, 1
        mov ecx, mensfabrir
        mov edx, tam1
        int 80h
        jp fim
        
        errocriar:
        mov eax, 4
        mov ebx, 1
        mov ecx, mensfcriar
        mov edx, tam2
        int 80h
        
        fim:
        mov eax, 1 ;exit
        int 80h
