# Running

## Build image

```docker build -t papermc .```

## Launch the container

```docker container run -it -v $PWD/worlds:/papermc/worlds -v $PWD/plugins:/papermc/plugins -e EULA="true" -p 25565:25565 papermc```