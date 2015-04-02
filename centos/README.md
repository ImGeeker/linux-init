### centos 系统初始化开发环境以及服务器环境

```shell

bash ./init.sh
#或者
chmod a+x ./init.sh && ./init.sh

```

### 主要做以下环境进行初始化

- 防火墙
- 编译环境
- git tengine(nginx) mysql postgresql  php node
- jdk

可以在./init.sh脚本中进行删减,脚本默认以root用户执行
