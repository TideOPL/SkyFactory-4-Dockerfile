FROM openjdk:alpine
MAINTAINER Stefan Urban <stefan.urban@live.de>

USER root
WORKDIR /minecraft

VOLUME ["/minecraft/world"]
EXPOSE 25565

# Download and unzip minecraft files
RUN apk update && apk add curl wget && \
    mkdir -p /minecraft/world && \
    wget -c https://media.forgecdn.net/files/3012/800/SkyFactory-4_Server_4.2.2.zip -O SkyFactory_4_Server.zip && \
    unzip SkyFactory_4_Server.zip && \
    rm SkyFactory_4_Server.zip
    
# Accept EULA
RUN echo "# EULA accepted on $(date)" > /minecraft/eula.txt && \
    echo "eula=TRUE" >> eula.txt

# Install minecraft server itself
RUN /bin/sh /minecraft/Install.sh

# Startup script
CMD ["/bin/sh", "/minecraft/ServerStart.sh"] 
