使用手册

配置在roles下  每个二级目录下的vars 目录中,roles目录下的二级目录代表一个项目
注意 file目录中的文件跟 vars main.yaml对应, 一般情况下请不要修改 vars目录下 main.yaml中的变量名

roles目录结构:

── roles 
   ├── centos
   │   ├── files   #存放agent源代码/二进制可执行程序
   │   │   ├── zabbix_agent.tar.gz
   │   │   └── zabbix_server.tar.gz
   │   ├── tasks
   │   │   └── main.yml
   │   ├── templates  #存放agent配置文件
   │   │   ├── zabbix_agentd.conf.j2
   │   │   ├── zabbix_agentd.j2
   │   │   ├── zabbix_agent.service.j2
   │   │   └── zbx_build.sh.j2
   │   └── vars
   │       └── main.yml
   ├── lauch  #定义预先执行的任务
   │   ├── files
   │   ├── tasks
   │   │   └── main.yml
   │   ├── templates
   │   └── vars
   └── win
       ├── files
       │   └── zabbix_agents_win.zip
       ├── tasks
       │   └── main.yml
       ├── templates
       │   └── zabbix_agentd.win.conf.j2
       └── vars
           └── main.yml


windows PC机配置
ansible 端需要安装 pywinrm 参考网址：https://www.cnblogs.com/wuxie1989/p/8269564.html

安装Framework 3.0+

设置PowerShell 本地脚本运行权限为remotesigned
  set-executionpolicy remotesigned

升级powerShell至3.0+
自动设置windows远端管理

设置 winrm
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

查看winrm是否运行  
如果已经运行 会在taskmanager中看到Winrm服务 正在运行中。
winrm 默认端口为5985,5986
