#!/bin/bash

basepath=$(cd `dirname $0`; pwd)
source ${basepath}/conf.sh
source ${basepath}/lang.sh
source ${basepath}/swarm.sh

sw_manager_check_deploy $my_app_name_prefix