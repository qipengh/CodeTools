
# 使用github、gitlab、gitee

## **如何同时使用 github 和 gitlab**

### 搭建 ssh clone 环境

1、创建各自的私钥/公钥

针对不同的仓库，生成不同的密钥（因为不同的账号，对应不同的用户名和邮箱）

```bash
# 生成gitlab密钥
ssh-keygen -t rsa -C "name@xxx.com" -f ~/.ssh/id_rsa_gitlab
# 生成github密钥
ssh-keygen -t rsa -C "name@qq.com" -f ~/.ssh/id_rsa_github
# 一路回车即可
```
将`id_rsa_gitlab.pub`和`id_rsa_github.pub`的内容分别粘贴到gitlab和github的SSH keys中。

2、配置 `config` 文件

在 `~/.ssh` 目录下创建 `config` 文件

```bash
Host gitlab
    HostName gitlab.xxx.com
    User git
    IdentityFile ~/.ssh/id_rsa_gitlab
    Port xxx_port

Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_github
```

3、测试连接

```bash
$ cd ~/.ssh/

$ ssh -T git@gitlab
# 出现以下内容，说明 GitLab 配置成功
Welcome to GitLab, @xxx!

$ ssh -T git@github.com
# 出现以下内容，说明 GitHab 配置成功
Hi xxx! You've successfully authenticated, but GitHub does not provide shell access.
```

4、愉快地用ssh `clone`代码
```
git clone git@github.com:xxx/xxx.git
git clone ssh://git@gitlab.xxx.com:xxx_port/xxx.git
```

**git 仓库 配置**

git config 文件的三种配置级别
- system （系统级别）：所有用户所有值，位于 git安装目录；
- global（用户级别）：具体用户，位于 `~/.gitconfig`；
- local（仓库级别）：特定指向单一的库，位于 `.git/config`；

```bash
# 用户级别配置
$ git config --global user.name 'xxx' #公司账号名称
$ git config --global user.email 'xxx@xxx.com' #公司账号邮箱

# 仓库级别配置
$ git init
$ git config --local user.name 'username' #github账号名称
$ git config --local user.email 'username@gmail.com' #github账号邮箱
```

### 操作本地仓库

两种方式：

**1、创建单独命名的 Remotes**

```bash
# 如果 GitLab 是主要存储库，那么可以为 GitHub 添加一个远程主机
git remote add github https://github.com/user/repo.git

# 将更改推送到任一存储库
git push origin <branch>   (GitLab)
git push github <branch>   (GitHub)

# 下拉远端的更改
git pull origin <branch>   (GitLab)
git pull github <branch>   (GitHub)
```

当在 GitLab 主机上工作时，只需通过push“master”分支来定期更新 GitHub 镜像。
相反，如果社区中有人向 GitHub 镜像提交push请求，则工作流程如下：
1. Review and merge the push request on GitHub
2. Pull “master” into your local workspace
3. Push “master” to GitLab

**2、用两个 Remotes 重载 Origin**

```bash
# 对于您是唯一开发人员的项目，可以采用更简单的方式访问 GitHub 镜像
git remote set-url –add origin https://github.com/user/repo.git

# overloading the default “origin” name to reference both GitLab and GitHub
git push origin <branch>
git pull origin <branch>
```

**参考**

- [如何在同一台电脑上使用github和gitlab](https://segmentfault.com/a/1190000014626841###)
- [How to Use GitLab and GitHub Together](https://steveperkins.com/migrating-projects-from-github-to-gitlab/)