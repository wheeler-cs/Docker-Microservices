# Calibre eBook Server

This container runs the web-based GUI for the Calibre eBook management program
in an isolated environment separate from the host OS.


## Building and Running

Running the Calibre server first requires building the base image using the
`docker build` command in the [Calibre](.) directory.

```bash
cd Calibre
docker build -t calibre .
```

Once the image is built, the container can be initialized from it by issuing the
`docker run` command. This command can be modified to accommodate your network
setup, but a basic general-use run of the command can be:

```bash
docker run -p 127.0.0.1:28080:8080 --name calibre -it calibre
```


## Accessing the Web GUI

Once the container has been started, the Calibre GUI can be accessed from a web
browser at the address and port specified in the run command. For example, if
the above command was used to run the container, the web server is running at
[http://127.0.0.1:28080](http://127.0.0.1:28080).

Upon accessing the web GUI, you will be prompted for a username and password. By
default both the username and password are `calibre`.
