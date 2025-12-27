#!/bin/bash

# Enter server directory
cd papermc

# Remove old plugins and copy new plugins
rm plugins/*.jar
cp temp/* plugins/

# Set nullstrings back to 'latest'
: ${MC_VERSION:='latest'}

# Lowercase these to avoid 404 errors on wget
MC_VERSION="${MC_VERSION,,}"

# Download paper
PROJECT="paper"
MINECRAFT_VERSION="${MC_VERSION}"
USER_AGENT="cool-project/1.0.0 (contact@me.com)"

# First check if the version exists
VERSION_CHECK=$(curl -s -H "User-Agent: $USER_AGENT" https://fill.papermc.io/v3/projects/${PROJECT}/versions/${MINECRAFT_VERSION}/builds)

# Check if the API returned an error
if echo "$VERSION_CHECK" | jq -e '.ok == false' > /dev/null 2>&1; then
  ERROR_MSG=$(echo "$VERSION_CHECK" | jq -r '.message // "Unknown error"')
  echo "Error: $ERROR_MSG"
  exit 1
fi

# Get the download URL directly, or null if no stable build exists
PAPERMC_URL=$(curl -s -H "User-Agent: $USER_AGENT" https://fill.papermc.io/v3/projects/${PROJECT}/versions/${MINECRAFT_VERSION}/builds | \
  jq -r 'first(.[] | select(.channel == "STABLE") | .downloads."server:default".url) // "null"')

if [ "$PAPERMC_URL" != "null" ]; then
  # Download the latest Paper version
  curl -o server.jar $PAPERMC_URL
  echo "Download completed"
else
  echo "No stable build for version $MINECRAFT_VERSION found :("
fi

# Update eula.txt with current setting
echo "eula=${EULA:-false}" > eula.txt

# Add RAM options to Java options if necessary
if [[ -n $MC_RAM ]]
then
  JAVA_OPTS="-Xms${MC_RAM} -Xmx${MC_RAM} $JAVA_OPTS"
fi

# Start server
exec java -server $JAVA_OPTS -jar server.jar nogui
