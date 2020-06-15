# Build the Image
docker build -t hpecp-tutorialbox .
# Remove the running container
docker rm -f hpecp-tutorialbox
# Create a new container
docker run -d -p 8899:8888 --name hpecp-tutorialbox hpecp-tutorialbox:latest

