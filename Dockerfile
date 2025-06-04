FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget curl sudo gnupg2 ca-certificates unzip \
    wine64 net-tools ufw nano xz-utils screen \
    && rm -rf /var/lib/apt/lists/*

# Create the T6Server directory and install the server
WORKDIR /opt
RUN mkdir -p T6Server && \
    wget -O T6Server.tar.gz https://github.com/Sterbweise/T6Server/releases/download/v3.1.1/T6Server.tar.gz && \
    tar -xzvf T6Server.tar.gz -C T6Server && \
    rm T6Server.tar.gz

WORKDIR /opt/T6Server

# Make the install script executable
RUN chmod +x install.sh

# Expose typical port (default Plutonium port)
EXPOSE 4976/udp

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
