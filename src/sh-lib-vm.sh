#!/bin/sh

THIS_FILE_PATH=$(cd `dirname $0`; pwd)

####################
# operation for vm with docker-machine
####################
# https://docs.docker.com/machine/drivers/virtualbox/
create_vm(){
    #https://docs.docker.com/machine/reference/ls/#formatting
    local HAS_VM=$(docker-machine ls --filter "name=${1}" --format "{{.Name}}")

    if [ $HAS_VM != ${1} ]
    then
        echo "b---->:create vm ${1}"
         docker-machine create --driver virtualbox ${1}
        echo "e---->:create vm ${1}"
    fi
}
start_vm(){
    local VM_SYTATE=$(docker-machine ls --filter "name=${1}" --format "{{.State}}")
    if [ $VM_SYTATE != "Running" ]
    then
        echo "b---->:start vm ${1}"
        my_vm_name=${1}
        docker-machine start $my_vm_name
        echo "e---->:start vm ${1}"
    fi
}
connect_vm(){
    local VM_IS_ACTIVE=$(docker-machine active)
    # echo $VM_IS_ACTIVE ${1}

    # change [ $VM_IS_ACTIVE != ${1} ] to fix:"[: =: unary operator expected"
    if [[ $VM_IS_ACTIVE != ${1} ]]
    then
        echo "b---->:connect to vm ${1} by exporting env for docker-machine"
        my_vm_name=${1}
        docker-machine env $my_vm_name
        #eval $("D:\Program Files\Docker Toolbox\docker-machine.exe" env $my_vm_name)
        #eval $("docker-machine env $my_vm_name")
        eval $(docker-machine env $my_vm_name)
        echo "export COMPOSE_CONVERT_WINDOWS_PATHS=1"
        export COMPOSE_CONVERT_WINDOWS_PATHS=1
        # docker-machine ls
        echo "e---->:connect to vm ${1} by exporting env for docker-machine"
        # echo "ok"
        echo "the active machine is $(docker-machine active)"
    else
        echo "you have connected to ${1}"
    fi
}
stop_vm(){
    if [ -n ${1} ]
    then
        echo "b---->:stop vm ${1} "
        docker-machine stop ${1}
        echo "e---->:stop vm ${1} "
    fi
}
rm_vm(){
    if [ -n ${1} ]
    then
       echo "b---->:rm vm ${1} "
         docker-machine rm -y ${1}
       echo "b---->:rm vm ${1} "
    fi
}

one_key_start(){
    local my_vm_name=${1}
    create_vm $my_vm_name
    start_vm $my_vm_name
}

