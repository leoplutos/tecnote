# Git

## 一.基础设置

### 1.设定用户名和邮箱
```git
git config --global user.name "yourname"
git config --global user.email "your@email.com"
```

### 2.设定用编码UTF-8
```git
git config --global gui.encoding utf-8
```

### 3.打开所有终端颜色
```git
git config --global color.ui true
```

### 4.设置取消git中的sslverify
```git
git config --system http.sslverify false
```

### 5.设置取消HTTP代理
```git
git config --global --unset http.proxy
git config --global --unset https.proxy
```

## 二.代码管理命令

### 6.Clone仓库  
```git
git clone -b [分支名] [URL] [本地路径]
git clone -b master https://github.com/foo/bar.git /D/WorkSpace/bar
```

### 7.打开默认GUI画面  
笔者个人习惯在GUI里面进行add/commit/push/pull操作  
※在GUI中pull操作需要自己添加一下
```git
git gui
```

### 8.查看状态  
```git
git status
```

### 9.取消本地修改从仓库重新取文件  
笔者个人习惯为，比如本地的a.java想从仓库重新取。先把a.java重命名为a.java_bak，然后运行以下代码
```git
git status
git checkout /src/a.java
```

## 三.查看配置文件  

Git中有三层config文件：系统、全局、本地

### 10.查看系统配置
```git
git config --system --list
```

### 11.查看当前用户配置
```git
git config --global --list
```

### 12.查看当前仓库配置
```git
git config --local --list
```
