FROM alpine:latest

# Environment variables
ENV MC_VERSION="1.21.8" \
    EULA="false" \
    MC_RAM="6G" \
    JAVA_OPTS=""

COPY papermc.sh .
RUN apk update \
    && apk add libstdc++ \
    && apk add openjdk21-jre \
    && apk add bash \
    && apk add curl \
    && apk add jq \
    && apk add zip \
    && mkdir /papermc \
    && mkdir /papermc/plugins \
    && mkdir /papermc/temp

COPY server.properties /papermc
COPY bukkit.yml /papermc
COPY server-icon.png /papermc


# Add plugins
ADD https://github.com/EssentialsX/Essentials/releases/download/2.21.2/EssentialsX-2.21.2.jar /papermc/temp/EssentialsX.jar
ADD https://download.luckperms.net/1610/bukkit/loader/LuckPerms-Bukkit-5.5.21.jar /papermc/temp/LuckPerms.jar
ADD https://hangarcdn.papermc.io/plugins/EngineHub/WorldEdit/versions/7.3.17/PAPER/worldedit-bukkit-7.3.17.jar /papermc/temp/WorldEdit.jar
ADD https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/5.6.0/PAPER/ViaVersion-5.6.0.jar /papermc/temp/ViaVersion.jar
ADD https://hangarcdn.papermc.io/plugins/Multiverse/Multiverse-Core/versions/5.4.0/PAPER/multiverse-core-5.4.0.jar /papermc/temp/multiverse-core.jar
ADD https://hangarcdn.papermc.io/plugins/Oliver/FancyNpcs/versions/2.8.0/PAPER/FancyNpcs-2.8.0.jar /papermc/temp/FancyNpcs.jar
ADD https://cdn.modrinth.com/data/DKY9btbd/versions/PO4MKx7e/worldguard-bukkit-7.0.14-dist.jar /papermc/temp/worldguard.jar
ADD https://hangarcdn.papermc.io/plugins/SyntaxDevTeam/CleanerX/versions/1.5.3/PAPER/CleanerX-Paper-1.5.3-all.jar /papermc/temp/cleanerx.jar
ADD https://github.com/A5H73Y/Parkour/releases/download/Parkour-7.2.5-RELEASE.131/Parkour-7.2.5-RELEASE.jar /papermc/temp/parkour.jar
ADD https://cdn.modrinth.com/data/qvdtDX3s/versions/YgwE3Cbi/multiverse-inventories-5.3.0.jar /papermc/temp/multiverse-inventories.jar
ADD https://cdn.modrinth.com/data/vtawPsTo/versions/xTnZkHQL/multiverse-netherportals-5.0.3.jar /papermc/temp/multiverse-netherportals.jar
ADD https://cdn.modrinth.com/data/2qgyQbO1/versions/BdLUtz0O/EssentialsXChat-2.21.2.jar /papermc/temp/EssentialsXChat.jar
ADD https://hangarcdn.papermc.io/plugins/TNE/VaultUnlocked/versions/2.17.0/PAPER/VaultUnlocked-2.17.0.jar /papermc/temp/VaultUnlocked.jar
ADD https://cdn.modrinth.com/data/GLJ7ZGMW/versions/DbExIHg5/UltraCosmetics-3.14-RELEASE.jar /papermc/temp/UltraCosmetics.jar
ADD https://cdn.modrinth.com/data/TsLS8Py5/versions/oiCdtX5p/SkinsRestorer.jar /papermc/temp/SkinsRestorer.jar


# Install mcrcon
ADD https://github.com/Tiiffi/mcrcon/releases/download/v0.7.2/mcrcon-0.7.2-linux-x86-64-static.zip /papermc/temp/mcrcon.zip
RUN unzip /papermc/temp/mcrcon.zip

# Start script
CMD ["bash", "./papermc.sh"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp
