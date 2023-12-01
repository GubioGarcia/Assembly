section .data
    nomearq db "teste", 0
    arqdest db "dest", 0

    mensfabrir db "Falha na abertura do arquivo", 10
    tam1 equ $-mensfabrir

    mensfcriar db "Falha na criacao do arquivo", 10
    tam2 equ $-mensfcriar

    mensfread db "Falha na leitura do arquivo", 10
    tam3 equ $-mensfread

segment .bss
    fd1 resd 1 ; descritor do arquivo de origem
    fd2 resd 1 ; descritor do arquivo de destino
    buf resb 250

section .text
    global _start
    _start:

        ; bloco abertura do arquivo de origem
        mov eax, 5 ; open
        mov ebx, nomearq ; ponteiro para o nome do arquivo
        mov ecx, 0 ; modo de acesso (somente leitura)
        mov edx, 0o777 ; permissões (em octal)
        int 80h

        ; verifica erro ao abrir o arquivo de origem
        cmp eax, 0
        jl erroabrir
        mov [fd1], eax

        ; bloco criação de arquivo de destino
        mov eax, 8 ; open
        mov ebx, arqdest ; ponteiro para o nome do arquivo de destino
        mov ecx, 0o777 ; permissões (em octal)
        mov edx, 0o642 ; flags: O_CREAT | O_WRONLY | O_TRUNC
        int 80h

        ; verifica erro ao criar o arquivo de destino
        cmp eax, 0
        jl errocriar
        mov [fd2], eax

        ; bloco leitura do arquivo de origem
        mov eax, 3
        mov ebx, [fd1] ; descritor do arquivo de origem
        mov ecx, buf ; ponteiro para o buffer
        mov edx, 250 ; tamanho máximo a ser lido
        int 80h

        ; verifica erro na leitura
        cmp eax, 0
        jl erroleitura

        ; obtém o tamanho real dos dados lidos
        movzx rdx, ax

        ; bloco escrita no arquivo de destino
        mov eax, 4
        mov ebx, [fd2] ; descritor do arquivo de destino
        mov ecx, buf ; ponteiro para o buffer
        int 80h

        ; fecha os descritores de arquivo
        mov eax, 6 ; close
        mov ebx, [fd1] ; descritor do arquivo de origem
        int 80h

        mov eax, 6 ; close
        mov ebx, [fd2] ; descritor do arquivo de destino
        int 80h

        ; finaliza o programa
        mov eax, 1 ; exit
        int 80h

    erroabrir:
        ; imprime mensagem de falha ao abrir o arquivo de origem
        mov eax, 4
        mov ebx, 1
        mov ecx, mensfabrir
        mov edx, tam1
        int 80h

    errocriar:
        ; imprime mensagem de falha ao criar o arquivo de destino
        mov eax, 4
        mov ebx, 1
        mov ecx, mensfcriar
        mov edx, tam2
        int 80h

    erroleitura:
        ; imprime mensagem de falha na leitura
        mov eax, 4
        mov ebx, 1
        mov ecx, mensfread
        mov edx, tam3
        int 80h
