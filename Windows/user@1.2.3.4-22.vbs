Option Explicit

    '定义ssh连接信息
    Dim hostName: hostName = "1.2.3.4"
    Dim portNo: portNo = "22"
    Dim userName: userName = "user"
    Dim passWord: passWord = "123456"
    'shellType=0 : 使用 cmd
    'shellType=1 : 使用 powershell
    'shellType=2 : 使用 mintty
    'shellType=3 : 使用 git-bash
    Dim shellType: shellType = 2
    Dim minttyPath: minttyPath = """D:\Tools\WorkTool\Team\Git\usr\bin\mintty.exe"""
    Dim gitbashPath: gitbashPath = """D:\Tools\WorkTool\Team\Git\git-bash.exe"""
    '是否使用自定义bashrc
    Dim personalBashrc: personalBashrc = True
    Dim personalBashrcPath: personalBashrcPath = "/lch/workspace/bashrc/.bashrc-personal"

    'ssh连接字符串（ssh -t user@hostip -p port）
    Dim sshConnnectStr: sshConnnectStr = "ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oHostKeyAlgorithms=+ssh-dss -t " & userName & "@" & hostName & " -p " & portNo
    '使用自定义bashrc字符串（"/bin/bash --rcfile rcfile"）
    Dim personalBashrcStr: personalBashrcStr = Chr(34) & "/bin/bash --rcfile " & personalBashrcPath & Chr(34)

    '创建WshShell对象并开始终端外壳
    Dim wshShell
    Set wshShell = WScript.CreateObject ("WScript.Shell")
    '[关闭日语IME输入模式] - 发行2个\，再发行2个Backspace
    wshShell.SendKeys("\\{BS 2}")
    Dim runCmd
    If shellType = 0 Then
        'cmd外壳
        '运行命令为：cmd.exe /k chcp 65001 && ssh -t user@hostip -p port "/bin/bash --rcfile rcfile"
        runCmd = "cmd.exe /k chcp 65001 && " & sshConnnectStr
        If personalBashrc = True Then
            runCmd = runCmd & " " & personalBashrcStr
        End if
        'MsgBox runCmd
    ElseIf shellType = 1 Then
        'powershell外壳
        '运行命令为：powershell.exe -ExecutionPolicy RemoteSigned -noexit -Command chcp 65001 ; ssh -t user@hostip -p port "/bin/bash --rcfile rcfile"
        runCmd = "powershell.exe -ExecutionPolicy RemoteSigned -noexit -Command chcp 65001 ; " & sshConnnectStr
        If personalBashrc = True Then
            runCmd = runCmd & " " & personalBashrcStr
        End if
        'MsgBox runCmd
    ElseIf shellType = 2 Then
        'mintty外壳
        '运行命令为：mintty.exe /usr/bin/ssh -t user@hostip -p port "/bin/bash --rcfile rcfile"
        runCmd = minttyPath & " /usr/bin/" & sshConnnectStr
        If personalBashrc = True Then
            runCmd = runCmd & " " & personalBashrcStr
        End if
        'MsgBox runCmd
    ElseIf shellType = 3 Then
        'git-bash外壳
        '运行命令为：git-bash.exe -c 'ssh -t user@hostip -p port "/bin/bash --rcfile rcfile"; exec bash --login -i'
        runCmd = gitbashPath & " -c " & Chr(39) & sshConnnectStr
        If personalBashrc = True Then
            runCmd = runCmd & " " & personalBashrcStr
        End if
        runCmd = runCmd & "; exec bash --login -i" & Chr(39)
        'MsgBox runCmd
    Else
        MsgBox "Unknowned shellType. Please check line 14.", 16, "ERROR"
    End if
    wshShell.run runCmd
    WScript.Sleep 3000
    wshShell.SendKeys(passWord)
    wshShell.SendKeys("{Enter}")

    Set wshShell = Nothing
