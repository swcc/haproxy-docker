# haproxy + ucarp
This container runs a haproxy with ucarp to make it high available.

## Configuration
To configure haproxy, you can either bind-mount a haproxy.cfg from your
host system to `/haproxy/haproxy.cfg` in the container or create a custom
image by using a Dockerfile like this:

    FROM fish/haproxy-docker
    ADD  haproxy.cfg /haproxy/haproxy.cfg

## Setup
On `host A` start the container:

    $ docker run --privileged fish/haproxy-docker 10.0.1.201 foobar23

And move a sub interface to the container with [pipework](https://github.com/jpetazzo/pipework):

    $ pipework eth0 <ID> 10.0.1.190/24

Repeat the same on a second host but specify a different IP when calling
pipework. Now you should have two haproxy running and ucarp making sure only
one listens on 10.0.1.201.

# Failure Scenarios
If any service (haproxy or nginx) goes down, the container is supposed to kill UCARP so the IP gets removed and the backup can take over.

If for any reasons this isn't working, kill the container manually. This should cause the backup to take over.

If this is not the case, there is a problem with the backup container. You might want to restart it.
