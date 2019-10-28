## MySQL

## 安装与卸载

**环境：** CentOS 7 , MySQL 5.6

**检查：**

```
rpm -qa|grep mysql 
yum repolist all | grep mysql
```

**卸载：**

```
# 卸载mysql 
yum remove -y mysql mysql-libs mysql-common 
# 删除mysql下的数据文件
rm -rf /var/lib/mysql 
# 删除mysql配置文件
rm /etc/my.cnf  
# 删除组件
yum remove -y mysql-community-release-el6-5.noarch 
```

**安装：**

```
# 下载rpm文件 
wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm 
# 执行rpm源文件 
rpm -ivh mysql-community-release-el6-5.noarch.rpm 
# 执行安装文件 
yum install mysql-community-server
```

**启动：**

```
systemctl start mysqld
```

**设置密码：**

```
/usr/bin/mysqladmin -u root password 'root' 
# 没有密码 有原来的密码则加 
/usr/bin/mysqladmin -u root -p '123' password 'root'
```

**登录：**

```
mysql -uroot -proot
```

**配置CNF：**

```
vim /etc/my.cnf
```

```
[mysqld]

# MySQL设置大小写不敏感：默认：区分表名的大小写，不区分列名的大小写 
# 0：大小写敏感 1：大小写不敏感 
lower_case_table_names=1 
# 默认字符集 
character-set-server=utf8
```

## Docker 安装

**查询 Image：**

```
docker search mysql
```

**选择版本下载：**

```
# 5.6 为指定拉取版本，如果没有数字，默认拉取最新版本
docker pull mysql:5.6
```

**指定端口，密码并启动：**

```
# --name 指定启动的 image 名称
# -p 指定端口，冒号前边为容器端口，冒号后边为宿主机端口（MySQL 启动后本机对外端口）
# -e MYSQL_ROOT_PASSWORD 初始化密码
# -d 后台运行容器
# 最后的为 image 镜像 id
docker run --name mysql-server -p 3306:3306  -e MYSQL_ROOT_PASSWORD=admin -d mysql:5.6
```

**进入 MySQL：**

```
docker exec -it mysql-name bash
mysql -uroot -padmin
```

**导出 SQL 数据：**

**执行 docker ps 命令**

| CONTAINER ID | IMAGE     | COMMAND                | CREATED    | STATUS      | PORTS                  | NAMES        |
| ------------ | --------- | ---------------------- | ---------- | ----------- | ---------------------- | ------------ |
| 1ab1d901d409 | mysql:5.6 | "docker-entrypoint.s…" | 3 days ago | Up 24 hours | 0.0.0.0:3306->3306/tcp | mysql-server |

```
docker exec -it mysql-server mysqldump -uroot -padmin OriginSource > /Users/bonismo/Desktop/CopySource.sql
```

