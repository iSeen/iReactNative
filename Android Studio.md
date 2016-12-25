## Java not found：Android Studio was unable to find a valid JVM
检查:  
`java -version`  查看mac系统上有没有安装jdk, 没有安装jdk请先安装jdk;
原因:  
接下来确定自己的jdk版本，如果jdk的版本不是1.6版本就有可能出现以上问题，无法启动Android Studio。原因在于Android Studio的配置文件中默认要求的是1.6版本的JVM，所以可以简单的修改下Android Studio的配置文件。

解决：
1.Android Studio.app, 右键菜单，选择Show Package Contents,进入Contents文件夹，找到Info.plist配置文件。
2.打开Info.plist配置文件，找到其中的<key>JVMVersion<key>标签，可以看到这个标签下面为<string>1.6<string>，默认使用JVM1.6版本，现在最新的JDK已经是1.8了。把1.6改成你所安装的jdk版本号然后保存修改就可以解决这个问题，或者简单的改成1.6+就可以兼容1.6以上的jdk版本。