#!/bin/bash

# Nome do serviço (no caso, WildFly)
NOME_SERVICO="wildfly"

timestamp() {
    date +"%Y-%m-%d %H:%M:%S" 
}

TEMPO_PARADO=$(systemctl show -p InactiveEnterTimestamp --value "$NOME_SERVICO")
SEGUNDOS_PARADO=$(( $(date +%s) - $(date -d "$TEMPO_PARADO" +%s) ))
DIA=$((SEGUNDOS_PARADO / 86400))  
HORA=$(((SEGUNDOS_PARADO % 86400) / 3600)) 
MIN=$(((SEGUNDOS_PARADO % 3600) / 60))  
SEG=$((SEGUNDOS_PARADO % 60))

echo "$(timestamp) | O serviço $NOME_SERVICO está INATIVO."
echo "$(timestamp) | Tempo de INATIVIDADE: $((DIA)) d  $((HORA)) h  $((MIN)) min $((SEG)) seg."

if [ "$SEGUNDOS_PARADO" -gt 60 ]; then
    sudo systemctl start "$NOME_SERVICO"
   
    if [ $? -eq 0 ]; then
        echo "$(timestamp) | Serviço $NOME_SERVICO iniciado com sucesso."

    else
        echo "$(timestamp) | Falha ao iniciar o serviço $NOME_SERVICO."
    fi
fi
