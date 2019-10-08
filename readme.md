# quickly start stack

##### \#**desc**
create or start machines , set manager or worker host ... . one key one do!

##### \#**conf**
define your configuration for  sh's files  in `conf.sh`:
```
# the prefix of your mananger host name
my_manager_vms_name=myvm
# the prefix of your worker host name
my_worker_vms_name=myvm
# the start-and-end index of your mananger host number
MANAGER=1
MANAGER_START_INDEX=1
# the start-and-end index of your WORKER host number
WORKER=2
WORKER_START_INDEX=2
# the image hub info
hub_address=hub.c.163.com
user_u=hualei03042013@163.com
user_p=xxx
# the the prefix of stack app
my_app_name_prefix=getstartedlab

# the path of then docker-compose.yml file  of the stack in your manager host machine 
my_stack_compose_file_dir=/ymc/bin/stack-quick-start
```

##### \#**usage**
you can run as below:
```
######
#start you stack
######
# way 1:
$ cd /to/your/start.sh/path
$ bash ./start.sh

# way 2:
$ cd /to/your/start.sh/path
$ ./start.sh

######
#restart you stack
######
# way 1:
$ cd /to/your/restart.sh/path
$ bash ./restart.sh

# way 2:
$ cd /to/your/restart.sh/path
$ ./restart.sh

######
#stop you stack
######
# way 1:
$ cd /to/your/stop.sh/path
$ bash ./stop.sh

# way 2:
$ cd /to/your/stop.sh/path
$ ./stop.sh

######
#clear you stack
######
# way 1:
$ cd /to/your/clear.sh/path
$ bash ./clear.sh

# way 2:
$ cd /to/your/clear.sh/path
$ ./clear.sh

```

##### \#**note**
my pc is win7-64bt, and i use docker 12.x .
my environment:
```
$ docker version
Client:
 Version:      1.12.6
 API version:  1.24
 Go version:   go1.6.4
 Git commit:   78d1802
 Built:        Wed Jan 11 00:23:16 2017
 OS/Arch:      windows/amd64

An error occurred trying to connect: Get http://%2F%2F.%2Fpipe%2Fdocker_engine/v1.24/version: open //./pipe/docker_engine: The system cannot find the file specified.


$ docker-machine version
docker-machine.exe version 0.8.2, build e18a919

$ docker-compose version
docker-compose version 1.22.0, build f46880f
docker-py version: 3.5.0
CPython version: 2.7.15
OpenSSL version: OpenSSL 1.0.2o  27 Mar 2018
```

if you are careful ,you would find that An error occurred when i run `docker version` in win7 ,not docker2box.// run as below to solve it:
```
$ docker-machine ssh default "docker version"

# or
$ docker-machine ssh default
$ docker version

# or (best)
docker-machine ssh default << eof
docker version
eof
```
if you are more careful , having do as above, you would also find a funny thing here!


now share with you!