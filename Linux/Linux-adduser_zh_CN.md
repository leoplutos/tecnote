# Linux添加账户

#### 1.做成文件夹
```bash
mkdir /lch
```

#### 2.做成Group
```bash
groupadd -f lchgroup
```

#### 3.做成用户
```bash
useradd -g lchgroup lchuser
```

#### 4.设定密码
Cent OS
```bash
echo "lchpwd" | passwd --stdin lchuser
```
ubuntu
```bash
echo "lchuser:lchpwd" | chpasswd
```

#### 5.加入group
```bash
usermod  -aG lchgroup lchuser
```

#### 6.把lch文件夹权所有限给lchuser:lchgroup
```bash
chown -hR lchuser:lchgroup /lch
```
接下来可以用lchuser用户，在lch路径下进行开发工作了