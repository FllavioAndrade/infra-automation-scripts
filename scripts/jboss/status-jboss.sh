#!/bin/bash

# Nome do serviço (no caso, WildFly)
NOME_SERVICO="wildfly"

# Verifica o status do serviço
STATUS=$(systemctl is-active "$NOME_SERVICO")

timestamp() {
    date +"%Y-%m-%d %H:%M:%S" 
}

# Se o serviço estiver rodando
if [ "$STATUS" = "active" ]; then
    # Obtém o timestamp de quando o serviço foi iniciado
    TEMPO_ATIVO=$(systemctl show -p ActiveEnterTimestamp --value "$NOME_SERVICO")

    # Converte o timestamp para segundos
    SEGUNDOS_ATIVO=$(( $(date +%s) - $(date -d "$TEMPO_ATIVO" +%s) ))
    DIA=$((SEGUNDOS_ATIVO / 86400))  
    HORA=$(((SEGUNDOS_ATIVO % 86400) / 3600)) 
    MIN=$(((SEGUNDOS_ATIVO % 3600) / 60))  
    SEG=$((SEGUNDOS_ATIVO % 60))

    echo "$(timestamp) | O serviço $NOME_SERVICO está EM EXECUÇÃO."
    echo "$(timestamp) | Tempo de atividade: $((DIA)) d  $((HORA)) h  $((MIN)) min $((SEG)) seg."


# Se o serviço estiver parado
elif [ "$STATUS" = "inactive" ]; then
    echo "$(timestamp) |  Serviço $((NOME_SERVICO)) INATIVO." 
    ./start-jboss.sh >> /home/vagrant/jboss/log/inativo/log.txt
fi
