# Lerna Getting Start

> A tool for managing JavaScript projects with multiple packages.
> 
> — [Lerna Official Website Intro](https://lerna.js.org/)

## 1. Lerna vs Rushjs vs Bolt

- GitHub star数量:   **lerna > rushjs > bolt**
- 良好的文档：  **lerna  = rushjs > bolt**
- 可扩展性： **lerna > rushjs > bolt**
- 使用经验： **lerna > rushjs > bolt**

参考链接： 

[如何评价 rushjs? - 沙包妖梦的回答]( https://www.zhihu.com/question/333587242/answer/741309272)

[Mono Repository Tool Comparison](https://gist.github.com/morewry/d3419a38d74590493042544d4afa49a7)

[The Many Benefits of Using a Monorepo](https://pspdfkit.com/blog/2019/benefits-of-a-monorepo/)

## 2. Lerna 的主要功能

Lerna是一个管理多包、优化工作流程的工具。它的两个主要功能：

- 链接依赖
- 自动检测变更、发布新版本的包
- 管理开发流程

## 3. Lerna 的两种管理模式

1. 固定模式(Fixed， 默认工作模式)，它是通过项目根目录下的`lerna.json`文件中的`version`字段来控制的。

2. 独立模式(Independent), 各个包的版本都是通过自己包下的`package.json`文件中的`version`字段来控制的，同时`lerna.json -> version : independent`

## 4. Getting Started

1. 全局安装lerna(可选)
  
   ```bash
   yarn global add lerna
   ```

2. 初始化项目
  
   ```bash
   mkdir lerna_demo && cd $_
   
   # yarn add lerna --dev && yarn run lerna init --independent
   npx lerna init -i # npx 会检测当前项目下是否有lerna, 没有就会安装; -i 是独立模式independent的简写
   # 目录结构如下
   ├── README.md
   ├── lerna.json
   ├── package.json
   └── packages  # 目录
   # cat lerna.json
      {
         "packages": [
           "packages/*" # package包的位置信息
         ],
         "version": "independent"
      }
   ```

3. 通过yarn 和 [yarn workspaces](https://yarnpkg.com/en/docs/cli/workspaces) 来管理依赖, 修改lerna.json
  
   ```json
   {
       ...
     "npmClient": "yarn", // 使用yarn来跑所有命令， 默认的是npm
     "useWorkspaces": "true" // 使用
   }
   ```

4. 初始化Node项目
  
   ```bash
   yarn init  # 根据提示输入，切记private设置为true , lerna通过这个字段保证此包不会发布到registry
   ```

5. 安装依赖
  
   ```bash
   yarn install # 等价于 lerna bootstrap --npm-client yarn --use-workspaces
   # 它会把通用依赖安装在根目录， 独有的依赖会安装在自己的工作空间下， 各个package之间有相互依赖的通过链接的方式来安装
   ```

6. 创建一个包
  
   ```bash
   # 语法格式
   yarn run lerna create packageName packageLocation # 如果lerna是全局安装的则不需要yarn run 
   
   # 例子
   yarn run lerna create utils packages # 它会按照模板来初始化，目前我没找到在哪里修改模板。所以需要自己修改目录结构
   
   # 注意， 如果是使用scope包的话， 需要在各个包的根目录package.json中添加一下配置
   "publishConfig": {
         "access": "public"
   }
   ```

7. 安装依赖
  
   ```bash
   # Adds the module-1 package to the packages in the 'prefix-' prefixed folders
   yarn run lerna add module-1 packages/prefix-*
   
   #Install module-1 to module-2
   lerna add module-1 --scope=module-2 [--dev | [--peer]]
   
   # Install module-1 in all modules except module-1
   lerna add module-1
   
   # Install babel-core in all modules
   lerna add babel-core
   
   # 给根目录安装通用依赖
   yarn add jest -D -W
   ```

8. lint
  
   ```bash
   # 在每个包里编写一个lint script， 根目录下执行以下命令
   lerna run lint [--parallel] [--stream] [--no-bail]
   # --stream  通过包名，颜色区分不同的包
   # --parallel 并行，加快执行速度
   # --no-bail 报错不退出，全部执行完
   ```

9. 构建
  
   ```bash
   # 方法一： 在每个package中编写build script，根目录下执行以下命令
   # 因为各个包之间存在依赖，所以必须要按照一定的顺序执行，--sort参数可以以拓扑排序规则进行构建
   lerna run --sort build
   ```

10. 两种测试方式：

    - 使用统一的jest测试配置这样方便全局的跑jest即可，好处是可以方便统计所有代码的测试覆盖率，坏处是如果package比较异构（如小程序，前端，node 服务端等），统一的测试配置不太好编写。
    
    - 每个package单独支持test命令，使用lerna run test，坏处是不好统一收集所有代码的测试覆盖率
      
      ```bash
      # 只测试发生了变动的包
      lerna run test --since origin/master
      ```

11. 设置版本号
  
    ```bash
    lerna version [bump] --no-push 
    
    bump set: major, mirror, patch, premajor,premirror, prerelase
    
    # --no-push 表示不推送commit,tag到远程
    # --conventional-commits 根据commit msg生成版本， 成成changelog.md, 参考最后的链接
    
    ## 默认的执行步骤
    # 1  lerna changed 查找更改了的包
    # 2. 弹出提示
    # 3. 修改版本信息
    # 4. commit、tag修改后的信息
    # 5. 推送到远程
    ```

12. 直接发布
  
    ```bash
    ### 发布测试环境
    lerna publish from-git --registry=test-registry --no-push --no-git-tag-version
    
    ### 发布正式环境
    lerna publish from-git --registry=prod-registry
    ```

## 5. 常用命令

- `lerna init`
  
  1. 创建lerna.json
  2. 如果lerna依赖不存在的话会将lerna 写入package.json.devDependency中
  3. `--independent`参数， 简写`-i`, 使用**Independent**模式管理项目。 lerna.json.version字段为independent

- `lerna create`
  
  1. 创建一个lerna管理的包。 ```lerna create packagName location```
  2. 如果创建时**scope**包，需要带上-**-access=public**
  3. 具体信息查看`lerna create --help`

- `lerna add`
  
  1. 添加依赖
  2. 重要参数**--dev** 将依赖写入devDependencies; **--peer** -> peerDenpendencies; **--registry** 设置仓库源

- `lerna list`
  
  1. 查看当前项目中的package
  2. `lerna ls -al`, `lerna ls --loglevel silent --json `

- `lerna changed/diff`
  
  1. `lerna diff [package-name]`  其实跑的命令就是`git diff`
  2. `lerna changed` 显示的是修改了的包的名称， 可以通过**--ignore-changes**参数来过滤变更

- `lerna run`
  
  1. `lerna run <script> -- [..args]` 执行所有包中的script的命令， 可以通过**--scope**参数来过滤
  2. 重要参数： `--stream` 流式输出log， 通过包名和颜色区分； `--parallel` 并行执行。

- `lerna exec`
  
  1. 在匹配的包中执行任意命令 `lerna exec --scope my-component -- ls -la`
  2. 参数请参考[filter flags](https://www.npmjs.com/package/@lerna/filter-options) 和 [exec 命令信息](https://github.com/lerna/lerna/tree/master/commands/exec)

- `lerna bootstrap`
  
  1. 链接依赖， 由于我们使用的是yarn workspaces来管理，可以直接通过yarn命令来代替
  2. lerna bootstrap --npm-client yarn --use-workspaces

- `lerna version`
  
  1. 参数请参考[filter flags](https://www.npmjs.com/package/@lerna/filter-options) 和 [version命令信息](https://github.com/lerna/lerna/tree/master/commands/version#readme)

- `lerna publish`
  
  1. 参数请参考[filter flags](https://www.npmjs.com/package/@lerna/filter-options) 和 [publish 命令信息](https://github.com/lerna/lerna/tree/master/commands/publish#readme)

## 6. 参考链接

- [lerna](https://github.com/lerna/lerna)
- [rush](https://rushjs.io/)
- [bolt](https://github.com/boltpkg/bolt)
- [Advantages of monorepos](https://danluu.com/monorepo/)
- [conventionalcommits](https://www.conventionalcommits.org/zh-hans/v1.0.0-beta.4/)
- [基于lerna和yarn workspace的monorepo工作流](https://zhuanlan.zhihu.com/p/71385053)
- [building-large-scale-react-applications-in-a-monorepo](https://medium.com/@luisvieira_gmr/building-large-scale-react-applications-in-a-monorepo-91cd4637c131)