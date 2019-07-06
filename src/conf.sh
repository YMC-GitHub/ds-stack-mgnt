#!/bin/sh
echo 'b--->: ini var'
# 主机的名字前缀
my_manager_vms_name=myvm
my_worker_vms_name=myvm
# 管理机的数量
MANAGER=1
MANAGER_START_INDEX=1
# 工作机的数量由起始后缀和结束后缀决定
WORKER=2
WORKER_START_INDEX=2
# 镜像仓库信息
hub_address=hub.c.163.com
user_u=hualei03042013@163.com
user_p=xxx
# 应用的名字前缀
my_app_name_prefix=getstartedlab

# 堆叠配置文件在管理机上的位置
my_stack_compose_file_dir=/ymc/bin/stack-quick-start
now_step=
go_to_next_step=
echo 'e--->: ini var'