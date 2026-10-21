# Jenkins "todo en uno" para el laboratorio de la semana 5.
# El controlador también actúa como agente (aceptable en un laboratorio, no en producción).
FROM jenkins/jenkins:lts-jdk21

USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends python3 python3-venv python3-pip make zip \
 && rm -rf /var/lib/apt/lists/*
USER jenkins
