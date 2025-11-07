FROM debian:bookworm-slim AS builder

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app

RUN apt update && \
    apt install -y curl ca-certificates gnupg unzip --no-install-recommends && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt update && apt install -y nodejs && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/ChenRaptor/portfolio_beta.kaitems.fr/archive/refs/heads/without-docker.zip -o repo.zip && \
    unzip repo.zip -d /app && \
    mv /app/portfolio_beta.kaitems.fr-without-docker/* /app && \
    rm -rf repo.zip /app/portfolio_beta.kaitems.fr-without-docker

RUN npm ci && npm run build

FROM debian:bookworm-slim AS runner

ENV NODE_ENV=production
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app

RUN apt update && \
    apt install -y curl ca-certificates gnupg && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt update && apt install -y nodejs && \
    apt clean && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

RUN npm ci --omit=dev

EXPOSE 3000

CMD ["npm", "start"]
