FROM minio/minio:latest

# Installer outils pour monitoring
RUN apk add --no-cache coreutils bash

# Exposer les ports
EXPOSE 9000 9001

# Variables d'environnement par défaut
ENV MINIO_CONSOLE_ADDRESS=":9001"

# Créer répertoire data
RUN mkdir -p /data && chmod 755 /data

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:9000/minio/health/live || exit 1

# Commande de démarrage
CMD ["minio", "server", "/data", "--console-address", ":9001"]
