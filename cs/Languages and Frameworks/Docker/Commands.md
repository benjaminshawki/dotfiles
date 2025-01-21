# Commands

### Creating and Running a Container from an image
docker run "some image"
docker run "some image" + command 
    overrides the default startup command
    

### Showing containers
`docker ps`
    shows all running containers
    
`docker ps --all `
    shows all the containers ever created

    
Docker run = docker create + docker start

`docker start "id"`
(no output)

`docker start -a "id"`
(with output)

`docker logs "id"`
(after docker start to show the output)

`docker stop "id"`
SIGTERM (withcleanup after 10 seconds kill)

`docker kill "id"`
SIGKILL (without cleanup, immidiatly)

`docker exec -it "id" "command"`
execute an additional command in teh coontainer

`-it`
(-i -t)

`sh`
(command) open shell in a running container shell

`docker build -t bluejund/redis:latest .`
Tagging the image

 Alpine version of an image means you get the most stripped down version as possible
