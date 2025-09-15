FROM minio/minio:latest

# Exposer les ports
EXPOSE 9000 9001

# Variables d'environnement par défaut
ENV MINIO_CONSOLE_ADDRESS=":9001"

# Créer répertoire data
USER root
RUN mkdir -p /data && chmod 755 /data

# Health check simple sans curl
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD pgrep minio || exit 1

# Revenir à l'utilisateur minio
USER minio

# Commande de démarrage
CMD ["minio", "server", "/data", "--console-address", ":9001"]
