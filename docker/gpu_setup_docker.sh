#!/bin/bash
set -e

usage () {
    echo "Usage:"
    echo "      container_name     "
    echo "      docker_image       "
    echo " bash ${0} tf2_xxx nvcr.io/nvidia/tensorflow:21.08-tf2-py3"
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

echo -e "docker pull ${docker_image} done !\n"

#--------------------------------------------
# step 2 : docker run
#
# docker run -it --name=${container_name} --network=host -v /home/${USER}:/home/${USER} -w /home/tensorflow -v /dev/nvidia0:/dev/nvidia0 -v /dev/nvidia1:/dev/nvidia1 -v /dev/nvidia2:/dev/nvidia2 -v /data:/data -v /datasets:/datasets --device=/dev/nvidiactl --device=/dev/nvidia-uvm --device=/dev/nvidia-uvm-tools --device=/dev/nvidia-modeset -v /usr/local/cuda-10.2/lib64:/usr/local/cuda-10.2/lib64 --gpus all --pid=host --privileged ${docker_image} /bin/bash
#--------------------------------------------

echo "docker run ${container_name} ..."

docker run -it \
    --name=${container_name} \
    --network=host      \
    -v /home/zhangqirui/huangqipeng:/home/tensorflow \
    -w /home/tensorflow \
    -v /dev/nvidia0:/dev/nvidia0 \
    -v /dev/nvidia1:/dev/nvidia1 \
    -v /dev/nvidia2:/dev/nvidia2 \
    -v /data:/data      \
    -v /datasets:/datasets \
    --device=/dev/nvidiactl \
    --device=/dev/nvidia-uvm \
    --device=/dev/nvidia-uvm-tools \
    --device=/dev/nvidia-modeset \
    -v /usr/local/cuda-10.2/lib64:/usr/local/cuda-10.2/lib64 \
    --gpus all \
    --pid=host \
    --privileged ${docker_image} /bin/bash
