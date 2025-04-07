FROM docker.n8n.io/n8nio/n8n:latest

# Install su-exec and cups-client as root
USER root
RUN apk --no-cache add su-exec cups-client

# Switch back to the default user (node)
USER node

