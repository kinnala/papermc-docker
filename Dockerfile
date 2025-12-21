# We're no longer using openjdk:17-slim as a base due to several unpatched vulnerabilities.
# The results from basing off of alpine are a smaller (by 47%) and faster (by 17%) image.
# Even with bash installed.     -Corbe
FROM alpine:latest

# Environment variables
ENV MC_VERSION="1.21.8" \
    PAPER_BUILD="60" \
    EULA="false" \
    MC_RAM="4G" \
    JAVA_OPTS=""

COPY papermc.sh .
RUN apk update \
    && apk add libstdc++ \
    && apk add openjdk21-jre \
    && apk add bash \
    && apk add wget \
    && apk add jq \
    && mkdir /papermc \
    && mkdir /papermc/plugins

# Add plugins
ADD https://github.com/EssentialsX/Essentials/releases/download/2.21.2/EssentialsX-2.21.2.jar /papermc/plugins/EssentialsX.jar
ADD https://download.luckperms.net/1610/bukkit/loader/LuckPerms-Bukkit-5.5.21.jar /papermc/plugins/LuckPerms.jar
ADD https://www.patreon.com/file?h=145853143&m=580728422 /papermc/plugins/CoreProtect.jar
ADD https://hangarcdn.papermc.io/plugins/EngineHub/WorldEdit/versions/7.3.17/PAPER/worldedit-bukkit-7.3.17.jar /papermc/plugins/WorldEdit.jar

# Start script
CMD ["bash", "./papermc.sh"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /papermc
