Docker image for Cloud9
=======================

## Usage

The server runs on port 80.

### Get it
[Docker hub](https://hub.docker.com/r/aureliend/cloud9/)

```bash
docker pull aureliend/cloud9:latest
```

### Run
```bash
docker run --rm --name cloud9 -it -p 80:80 aureliend/cloud9:latest
```

### Build
```bash
docker build -t aureliend/cloud9:latest --compress .
```

### Customize server
```bash
docker run --rm --name cloud9 -it -p 80:80 aureliend/cloud9:latest node /cloud9/server.js -p 80 -l 0.0.0.0 -w /workspace -a login:password
```
  
  

## Information

To install the C9 SDK:
[Running the SDK](https://cloud9-sdk.readme.io/v0.1/docs/running-the-sdk)

The github repo:
[Cloud9 Core](https://github.com/c9/core)
  
  

## Windows - Docker toolbox (the old docker)

### With cmd
To start docker:
```bat
cd "C:\Program Files\Docker Toolbox"
"C:\Program Files\Git\bin\bash.exe" --login -i "C:\Program Files\Docker Toolbox\start.sh"
REM docker-machine env  "Display the commands to set up the environment for the Docker client"
@FOR /f "tokens=*" %i IN ('docker-machine env') DO @%i
```

### In case of network and DNS errors
With VirtualBox UI, make sure the first network card of the VM has 'NAT' mode
In the VM, enter:
```bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
```
  
  

## Other commands

### Use bash (for tests)
```bat
docker run --rm --name cloud9 -it -p 80:80 aureliend/cloud9:latest bash
```

To run the Cloud9 server:
```bash
node /cloud9/server.js -p 80 -l 0.0.0.0 -w /workspace -a :
```

### Remove dangling docker images
```bash
docker image prune
```

### Remove containers (Windows)
See [https://gist.github.com/ngpestelos/4fc2e31e19f86b9cf10b](https://gist.github.com/ngpestelos/4fc2e31e19f86b9cf10b)
```bat
FOR /f "tokens=*" %i IN ('docker ps -a -q') DO docker rm %i
```

### Remove ALL images
```bat
FOR /f "tokens=*" %i IN ('docker images -aq') DO docker rmi %i
```


