
#!/bin/sh
THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/conf.sh
source ${THIS_FILE_PATH}/lang.sh
source ${THIS_FILE_PATH}/sh-lib-swarm.sh

# 关掉机器
# Stop all running VMs
stop_sw_vm
# 离开集群
leave_sw
# 删虚机器
# Delete all VMs and their disk images
#delete_sw_vm