
#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
source ${basepath}/conf.sh
source ${basepath}/lang.sh
source ${basepath}/swarm.sh

# 关掉机器
# Stop all running VMs
stop_sw_vm
# 离开集群
leave_sw
# 删虚机器
# Delete all VMs and their disk images        
#delete_sw_vm