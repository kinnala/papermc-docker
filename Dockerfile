FROM alpine:latest

# Environment variables
ENV MC_VERSION="1.21.8" \
    EULA="false" \
    MC_RAM="4G" \
    JAVA_OPTS=""

COPY papermc.sh .
RUN apk update \
    && apk add libstdc++ \
    && apk add openjdk21-jre \
    && apk add bash \
    && apk add curl \
    && apk add jq \
    && mkdir /papermc \
    && mkdir /papermc/plugins

COPY server.properties /papermc
COPY bukkit.yml /papermc

# Add plugins
ADD https://github.com/EssentialsX/Essentials/releases/download/2.21.2/EssentialsX-2.21.2.jar /papermc/temp/EssentialsX.jar
ADD https://download.luckperms.net/1610/bukkit/loader/LuckPerms-Bukkit-5.5.21.jar /papermc/temp/LuckPerms.jar
ADD https://www.patreon.com/file?h=145853143&m=580728422 /papermc/temp/CoreProtect.jar
ADD https://hangarcdn.papermc.io/plugins/EngineHub/WorldEdit/versions/7.3.17/PAPER/worldedit-bukkit-7.3.17.jar /papermc/temp/WorldEdit.jar
ADD https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/5.6.0/PAPER/ViaVersion-5.6.0.jar /papermc/temp/ViaVersion.jar
ADD https://hangarcdn.papermc.io/plugins/Multiverse/Multiverse-Core/versions/5.4.0/PAPER/multiverse-core-5.4.0.jar /papermc/temp/multiverse-core.jar
ADD https://hangarcdn.papermc.io/plugins/Oliver/FancyNpcs/versions/2.8.0/PAPER/FancyNpcs-2.8.0.jar /papermc/temp/FancyNpcs.jar
ADD https://cdn.modrinth.com/data/DKY9btbd/versions/PO4MKx7e/worldguard-bukkit-7.0.14-dist.jar /papermc/temp/worldguard.jar

# Start script
CMD ["bash", "./papermc.sh"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp
