# React Native
React Native, 跨平台开发 Learning ...

[React Native 中文文档](http://reactnative.cn/docs/0.38/getting-started.html)

## 安装

1.安装 [Homebrew](http://brew.sh)

2.安装 Node.js

	brew install node 
若安装失败, 则官网下载包安装: [Node.js官网pkg](https://nodejs.org/en)  

3.安装完node后建议设置npm镜像以加速后面的过程（或使用科学上网工具）

	npm config set registry https://registry.npm.taobao.org --global
	npm config set disturl https://npm.taobao.org/dist --global

4.Yarn、React Native的命令行工具（react-native-cli）

Yarn是Facebook提供的替代npm的工具，可以加速node模块的下载。React Native的命令行工具用于执行创建、初始化、更新项目、运行打包服务（packager）等任务。

	npm install -g yarn react-native-cli

如果你看到EACCES: permission denied这样的权限报错，那么请参照上文的homebrew译注，修复/usr/local目录的所有权： 之后再执行以上安装命令;

	sudo chown -R `whoami` /usr/local


5.Xcode 检查命令行工具是否安装:  
Xcode | Preferences | Locations菜单中检查一下是否装有某个版本的Command Line Tools 


## 推荐安装的工具
### Watchman
Watchman是由Facebook提供的监视文件系统变更的工具。安装此工具可以提高开发时的性能（packager可以快速捕捉文件的变化从而实现实时刷新）

	brew install watchman

## 创建运行项目
	创建项目
	react-native init iReactNative
	
	运行项目,三种方法:
	1.cd iReactNative
	react-native run-ios
	2.可以在Nuclide中打开iReactNative文件夹,然后运行;
	3.双击ios/iReactNative.xcodeproj文件,然后在Xcode中点击Run按钮;
	
	To run your app on iOS:
	cd /Users/zhang/Desktop/iReactNative
	react-native run-ios
	- or -
	Open /Users/zhang/Desktop/iReactNative/ios/iReactNative.xcodeproj in Xcode
	Hit the Run button
	
	To run your app on Android:
	Have an Android emulator running (quickest way to get started), or a device connected
	cd /Users/zhang/Desktop/iReactNative
	react-native run-android

	
	
## 在已有iOS应用中集成React Native
1.Cocoapods安装:  pod所需要的库到工程 (node_modules在Pods/React下)

	target 'iReactNative' do
	pod 'React'
	pod "React/RCTActionSheet"  
	pod "React/RCTGeolocation"  
	pod "React/RCTImage"  
	pod "React/RCTLinkingIOS"  
	pod "React/RCTNetwork"  
	pod "React/RCTSettings"  
	pod "React/RCTVibration"  
	pod "React/RCTWebSocket"  
	pod "React/RCTText"  //若在React Native中使用<Text>，则添加
	end

	pod install
	
	安装完成后，项目Target/Building Settings/ 搜索Search Paths, 找到 User Header Search Paths, 输入 $(PODS_ROOT)，选择 recursive.
		
3.在工程目录下新建Components文件夹，和 index.ios.js文件(同在根目录下),并在index.ios.js文件里粘贴一下代码：

    'use strict';  
      
    var React = require('react-native');  
    var {  
      AppRegistry,  
      StyleSheet,  
      Text,  
      View,  
    } = React;  
      
    var iReactNative = React.createClass({  
      render: function() {  
        return (  
          <View style={styles.container}>  
            <Text style={styles.welcome}>  
              Welcome to React Native!  
            </Text>  
            <Text style={styles.instructions}>  
              To get started, edit index.android.js  
            </Text>  
            <Text style={styles.instructions}>  
              Shake or press menu button for dev menu  
            </Text>  
          </View>  
        );  
      }  
    });  
      
    var styles = StyleSheet.create({  
      container: {  
        flex: 1,  
        justifyContent: 'center',  
        alignItems: 'center',  
        backgroundColor: '#F5FCFF',  
      },  
      welcome: {  
        fontSize: 20,  
        textAlign: 'center',  
        margin: 10,  
      },  
      instructions: {  
        textAlign: 'center',  
        color: '#333333',  
        marginBottom: 5,  
      },  
    });  
      
    AppRegistry.registerComponent('iReactNative', () => iReactNative);  

以上React Native部分已经弄完.

4.开始原生部分

新建显示React Native的UIView:
用来加载显示React Native的容器是 RCTRootView，它是继承自UIView;
	
在ViewController.m中

    #import "RCTRootView.h"  
      
	- (void)viewDidLoad {
	    [super viewDidLoad];
	    
	    [self initRNView];
	}
	
	-(void)initRNView {
	    NSURL *jsCodeLocation;
	    jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
	    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
	                                                        moduleName:@"iReactNative"
	                                                 initialProperties:nil
	                                                     launchOptions:nil];
	    //注意，这里是 @"iReactNative"
	    rootView.frame = CGRectMake(0, 64, 300, 300);
	    [self.view addSubview:rootView];
	}
	
5.运行出现提示找不到服务器，以及数据传输的安全问题;
<1>允许http请求: 打开info.plist文件，添加

	App Transport Security Settings    -》 Dictionary
	          Allow Arbitrary Loads          -》 YES

<2>启动服务器
工程目录下，终端输入：

    cd Pods/React
    npm run start
    
<3>编写脚本文件run.sh 

    vi run.sh  

输入

    #! /bin/bash  
    (cd Pods/React; npm run start)  


然后给run.sh添加可执行权限：chmod +x run.sh
之后开启服务器时，只需要在终端输入命令： ./run.sh


	
## 管理React Native库的版本
在开发中，会经常控制React Native的版本库，得以适配各种条件下的开发;

查看本地的React Native的版本

	➜  RectNative git:(master) ✗ watchman --version
	4.5.0

更新本地的React Native的版本

	npm update -g react-native-cli

查询react-native的npm包最新版本

	npm info react-native

升级或者降级到某一版本

	npm install--savereact-native@0.18

更新项目templates文件

    react-native upgrade


