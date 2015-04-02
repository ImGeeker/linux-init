## nginx站点配置说明
所有站点必须以域名命名,以.conf结尾,如:

> imhuzi.net.conf
> read.imhuzi.net.conf

注: 顶级域名默认包括www子域

### 代理

如果需要代理以java 容器，使用以java.*开头的模板,如:

```shell
# 替换域名
sed 's/_DOMAIN_/imhuzi.net/' java.proxy.domain.tpl > imhuzi.net
# 替换端口
sed 's/_PORT_/8080/' imhuzi.net > imhuzi.net.conf && rm imhuzi.net
```

如果是php项目，项目目录必须以域名命名,link到/var/www/目录下,然后生成配置文件

```shell
# 替换域名
sed 's/_DOMAIN_/imhuzi.net/' php.domain.tpl > blog.imhuzi.net.conf
```

### 负载

以java项目为例

```shell
# 替换域名
sed 's/_DOMAIN_/imhuzi.net/' java.upstream.domain.tpl > imhuzi.net1
# 替换端口
sed 's/_PORT_/8080/' imhuzi.net1 > imhuzi.net && rm imhuzi.net1
sed 's/_IP/192\.168\.1\.110/' imhuzi.net > imhuzi.net.conf && rm imhuzi.net
```
#TODO 模板生成脚本 
