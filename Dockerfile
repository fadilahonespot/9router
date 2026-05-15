# Gunakan base image Debian Slim agar lebih kompatibel dengan native modules (sqlite)
FROM oven/bun:1.1-slim

WORKDIR /app

# Install Node.js dan build tools versi Debian
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    python3 \
    make \
    g++ \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# 1. Pre-install database agar tidak perlu build saat runtime
RUN mkdir -p /app/data/runtime && \
    cd /app/data/runtime && \
    npm init -y && \
    npm install better-sqlite3@12.6.2 --no-audit --no-fund

# 2. Setup folder data dan symlink agar 9router bisa menulis konfigurasi
RUN mkdir -p /app/data && ln -sf /app/data /root/.9router

# 3. Install 9router secara global
RUN bun install -g 9router

# Environment variables default
ENV PORT=20128
ENV DATA_DIR=/app/data
ENV HOSTNAME=0.0.0.0
ENV DEBUG=true 

# Ekspos port
EXPOSE 20128

# Jalankan 9router
CMD ["9router", "server"]
