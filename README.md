# Running

## Build image

```docker build -t papermc .```

## Launch the container

```docker container run -it -v $PWD/worlds:/papermc/worlds -v $PWD/plugins:/papermc/plugins -e EULA="true" -p 25565:25565 papermc```

## Use RCON

```docker exec -it <container> ./mcrcon-0.7.2-linux-x86-64-static/mcrcon -H localhost -p minecraft -w 5 "broadcast Hello!"```