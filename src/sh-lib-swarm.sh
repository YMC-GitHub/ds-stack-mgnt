#!/bin/sh
THIS_FILE_PATH=$(cd `dirname $0`; pwd)

###
# deps
###
#source ${THIS_FILE_PATH}/sh-lib-vm.sh

##########
#建虚拟机
##########
#docker-machine create --driver virtualbox myvm1
#docker-machine create --driver virtualbox myvm2
#docker-machine create --driver virtualbox myvm3
create_sw_vm(){
for i in $(seq $MANAGER_START_INDEX $MANAGER); do one_key_start $my_manager_vms_name$i; done
for i in $(seq $WORKER_START_INDEX $WORKER); do one_key_start $my_worker_vms_name$i; done
}

# 列虚拟机
#docker-machine ls
ls_sw_vm(){
    docker-machine ls
}

# 设管理机
#docker-machine ssh myvm1 "docker swarm init --advertise-addr $(docker-machine ip myvm1)"
set_sw_manager(){
    docker-machine ssh $my_manager_vms_name$MANAGER_START_INDEX \
    "docker swarm init \
    --auto-accept manager \
    --auto-accept worker \
    --listen-addr $(docker-machine ip $my_manager_vms_name$MANAGER_START_INDEX):2377"
local d=$(($MANAGER_START_INDEX + 1))
if [ $d -lt "$MANAGER" ]; then MANAGER_START_INDEX=$MANAGER ;fi
for i in $(seq $($MANAGER_START_INDEX) $MANAGER); do
    docker-machine ssh $my_manager_vms_name$i \
    "docker swarm join \
    --manager \
    --listen-addr $(docker-machine ip $my_manager_vms_name$i):2377 \
    $(docker-machine ip $my_manager_vms_name$MANAGER_START_INDEX):2377"
done
}

# 设工作机
#docker-machine ssh myvm2 "docker swarm join --token SWMTKN-1-2jhcfueglcmknowqnaus2gucxtsxeedga7jcw7wfpf7ocpo32q-bhh7fj430jk6t7z0oh6bxofjs 192.168.99.101:2377"
#docker-machine ssh myvm3 "docker swarm join --token SWMTKN-1-2jhcfueglcmknowqnaus2gucxtsxeedga7jcw7wfpf7ocpo32q-bhh7fj430jk6t7z0oh6bxofjs 192.168.99.101:2377"
set_sw_worker(){
    for i in $(seq $WORKER_START_INDEX $WORKER); do
    docker-machine ssh $my_worker_vms_name$i \
    "docker swarm join \
    --listen-addr $(docker-machine ip $my_worker_vms_name$i):2377 \
    $(docker-machine ip $my_manager_vms_name$MANAGER_START_INDEX):2377"
    done
}

# 查看节点
#docker-machine ssh myvm1 "docker node ls"
ls_sw_node(){
    docker-machine ssh ${1} "docker node ls"
}

# 离开集群
# 工作机离开集群
#docker-machine ssh myvm2 "docker swarm leave"
#docker-machine ssh myvm3 "docker swarm leave"
# 管理机离开集群
#docker-machine ssh myvm1 "docker swarm leave -f"
leave_sw(){
    for i in $(seq $WORKER_START_INDEX $WORKER); do docker-machine ssh $my_worker_vms_name$i "docker swarm leave"; done
    for i in $(seq $MANAGER_START_INDEX $MANAGER); do docker-machine ssh $my_manager_vms_name$i "docker swarm leave -f"; done

}

# 连管理机
# eval $(docker-machine env myvm1)
# docker-machine ls
#docker-machine ssh myvm1
link_sw_manager(){
   docker-machine ssh ${1}
}

##########
#下面的命令在管理机中运行
##########
# 登录仓库
#docker login hub.c.163.com
#docker login -u ${user_u} -p ${user_p} ${hub_address}
sw_manager_login_to_hub(){
  docker-machine ssh $my_manager_vms_name$MANAGER_START_INDEX docker login -u ${user_u} -p ${user_p} ${hub_address}
}

# 部署应用
# cd to my/app/path
# cd ...
#docker stack deploy -c docker-compose.yml --with-registry-auth getstartedlab
sw_manager_deploy_app(){
    docker-machine ssh $my_manager_vms_name$MANAGER_START_INDEX "cd $my_stack_compose_file_dir && docker stack deploy -c docker-compose.yml --with-registry-auth ${1}"
}

# 查看服务
#docker service ls
#docker stack ps --filter "desired-state=running" getstartedlab
sw_manager_check_deploy(){
docker-machine ssh $my_manager_vms_name$MANAGER_START_INDEX docker service ls
docker-machine ssh $my_manager_vms_name$MANAGER_START_INDEX docker stack ps --filter "desired-state=running" ${1}
}

# 关闭应用
sw_manager_down_app(){
    docker-machine ssh $my_manager_vms_name$MANAGER_START_INDEX "cd $my_stack_compose_file_dir && docker stack rm ${1}"
}

# 关掉机器
stop_sw_vm(){
for i in $(seq $MANAGER_START_INDEX $MANAGER); do stop_vm $my_manager_vms_name$i; done
for i in $(seq $WORKER_START_INDEX $WORKER); do stop_vm $my_worker_vms_name$i; done
}
# 删除机器
delete_sw_vm(){
for i in $(seq $MANAGER_START_INDEX $MANAGER); do rm_vm $my_manager_vms_name$i; done
for i in $(seq $WORKER_START_INDEX $WORKER); do rm_vm $my_worker_vms_name$i; done
}