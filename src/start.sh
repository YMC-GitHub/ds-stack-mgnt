#!/bin/sh

THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/conf.sh
source ${THIS_FILE_PATH}/lang.sh
source ${THIS_FILE_PATH}/sh-lib-swarm.sh


# 建虚拟机
now_step=step_10
echo "# $now_step -> ${lang_steps[$now_step]}"
create_sw_vm

# 列虚拟机
now_step=step_11
echo "# $now_step -> ${lang_steps[$now_step]}"
ls_sw_vm

# 设管理机
now_step=step_12
echo "# $now_step -> ${lang_steps[$now_step]}"
set_sw_manager

# 设工作机
now_step=step_13
echo "# $now_step -> ${lang_steps[$now_step]}"
set_sw_worker

# 查看节点
now_step=step_14
echo "# $now_step -> ${lang_steps[$now_step]}"
ls_sw_node $my_manager_vms_name$MANAGER_START_INDEX

# 连管理机
now_step=step_20
echo "# $now_step -> ${lang_steps[$now_step]}"
#link_sw_manager $my_manager_vms_name$MANAGER_START_INDEX
# 登录仓库
now_step=step_21
echo "# $now_step -> ${lang_steps[$now_step]}"
 sw_manager_login_to_hub
# 部署应用
now_step=step_22
echo "# $now_step -> ${lang_steps[$now_step]}"
sw_manager_deploy_app $my_app_name_prefix
# 查看服务
now_step=step_23
echo "# $now_step -> ${lang_steps[$now_step]}"
sw_manager_check_deploy $my_app_name_prefix
