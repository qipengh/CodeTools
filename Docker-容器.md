# Docker容器

1. docker 已经在运行了，怎么打开超过一个的终端？
 docker ps 找到你要进入的container的 id，然后用 docker exec 执行一个 bash。
 如：`docker exec -it 40c330755e61 /bin/bash`
这样你就进到这个container 里面了，这个bash退出也不会影响之前 docker run 启动的 bash
如果需要其他参数可以参考docker 手册 man docker-exec ，man docker-run 等等

**关键字与命令**
- docker：获取命令（`docker`）了解指定命令（`docker [command] --help`）
- image-镜像：拉取（`docker pull`）、列出本地镜像（` docker images`）、删除（`docker rmi`）
- 容器：查看（`docker ps -a`）、启动（`docker run`）、停止（`docker stop`）、重启（`docker restart`）、进入（`docker arttach`；`docker exec`：退出终端不停止）、导出（`docker export`）、导入（`docker import`）、删除（docker rm）
- 终端：退出（`exit`）

`举个栗子:`
```bash
# 拉取镜像（docker pull [OPTIONS] NAME[:TAG|@DIGEST]）
docker pull nvcr.io/nvidia/pytorch:20.03-py3

# 创建容器并启动。（docker run [OPTIONS] IMAGE [COMMAND] [ARG...]）
# -i: 交互式操作；-t: 伪终端；-d: 后台运行；--name: 容器名；-p: 端口映射(主机(宿主)端口:容器端口)
# -v: 目录挂载（本地目录:容器目录）；--gpus: 添加GPU支持；--privileged: 容器内的root拥有真正的root权限
docker run --name waveglow \
			-itd -v $YOUR_DATA_DIR:/workspace/data \
			--gpus all --privileged \
			nvcr.io/nvidia/pytorch:20.03-py3 /bin/bash
# 进入容器，退出终端不会关闭容器
docker exec -it waveglow /bin/bash
# 导出容器
docker export 1e560fca3906 > ubuntu.tar
# 导入容器
cat docker/ubuntu.tar | docker import - test/ubuntu:v1
docker import http://example.com/exampleimage.tgz example/imagerepo
```