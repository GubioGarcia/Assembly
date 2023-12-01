section .data
    arqdest db "dest", 0
    mensfcriar db "Falha na criacao do arquivo", 10
    tam1 equ $-mensfcriar
    
    success db "Sucesso na criação e escrita no arquivo", 10
    tam2 equ $-success

section .bss
    fd1 resd 1 ;descritor do arquivo

section .text
    global _start
    _start:

        ; bloco criação de arquivo
        mov eax, 8
        mov ebx, arqdest
        mov ecx, 0o777 ; permissões
        mov edx, 0o642 ; flags: O_CREAT | O_WRONLY | O_TRUNC
        int 80h

        ; Verifica erros ao criar o arquivo
        cmp eax, 0
        jl errocriar

        mov [fd1], eax

        ; Escreve a mensagem no arquivo
        mov eax, 4
        mov ebx, [fd1]
        mov ecx, success
        mov edx, tam2
        int 80h

        ; Finaliza o programa
        mov eax, 1 ; syscall para exit
        int 80h

    errocriar:
        ; Manipula o erro ao criar o arquivo
        mov eax, 4
        mov ebx, 1
        mov ecx, mensfcriar
        mov edx, tam1
        int 80h

