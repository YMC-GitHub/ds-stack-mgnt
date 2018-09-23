#!/bin/bash

basepath=$(cd `dirname $0`; pwd)
source ${basepath}/conf.sh
source ${basepath}/lang.sh
source ${basepath}/swarm.sh

sw_manager_down_app $my_app_name_prefix