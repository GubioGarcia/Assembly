; PONTIFÍCIA UNIVERSIDADE CATÓLICA DE GOIÁS
; CMP 1057 A01-3 LAB ARQUITETURA DE COMPUTADORES I
; NOME: Gubio Garcia dos Santos
; DATA: 22/09/2023
; Primeiro programa: nada faz, mas exercita as fases de implementação
; EDIÇÃO, MONTAGEM (INTERNA, NASM), LIGAÇÃO (INTERNA, LD), EXECUÇÃO

section .text
    global _start

_start: ; inicio do código

    ; Fase de execução
    ; Não faz nada neste exemplo

    ; Encerrar o programa
    mov eax, 1       ; syscall exit
    int 80h          ; chamar a interrupção 80h para sair