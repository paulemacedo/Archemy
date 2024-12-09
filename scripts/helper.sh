#!/bin/bash

# Cores ANSI para formatação de saída
#readonly COLOR_RED='\033[0;31m'
#readonly COLOR_GREEN='\033[0;32m'
#readonly COLOR_YELLOW='\033[0;33m'
#readonly COLOR_BLUE='\033[0;34m'
#readonly COLOR_MAGENTA='\033[0;35m'
#readonly COLOR_CYAN='\033[0;36m'
#readonly COLOR_RESET='\033[0m'

# Função para exibir mensagens coloridas
print_message() {
    local color="$1"
    local message="$2"
    echo -e "${color}${message}${COLOR_RESET}"
}

# Wrapper para mensagens de sucesso
success_msg() {
    print_message "$COLOR_GREEN" "$1"
}

# Wrapper para mensagens de erro
error_msg() {
    print_message "$COLOR_RED" "[ERRO] $1" >&2
}

# Wrapper para mensagens de aviso
warn_msg() {
    print_message "$COLOR_YELLOW" "[AVISO] $1"
}

# Wrapper para mensagens informativas
info_msg() {
    print_message "$COLOR_BLUE" "[INFO] $1"
}

# Função para confirmar ação
confirm_action() {
    local message="${1:-Deseja continuar?}"
    read -p "$message (y/N): " response
    [[ "$response" =~ ^[Yy]$ ]]
}

# Função para verificar se o script está sendo executado com permissões de root
require_root() {
    if [[ "$EUID" -ne 0 ]]; then
        error_msg "Este script precisa ser executado como root ou com sudo."
        exit 1
    fi
}

# Função para registrar logs
log_message() {
    local log_file="${LOG_FILE:-/var/log/archemy.log}"
    local message="$1"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $message" | tee -a "$log_file"
}

# Função para backup de arquivos/configurações
backup_file() {
    local file_path="$1"
    local backup_dir="${2:-/tmp/archemy_backups}"

    if [[ ! -e "$file_path" ]]; then
        error_msg "Arquivo não encontrado: $file_path"
        return 1
    fi

    mkdir -p "$backup_dir"
    local timestamp
    timestamp=$(date "+%Y%m%d_%H%M%S")
    local backup_file="${backup_dir}/$(basename "$file_path")_${timestamp}.bak"

    cp -v "$file_path" "$backup_file"
    success_msg "Backup criado: $backup_file"
}

# Função para restaurar backup
restore_backup() {
    local backup_file="$1"
    local target_path="$2"

    if [[ ! -e "$backup_file" ]]; then
        error_msg "Arquivo de backup não encontrado: $backup_file"
        return 1
    fi

    cp -v "$backup_file" "$target_path"
    success_msg "Backup restaurado para: $target_path"
}

# Função para verificar espaço em disco
check_disk_space() {
    local threshold="${1:-10}"  # Padrão: 10% livre
    local disk_usage
    disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

    if [[ "$disk_usage" -ge $((100 - threshold)) ]]; then
        error_msg "Espaço em disco baixo! Uso atual: ${disk_usage}%"
        return 1
    fi

    info_msg "Espaço em disco: OK (${disk_usage}% usado)"
}

# Função principal do helper (para testes)
main() {
    info_msg "Helper de Utilidades do Archemy"
    
    # Exemplos de uso
    success_msg "Teste de mensagem de sucesso"
    error_msg "Teste de mensagem de erro"
    warn_msg "Teste de aviso"
    
    if confirm_action "Deseja ver informações de espaço em disco?"; then
        check_disk_space
    fi
}

# Se o script for executado diretamente, chama a função main
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi