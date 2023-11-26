;openArq.s
segment .data
    nomearq db "teste", 0
    mensf db "Falha na abertura do arquivo", 10
    tam1 equ $-mensf
    menssucess db "Sucesso na abertura do arquivo", 10
    tam2 equ $-mensf

segment .bss
    fd1 resd 1 ;descritor do arquivo
    
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
        
        ;bloco para armazenar o descritor do arquivo
        mov [fd1], al
        add [fd1], byte 48

        mov eax, 4
        mov ebx, 1
        mov ecx, menssucess
        mov edx, tam2
        int 80h
        jp fim
        
        erroabrir: ;imprimir mens de falha 
        mov eax, 4
        mov ebx, 1
        mov ecx, mensf
        mov edx, tam1
        int 80h
        
        fim:
        mov eax, 1 ;exit
        int 80h
