section .data
    ; Defina variáveis de dados aqui (se necessário)

section .text
    global _start

_start:
    ; Código começa aqui

    ; Fase de inicialização
    ; Você pode adicionar código de inicialização aqui (se necessário)

    ; Fase de execução
    ; Não faz nada neste exemplo

    ; Fase de finalização
    ; Você pode adicionar código de finalização aqui (se necessário)

    ; Encerrar o programa
    mov eax, 1       ; syscall número 1 (exit)
    xor ebx, ebx     ; código de saída (0 = sucesso)
    int 80h          ; chamar a interrupção 80h para sair