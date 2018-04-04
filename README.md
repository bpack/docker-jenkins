An Alpine Linux image that runs Jenkins. Set up to run on the EC2 Container Service in AWS but it can also be run on a Mac (and possibly other platforms that haven't been tested) by using docker-compose.

The latest image is available at [https://hub.docker.com/r/bpack/jenkins/](https://hub.docker.com/r/bpack/jenkins/). Or just `docker pull bpack/jenkins`

Reminders to myself that might be useful:

* `make build` - Builds the docker image.
* `make shell` - Run a shell in the image (for troubleshooting)
* `make run` - Use docker-compose to run this image alongside a socat container.

The default version of 'latest' for an image can be overridden by specifying `make VERSION=x.x.x ...`. This applies to both build and push operations.

Additional details about this image can be found at [https://www.benjaminpack.com/blog/docker-jenkins-mac](https://www.benjaminpack.com/blog/docker-jenkins-mac/).

