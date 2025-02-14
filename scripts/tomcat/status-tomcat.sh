#!/bin/bash

# Nome do contêiner do Tomcat
NOME_DO_CONTEINER="tomcat-server"

# Verificar o status do contêiner e reiniciar se estiver parado por mais de 1 minuto
STATUS=$(docker inspect -f '{{.State.Status}}' $NOME_DO_CONTEINER)

timestamp() {
    date +"%Y-%m-%d %H:%M:%S" 
}

if [ "$STATUS" == "running" ]; then
  TEMPO_ATIVO=$(docker inspect -f '{{.State.StartedAt}}' $NOME_DO_CONTEINER)
  SEGUNDOS_ATIVO=$(( $(date +%s) - $(date -d "$TEMPO_ATIVO" +%s) ))
  HORA=$((SEGUNDOS_ATIVO / 3600))
  MIN=$(((SEGUNDOS_ATIVO % 3600)/60)) 
  SEG=$((SEGUNDOS_ATIVO % 60))
  echo "$(timestamp) | A instância do Tomcat está em execução." 
  echo "$(timestamp) | Tempo de atividade: $((HORA)) h   $((MIN)) min $((SEG)) seg."
else
    echo "$(timestamp) | Serviço  $((NOME_DO_CONTAINER)) INATIVO".
    ./start-tomcat.sh >> /home/vagrant/tomcat/log/inativo/log.txt
fi
