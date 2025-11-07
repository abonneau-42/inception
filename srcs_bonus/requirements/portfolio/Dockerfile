FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV VERSION_CURL="7.88.1-10+deb12u14"
ENV VERSION_CA_CERTS="20230311+deb12u1"
ENV VERSION_GNUPG="2.2.40-1.1+deb12u1"
ENV VERSION_UNZIP="6.0-28"
ENV VERSION_NODE="20.*"

WORKDIR /app

RUN apt update && \
    apt install -y curl=${VERSION_CURL} ca-certificates=${VERSION_CA_CERTS} gnupg=${VERSION_GNUPG} unzip=${VERSION_UNZIP} --no-install-recommends && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt update && apt install -y nodejs=${VERSION_NODE} && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/ChenRaptor/portfolio_beta.kaitems.fr/archive/refs/heads/without-docker.zip -o repo.zip && \
    unzip repo.zip -d /app && \
    mv /app/portfolio_beta.kaitems.fr-without-docker/* /app && \
    rm -rf repo.zip /app/portfolio_beta.kaitems.fr-without-docker

RUN npm ci && npm run build

EXPOSE 3000

CMD ["npm", "start"]
