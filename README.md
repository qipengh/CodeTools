# Code工作台（工欲善其事必先利其器）

- 通用
- Linux工作台
- Windows工作台
## 通用
编辑器、Docker、Git
1. 解压压缩：`Bandizip`
2. 护眼：`flux`、`Redshift`
3. pdf阅读器：福昕阅读器
4. 思维导图：XMind

### 编辑器
VS Code（`code神器`）、Sourcetrail（免费开源）、Source Insight（收费）

- Visual Studio Code（免费、开源、神器）

1、配置：|[VSCode-开发效率翻倍](https://zhuanlan.zhihu.com/p/54164612)|--|[VSCode C++ 开发利器](https://zhuanlan.zhihu.com/p/96819625)|--|[awesome-vscode](https://github.com/viatsko/awesome-vscode)|

2、使用：[VS Code 的常用快捷键](https://zhuanlan.zhihu.com/p/44044896)

- Sourcetrail（开源、免费、源码可视化）
[开源免费的源码阅读神器 Sourcetrail](https://zhuanlan.zhihu.com/p/96685579)

- Source Insight（收费）

### Git 基本版本控制
参考：[Git-版本控制](https://gitee.com/qipengh/CodeTools/tree/main/Git-版本控制.md)

### Docker容器
参考：[Docker-容器](https://gitee.com/qipengh/CodeTools/tree/main/Docker-容器.md)

## Linux工作台
- 教程
1. [Linux工具快速教程](https://linuxtools-rst.readthedocs.io/zh_CN/latest/index.html)Linux开发必看！！！
2. [写给工程师的 Ubuntu 20.04 最佳配置指南](https://sspai.com/post/60411)
3. 文件传输：gFTP
4. 代码对比：Meld Diff Viewer、[Linux下9种优秀的代码比对工具推荐](https://zhuanlan.zhihu.com/p/150576676)
5. 三剑客vim+ctags+cscope、两板斧doxygen gdb：[Linux 平台下阅读源码的工具](https://www.jianshu.com/p/09e74b05fd5d)

#### 相见恨晚的Linux命令
**c++filt、nm**
- c++filt：还原so中的函数名
- nm：显示指定File中符号信息
- ldd: 查看程序依赖库

**查看文件和文件夹大小** |[参考](https://zhuanlan.zhihu.com/p/44710698)|
- `ls  -l filename`：文件大小
- `du -sh`：文件夹大小（所有文件大小的总和）`du -h --max-depth=1 dir` `du -h --max-depth=0 dir/*`
- `df -h`：文件系统各分区大小
- `hdparm  -Tt [/dev/sda]`：分区磁盘速度

#### 1、Terminator终端
- 配置

安装`sudo apt-get install terminator`，配置文件`~/.config/terminator/config`，具体配置参考[terminator_config](https://gitee.com/qipengh/CodeTools/tree/main/configs/terminator_config)

bashrc配置参考[bashrc](https://gitee.com/qipengh/CodeTools/tree/main/configs/bashrc)

- 快捷键
1. 终端：打开（`Ctrl+Shift+T`）、关闭当前（`Ctrl+Shift+W`）
2. 当前窗口：切换显示（`Ctrl+Shift+X`）、退出（`Ctrl+Shift+Q`）
3. 分割终端：水平（`Ctrl+Shift+O`）、垂直（`Ctrl+Shift+E`）
4. 垂直分割的分割条：向左（`Ctrl+Shift+Left`）、向右（`Ctrl+Shift+Right`）
5. 隐藏/显示滚动条（`Ctrl+Shift+S`）、clear屏幕（`Ctrl+Shift+G`）
6. 搜索（`Ctrl+Shift+F`）、复制（`Ctrl+Shift+C`）、粘贴（`Ctrl+Shift+V`）

#### 2、Tmux(终端复用器)
- [Tmux 使用教程](http://www.ruanyifeng.com/blog/2019/10/tmux.html)
- 翻页翻屏

进入tmux翻屏模式(先按 ctrl ＋ｂ，松开，然后再按 [ )；上下翻页（PgUp、PgDn）；退出(q)

#### 3、Vim配置
- 简单配置参考：[simple_vimrc](https://gitee.com/qipengh/CodeTools/tree/main/configs/simple_vimrc)

- 详细配置：解压`./configs/vim.tar.gz`-安装插件`vim +PluginInstall +qall`

**参考**
1. [vim插件管理器：Vundle](https://blog.csdn.net/zhangpower1993/article/details/52184581)
2. [Vundle：Vim Plugin](https://blog.gtwang.org/linux/vundle-vim-bundle-plugin-manager/)
参考：[Vim配置](https://gitee.com/qipengh/CodeTools/tree/main/Linux/Vim)

# 编译与调试
GCC、GDB、Valgrind
- GCC：[GCC(警告.优化以及调试选项）](https://www.cnblogs.com/lsgxeva/p/7605141.html)

## Bazel

[参考](https://blog.csdn.net/A_L_A_N/article/details/88018718)，其工作原理：加载与target有关的BUILD文件；分析inputs和dependencies，生成 action graph；执行graph，产出outputs。其中action graph： bazel依赖这个图来追踪文件变化，以及是否需要重新编译，并且还可以为用户提供代码之间的依赖关系图。
```bash
# bazel clean
bazel clean # 不会删除外部依赖
bazel clean --expunge # 会删除外部依赖

# bazel build
bazel build :<exe name> # 在BUILD所在的package目录下执行，编译指定的target
bazel build :all  # 编译该package下的所有target
bazel build ...  # 编译该package下的所有target
bazel build <//path/to/package>:<exe name> # 在workspace下的任意目录执行，“//”表示workspace所在目录
bazel build :<exe name> --compilation_mode=dbg # debug mode
bazel build :<exe name> -c dbg # debug mode

# bazel run
bazel run :<target name>
bazel run -- :<target name>
```

## gdb调试
- [100个GDB技巧](https://wizardforcel.gitbooks.io/100-gdb-tips/content/index.html)
- [掌握gdb调试从入门到进阶（一）](https://zhuanlan.zhihu.com/p/100385553)
- [掌握gdb调试从入门到进阶（二）](https://zhuanlan.zhihu.com/p/100403438)
- [GDB调试教程：1小时玩转Linux gdb命令](http://c.biancheng.net/gdb/)
- [GDB 基础知识及断点
](https://www.jianshu.com/p/9f81880752cd)
- [gdb-python调试记录](https://meteorix.github.io/2019/04/30/pytorch-coredump/)

## valgrind 内存泄漏与越界检查
- [valgrind 检查 C++ 程序的内存泄漏](https://zhiqiang.org/coding/check-cpp-memory-using-valgrind.html)
