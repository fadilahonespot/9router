# Gunakan base image Bun yang ringan
FROM oven/bun:1.1-alpine

# Set working directory
WORKDIR /app

# Install Node.js dan build tools (diperlukan untuk native modules seperti better-sqlite3)
RUN apk add --no-cache \
    nodejs \
    npm \
    python3 \
    make \
    g++ \
    sqlite-dev

# Install 9router secara global
RUN bun install -g 9router

# Environment variables default
ENV PORT=20128
ENV DATA_DIR=/app/data
ENV HOSTNAME=0.0.0.0

# Ekspos port
EXPOSE 20128

# Jalankan 9router
CMD ["9router", "server"]
