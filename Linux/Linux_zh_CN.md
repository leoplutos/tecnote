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

### 5.静态库（.a）操作
添加.o文件
```bash
ar r lib.a obj.o
```
删除.o文件
```bash
ar d lib.a obj.o
```
确认静态库.a
```bash
ar t lib.a
```

### 6.确认端口
```bash
netstat -tulpn
```

### 7.Shell调试Debug
在sh第一行加上
```console
#!/bin/sh -xv
```

### 8.复制文件
```bash
cp -afp fromfile tofile(topath)
```

### 9.移动文件
```bash
mv fromfile tofile(topath)
```

### 10.取得当前路径
```bash
current_path=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )
echo $current_path
```

### 11.查找命令绝对路径
```bash
which ll
```

### 12.终端输出颜色
1：粗体  
31：红色  
33：黄色  
0：重置
```bash
echo -e "\e[1;31m发生错误。\e[0m提示：参数错误。"
```
