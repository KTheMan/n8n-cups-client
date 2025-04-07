FROM docker.n8n.io/n8nio/n8n:latest
RUN apk --no-cache add su-exec cups-client
