
# Build a docker image
$ sudo docker build -t "test_image" docker/

# Run an image in a container
$ sudo docker run -t -i --name=test_container 09d0e29d5da2 /bin/bash