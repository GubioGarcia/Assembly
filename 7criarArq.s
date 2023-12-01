;criarArq.s
segment .data
    nomearq db "teste", 0
    arqdest db "dest", 0
    mensfcriar db "Falha na criacao do arquivo", 10
    tam1 equ $-mensfcriar

segment .bss
    fd1 resd 1 ;descritor do arquivo
    
segment .text
    global _start
        _start:
                
        ;bloco criação de arquivo
        mov eax, 8
        mov ebx, arqdest
        mov ecx, 0q777
        int 80h
        
        mov [fd1], al
        cmp eax, 0
        jl errocriar
        jmp fim
        
        errocriar:
        mov eax, 4
        mov ebx, 1
        mov ecx, mensfcriar
        mov edx, tam1
        int 80h
        jmp fim
        
        fim:
        mov eax, 1 ;exit
        int 80h
