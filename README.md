Docker image for Cloud9
=======================

To install the C9 SDK:
[Running the SDK](https://cloud9-sdk.readme.io/v0.1/docs/running-the-sdk)

The github repo:
[Cloud9 Core](https://github.com/c9/core)

# Windows - Docker toolbox (the old docker)

## With cmd
For starting docker:
```bat
cd "C:\Program Files\Docker Toolbox"
"C:\Program Files\Git\bin\bash.exe" --login -i "C:\Program Files\Docker Toolbox\start.sh"
SET DOCKER_TLS_VERIFY=1
SET DOCKER_HOST=tcp://192.168.99.100:2376
SET DOCKER_CERT_PATH=%USERPROFILE%\.docker\machine\machines\default
SET DOCKER_MACHINE_NAME=default
SET COMPOSE_CONVERT_WINDOWS_PATHS=true
```

## In case of network and DNS errors
In VirtualBox, make sure the first network card has 'NAT' mode
In the VM, enter:
```bash
echo "nameserver 8.8.8.8"  > /etc/resolv.conf
```



# Commands

## Build
```bat
docker build -t aureliend/cloud9:latest --compress .
```

## Run
```bat
docker run --rm --name cloud9 -it -p 80:80 aureliend/cloud9:latest
```

## Run bash (for tests)
```bat
docker run --rm --name cloud9 -it -p 80:80 aureliend/cloud9:latest bash
```

To run the Cloud9 server:
```bash
/usr/bin/nodejs /cloud9/server.js -p 80 -l 0.0.0.0 -w /workspace -a :
```

## Remove dangling docker images on Windows
```bat
docker image prune
```

## Remove containers
See [https://gist.github.com/ngpestelos/4fc2e31e19f86b9cf10b](https://gist.github.com/ngpestelos/4fc2e31e19f86b9cf10b)
```bat
FOR /f "tokens=*" %i IN ('docker ps -a -q') DO docker rm %i
```

## Remove ALL images
```bat
FOR /f "tokens=*" %i IN ('docker images -aq') DO docker rmi %i
```


