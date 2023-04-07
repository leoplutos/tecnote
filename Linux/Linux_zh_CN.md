# Linux命令

### 1.生成软链接
```bash
ln [参数][源文件或目录][目标文件或目录]
ln -sf openjdk8.234.12 openjdk8
```

### 2.列出一个程序所需要得动态链接库（so）
```bash
ldd [目标文件]
ldd /bin/ls
```

### 3.查找运行中程序的pid
```bash
ps aux | head -1 && ps aux | grep 程序名
```

### 4.杀掉进程
```bash
kill -9 [pid]
```