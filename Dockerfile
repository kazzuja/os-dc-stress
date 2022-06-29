FROM ubuntu:22.04
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install stress -y
RUN rm -rf /var/lib/apt/list/*
#COPY src/hello-world.go /go/hello-world.go
# Set the default environment variables
ENV MESSAGE "Welcome to Stress APP"
# Set permissions to the /go folder (for OpenShift)
#RUN chgrp -R 0 /go && chmod -R g+rwX /go
# This container needs Docker or OpenShift to help with networking
EXPOSE 8080
# OpenShift picks up this label and creates a service
LABEL io.openshift.expose-services 8080/http
# OpenShift uses root group instead of root user
USER 1001
# Command to run when container starts up
#CMD go run hello-world.go
ENTRYPOINT ["/usr/bin/bash","-l","-c"]
CMD ["/usr/bin/stress --cpu 2"]
