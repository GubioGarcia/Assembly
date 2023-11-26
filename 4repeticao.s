;repeticao.s
segment .data
mens db "Entre com uma string", 10
tam equ $-mens

segment .bss
    buf resb 100 ;maximo 50 bites a serem lidos
    buf2 resb 100
    cont resd 1 ;qtd de caracteres retornados pela eax
    
segment .text
    global _start
        _start:
        
        ;bloco exibir mensagem
        mov eax, 4 ;print
        mov ebx, 1 ;fd tela
        mov ecx, mens ;ponteiro
        mov edx, tam
        int 80h
        
        ;bloco recebe string
        mov edx, 50
        mov ecx, buf
        mov ebx, 0 ;fd do teclado
        mov eax, 3 ;read
        int 80h
        
        mov [cont], eax
        
        ;bloco copia buf
        dec dword[cont]
        xor esi, esi ;zera o indice, equivalente ao mov esi, 0
        iniloop:
        mov al, [buf+esi]
        mov [buf2+esi], al
        cmp [cont], esi
        je fimloop ;saida do loop
        inc esi
        jmp iniloop
        fimloop:
        
        inc dword[cont]
        
        ;imprimir buf2
        mov eax, 4
        mov ebx, 1
        mov ecx, buf2
        mov edx, [cont]
        int 80h
        
        mov eax, 1 ;exit
        int 80h
