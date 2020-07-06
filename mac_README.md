#使用说明
1. 将需要修改的apk包放在workingArea目录里面
2. 进入mac目录
3. 配置config.sh，将APKPackageName=“workingArea目录里面的某个apk包名”
4. 运行终端Terminal，进入mac目录`cd /.../mac`
5. 执行脚本“1.解包.sh” 命令：`sh 1.解包.sh`
6. 执行完成后会自动打开解包后的项目目录
7. 替换对应的文件，目录详细描述：
    * assets：配置目录
        * ClientConfig.xml：客户配置文件
        * DefaultConfig.xml：全局默认配置文件
    * res：资源目录
    * 


8. 重复步骤4；执行脚本“2.打包.sh” 命令：`sh 2.打包.sh`
9. 执行完成后会自动打开签名signed目录-->就是替换完资源文件的apk安装包
