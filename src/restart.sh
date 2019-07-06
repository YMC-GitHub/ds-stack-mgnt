#!/bin/sh

THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/conf.sh
source ${THIS_FILE_PATH}/lang.sh
source ${THIS_FILE_PATH}/sh-lib-swarm.sh

sw_manager_check_deploy $my_app_name_prefix