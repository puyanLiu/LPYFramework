# Moles Packer
- [github地址](https://github.com/ctripcorp/moles-packer/)
- [中文文档](https://youngoat.gitbooks.io/moles-unprofessional-guide/content/zh-cn/)

## 安装
> 版本要求 moles_packer >= 0.1.9

```
# 全局安装
npm install -g moles-packer

# 全局安装完成后，将在系统中创建两个命令
moles-pack -v
moles-pack-common -v
```

## 创建应用

### 创建
```
# 创建一个工作区并切换到该目录，后续的创建和构建操作都将在此目录中完成。
mkdir workspace
cd workspace

# 创建一个名为 v037 的应用。
# 命令执行完成名，将在工作区创建一个应用同名目录，存放与应用有关的一切。
react-native init v037 --version 0.37.0

# 切换到应用目录，并检查其版本。
cd v037
react-native --version
# 本机运行结果
# react-native-cli: 2.0.1
# react-native: 0.37.0
```

### 运行
> 通过打开Xcode运行或react-native run-ios

## 使用Moles Packer进行构建
```
# 切换到应用目录。
cd v037

# 构建一个适用于 iOS 平台的可独立运行的版本。
# 打开 --verbose 开关可获取更多构建细节。
moles-packer --entry index.ios.js --platform ios --standalone --output ./build --verbose
```

> 构建完成，在./build目录下生成以下目录

```
.
├── index.ios.jsbundle
├── moles.common
│   ├── common.ios.jsbundle
│   └── common.ios.json
└── moles.meta.json
```

## 在模拟器中运行构建结果
- 用构建结果取代应用源代码
- 需启动一个本地HTTP服务，并且通过该服务访问index.ios.jsbundle文件
    + 本机使用XAMPP，window电脑可使用WAMP（亲测，使用node的http-server，会下载链接）
    + `http://localhost/index.ios.jsbundle`，具体URL根据个人配置略有不同

    ```
    !function(_){_.__DEV__=!1,_.__BUNDLE_START_TIME__=Date.now()}("undefined"!=typeof global?global:"undefined"!=typeof self?self:this);
!function(r){"use strict";function t(r,t){r in u||(u[r]={factory:t,hasError:!1,isInitialized:!1,exports:void 0})}function i(r){var t=u[r];
    ......
    ```

- 在Xcode中，更改AppDelegate.m文件，在模拟器中重新启动应用，此时运行的包就是我们刚刚打好的bundle包
```
//  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];

  jsCodeLocation = [NSURL URLWithString:@"http://localhost/index.ios.jsbundle"];
```

## 模仿moles-packer项目过程

### 按上述步骤生成项目

- 并添加如下三个.ios.js文件

```
.
├── __tests__
├── android
├── build
├── index.android.js
├── index.ios.js
├── ios
├── node_modules
├── package.json
├── reactcommonbridge1.ios.js
├── reactcommonbridge2.ios.js
└── reactseperatedbridge.ios.js
```

### 通过Moles Packer构建打包成bundle文件
构建命令
```
moles-packer --entry reactcommonbridge1.ios.js --platform ios --bundle --verbose
moles-packer --entry reactcommonbridge2.ios.js --platform ios --bundle --verbose
moles-packer --entry reactseperatedbridge.ios.js --platform ios --bundle --verbose
```

构建成功后的build目录，构建后均为index.ios.jsbundle，自行更改包名
```
.
├── moles.common
│   ├── common.ios.jsbundle
│   └── common.ios.json
├── moles.meta.json
├── reactcommonbridge1.ios.jsbundle
├── reactcommonbridge2.ios.jsbundle
└── reactseperatedbridge.ios.jsbundle
```

## 模仿moles-packer项目出现的问题
- 出现如下问题，在项目环境中运行`npm install moles-packer`
```
start ... react / es2015 ... /Users/liupuyan/.nvm/versions/node/v5.11.0/lib/node_modules/moles-packer/node_modules/babel-core/lib/transformation/file/options/option-manager.js:176
          throw new ReferenceError(messages.get("pluginUnknown", plugin, loc, i, dirname));
          ^

ReferenceError: Unknown plugin "transform-es5-property-mutators" specified in "base" at 0, attempted to resolve relative to "/Users/liupuyan/Desktop/workspace/rn37demo"
```

- 若React Native版本为0.38.0之上，会出现如下问题

```
[MOLES_PACKER] -- Process common bundle --

    [MOLES_PACKER] react-native v0.38.0 has not been supported yet. We will try to handle it.
```

- 本机使用0.37.0，出现如下问题

```
[MOLES_PACKER] -- Process common bundle --
module.js:341
throw err;
^

Error: Cannot find module 'node-haste/lib/DependencyGraph/docblock.js'

解决方案：全局安装node-haste `npm install -g node-haste`
```

- 项目中实际模块名ReactExample，但是打包后模块名统一是`MOLES`，如果更改则出现如下问题

```
Application ReactExample has not been registered. This is either due to a require() error during initialization or failure to call AppRegistry.registerComponent.
```

## Moles Packer命令详解
> 版本要求 moles_packer >= 0.3.0

### 全局安装完成后，将在系统中创建两个命令
- moles-pack
    + 用于项目构建，可编译业务代码并将其打包，也可同时创建公包
- moles-pack-common
    + 仅用于创建公包及相应的元数据文件
```
# 打印帮助信息。
moles-packer --help

# 显示版本。
moles-packer --version
```

### 参数详解
> `缺省值`是指该选项缺省时，程序默认的选项值
> `选项缺省值`是指该选项存在但未赋值时，程序默认的选项值

```
--bundle 选项为例：

moles-packer
# 此时，--bundle 选项值为其“缺省值”。

moles-packer --bundle
# 此时，--bundle 选项值为其“选项值缺省”值。
```

- `--bundle [<bundle.js>]`
    + 指示将构建结果合并输出，该文件将被保存在`--output`指定的目录中
```
OUTPUT/index.ios.jsbundle       # 适用于 iOS 平台的业务包或可独立运行的程序包
OUTPUT/index.android.jsbundle   # 适用于 Android 平台的业务包或或独立运行的程序包
OUTPUT/index.jsbundle           # 跨平台的业务包
```

    + Moles Packer 构建的可独立运行的程序包，必须是平台相关的，故其文件名中也包括平台名称
    + bundle文件中默认不包含公包模块，除非使用了`--standalone`选项

- `--deve`
    + 在开发模式下构建的代码，在运行时可以输出更多的调试信息

- `--entry <entry/file/basename>`
    + 缺省值 `index.js`
    + 指定入口文件名称

- `--platform ios | android | cross`
    + 缺省值 `cross`
    指定构建输出结果适用的操作系统平台
    如果打包结果需要跨平台通用，开发人员须确保业务代码中没有引用平台相关的模块，否则请分别执行命令，以获取平台相关的业务包  

- `--standalone`
    + 是否输出可独立运行的bundle文件
    + 该选项应与`--bundle` 和 `--platform`选项配合使用

- `--minify`    
    + 默认情形下，Moles Packer 将保持输出代码的可读性，不对其进行压缩和混淆。如需获得更小尺寸的构建结果，请打开 `--minify`开关
    
- `--verbose`
    + 打开此开关可获取更多构建细节

- `--input <path/to/project/dir>`\
    + 缺省值 `.` 当前目录
    + 指定项目目录

- `--output <path/to/output/dir>`
    + 缺省值 `./build` 当前目录的build子目录
    + 指定输出目录（不存在则创建，如果存在，则会覆盖相关文件）

- `--help`
    + 打印帮助信息
    + 出现该参数，其他所有参数将被忽略

- `-h`
    + 等同于`--help`



