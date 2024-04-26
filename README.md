# CentOS 7 SSH Container

Docker image to run SSHD on CentOS 7. This can be used to test SSH connections on an OS that does not support newer signature algorithms.

To use:
1. Edit `authorized_keys` and add any necessary public key entires
1. Build the image with your desired end user: `docker compose build --build-arg username=<user>`
1. Run `docker compose up`
1. Connect to the server at `ssh <user>@<host ip> -p 22222`
    * `<host ip>` is the IP of the host machine running docker
    * `<user>` is what was passed as the build argument
    * The port is always `22222`
