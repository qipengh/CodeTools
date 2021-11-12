#!/bin/bash
set -e

usage () {
    echo "Usage:"
    echo "      container_name     "
    echo "      docker_image       "
    echo " bash ${0} tf2_xxx yyy_docker"
    exit -1
}

if [[ $# -lt 2 ]]; then
    usage
fi

container_name=$1
docker_image=$2

#--------------------------------------------
# step 1 : docker pull
#
# docker pull ${IMAGE}
#--------------------------------------------

docker pull ${docker_image}

echo -e "\ndocker pull ${docker_image} done !\n"

#--------------------------------------------
# step 2 : docker run
#
# docker run -dit --name=${container_name} --privileged --network=host --cap-add=sys_ptrace --device=/dev/yyy_dev0 --device=/dev/yyy_ctl -v /data/tensorflow:/data/tensorflow -v /tools:/tools -v /projs/framework/${USER}:/projs/framework/${USER} ${IMAGE}
#--------------------------------------------

docker run -dit --name=${container_name} --privileged --network=host --cap-add=sys_ptrace --device=/dev/yyy_dev0 --device=/dev/yyy_ctl -v /data/tensorflow:/data/tensorflow -v /tools:/tools -v /projs/framework/${USER}:/projs/framework/${USER} ${docker_image}

echo -e "docker run ${container_name} done !\n"


#--------------------------------------------
# step 3 : docker exec
#
# docker exec -it --workdir=/projs/framework --user=${USER} ${container_name} bash
#--------------------------------------------

echo "if docker exec error with 'unable to find user', Please run command follow:"
echo -e "  docker exec --use-nas-user -it --workdir=/projs/framework ${container_name} bash\n"

echo "docker exec -it ..."
docker exec -it --workdir=/projs/framework --user=${USER} ${container_name} bash

