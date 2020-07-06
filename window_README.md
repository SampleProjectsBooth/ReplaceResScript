#使用说明
1. 将需要修改的apk包放在workingArea目录里面
2. 进入window目录
3. 配置config.bat，将set APKPackageName=“workingArea目录里面的某个apk包名”
4. 双击执行脚本“1.解包.bat”
5. 执行完成后会自动打开解包后的**自定义配置目录**
6. 修改或替换对应的文件；目录详细描述：
    * Config：配置目录
        * ClientConfig.xml：客户配置文件
        * DefaultConfig.xml：全局默认配置文件
    * AppIcon：应用资源目录
        * icon_app.png：应用图标
    * LoginPage：登陆界面资源目录
        * ic_welcome_logo.png：登陆界面图标
    * Values：应用内容目录
        * strings.xml：应用内容文字描述文件

7. 双击执行脚本“2.打包.bat”
8. 执行完成后会自动打开签名signed目录-->就是替换完资源文件的apk安装包
