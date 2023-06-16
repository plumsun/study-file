# Git

### 1.常用命令



启动工作区（start a working area）

```bash
# 将存储库克隆到新目录中 Clone a repository into a new directory 
git clone            
# 创建一个空的 Git 存储库或重新初始化一个现有的存储库 Create an empty Git repository or reinitialize an existing one
git init
```



处理当前更改（work on the current change）

```shell
# 将文件内容添加到索引 Add file contents to the index
git add
git add . # 添加当前项目所有新增，修改记录到缓存区
git add -A # 添加当前项目所有操作记录到缓存区（增删改）
# 移动或重命名文件、目录或符号链接 Move or rename a file, a directory, or a symlink
git mv   
# 恢复工作区文件 Restore working tree files
git restore       
# 从工作区和索引中删除文件 Remove files from the working tree and from the index
git rm  
# 初始化和修改稀疏签出 Initialize and modify the sparse-checkout
git sparse-checkout   
```



检查历史和状态 （examine the history and state） 

```shell
# 使用二叉搜索查找引入错误的提交 Use binary search to find the commit that introduced a bug
git bisect       
# 显示提交、提交和工作区等之间的更改 Show changes between commits, commit and working tree, etc
git diff      
# 打印与正则匹配的行 Print lines matching a pattern
git grep  
# 查看提交日志 Show commit logs
git log
# 显示各种类型的对象 Show various types of objects
git show         
# 显示工作区状态 Show the working tree status
git status    
```



成长、标记和调整您的共同历史（grow, mark and tweak your common history）

```shell
# 列出、创建或删除分支 List, create, or delete branches
git branch
# 记录对存储库的更改,提交记录 Record changes to the repository
git commit
# 将两个或多个开发历史记录连接在一起 Join two or more development histories together
git merge
# 在另一个基本提示之上重新应用提交 Reapply commits on top of another base tip
git rebase
# 将当前 HEAD 重置为指定状态 Reset current HEAD to the specified state
git reset
git reset --hard ab92e4a5 # 将当前工作区记录回退到指定版本
# 切换分支 Switch branches
git switch
# 创建、列出、删除或验证标签对象 Create, list, delete or verify a tag object signed with GPG
git tag
```



合作 （collaborate）

```shell
# 从另一个存储库下载对象和引用 Download objects and refs from another repository
git fetch
# 从另一个存储库或本地分支获取并与之集成 Fetch from and integrate with another repository or a local branch
git pull
# 更新远程引用以及关联的对象 Update remote refs along with associated objects
git push
git push origin dev --force # 强制提交当前分支
```





```shell
# 查看git配置
git config -l
# 配置本地仓库所属用户的用户名
git config user.name 'Lee'
# 配置本地仓库所属用户邮箱
git config user.email '12345@qq.com'
```

