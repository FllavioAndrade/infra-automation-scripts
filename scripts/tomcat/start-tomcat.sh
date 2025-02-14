#!/bin/bash

# Nome do contêiner do Tomcat
NOME_DO_CONTEINER="tomcat-server"

# Reinicia o Container se estiver parado por mais de 1 minuto

timestamp() {
    date +"%Y-%m-%d %H:%M:%S" 
}

HORA_PARADA=$(docker inspect -f '{{.State.FinishedAt}}' $NOME_DO_CONTEINER)
TEMPO_PARADO=$(( $(date +%s) - $(date -d "$HORA_PARADA" +%s) ))
HORA=$((TEMPO_PARADO / 3600))
MIN=$(((TEMPO_PARADO % 3600)/60))
SEG=$((TEMPO_PARADO % 60))

echo "$(timestamp) | A instância $NOME_DO_CONTAINER está INATIVA"
echo "$(timestamp) | Tempo de inatividade: $((HORA)) h   $((MIN)) min $((SEG)) seg."
if [ $TEMPO_PARADO -gt 60 ]; then
  docker start $NOME_DO_CONTEINER
  sleep 5
  echo "$(timestamp) | instancia iniciada com sucesso."
fi
