*1.14 and 1.15 are both built from their respected branches!*

### This image is built to run on s390x architecture.
-    [build source](https://github.com/korpx-z/golang-s390x) 
-    [original source code](https://github.com/docker-library/golang)

### Versions
1.14, 1.15

# Golang

Go (a.k.a., Golang) is a programming language first developed at Google. It is a statically-typed language with syntax loosely derived from C, but with additional features such as garbage collection, type safety, some dynamic-typing capabilities, additional built-in types (e.g., variable-length arrays and key-value maps), and a large standard library.

> [wikipedia.org/wiki/Go_(programming_language)](http://en.wikipedia.org/wiki/Go_%28programming_language%29)

![logo](https://raw.githubusercontent.com/docker-library/docs/01c12653951b2fe592c1f93a13b4e289ada0e3a1/golang/logo.png)

# How to use this image

**Note:** `/go` is world-writable to allow flexibility in the user which runs the container (for example, in a container started with `--user 1000:1000`, running `go get github.com/example/...` will succeed). While the `777` directory would be insecure on a regular host setup, there are not typically other processes or users inside the container, so this is equivilant to `700` for Docker usage, but allowing for `--user` flexibility.

## Start a Go instance in your app

The most straightforward way to use this image is to use a Go container as both the build and runtime environment. In your `Dockerfile`, writing something along the lines of the following will compile and run your project:

```dockerfile
FROM quay.io/ibm/golang:1.14

WORKDIR /go/src/app
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

CMD ["app"]
```

You can then build and run the Docker image:

```console
$ docker build -t my-golang-app .
$ docker run -it --rm --name my-running-app my-golang-app
```

## Compile your app inside the Docker container

There may be occasions where it is not appropriate to run your app inside a container. To compile, but not run your app inside the Docker instance, you can write something like:

**NOTE**
You are currently unable to perform bind mounts on ZCX. Instead, please use Docker Volumes as illustrated below.

```console
$ docker create volume <your_volume>
```
```console
$ docker run --rm -v <your_volume>:/usr/src/myapp -w /usr/src/myapp quay.io/ibm/golang:1.14 go build -v
```

This will add your current directory as a volume to the container, set the working directory to the volume, and run the command `go build` which will tell go to compile the project in the working directory and output the executable to `myapp`. Alternatively, if you have a `Makefile`, you can run the `make` command inside your container.

```console
$ docker run --rm -v <your_volume>:/usr/src/myapp -w /usr/src/myapp quay.io/ibm/golang:1.14 make
```

## Cross-compile your app inside the Docker container

If you need to compile your application for a platform other than `s390x` (such as `windows/386`):

```console
$ docker run --rm -v <your_volume>:/usr/src/myapp -w /usr/src/myapp -e GOOS=windows -e GOARCH=386 quay.io/ibm/golang:1.14 go build -v
```

Alternatively, you can build for multiple platforms at once:

```console
$ docker run --rm -it -v <your_volume>:/usr/src/myapp -w /usr/src/myapp quay.io/ibm/golang:1.14 bash
$ for GOOS in darwin linux; do
>   for GOARCH in 386 amd64; do
>     export GOOS GOARCH
>     go build -v -o myapp-$GOOS-$GOARCH
>   done
> done
```

# License

View [license information](http://golang.org/LICENSE) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

Some additional license information which was able to be auto-detected might be found in [the `repo-info` repository's `golang/` directory](https://github.com/docker-library/repo-info/tree/master/repos/golang).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
