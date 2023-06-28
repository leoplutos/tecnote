Option Explicit

    '定义ssh连接信息
    Dim hostName: hostName = "1.2.3.4"
    Dim portNo: portNo = "22"
    Dim userName: userName = "user"
    Dim passWord: passWord = "123456"
    '定义VSCode
    'Dim vscodePath: vscodePath = """D:\Tools\WorkTool\Text\VSCode-win32-x64-1.78.2\Code.exe"""
    '是否使用自定义bashrc
    Dim personalBashrc: personalBashrc = True
    Dim personalBashrcPath: personalBashrcPath = "/lch/workspace/bashrc/.bashrc-personal"

    'ssh连接字符串（ssh -t user@hostip -p port）
    Dim sshConnnectStr: sshConnnectStr = "ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -t " & userName & "@" & hostName & " -p " & portNo
    '使用自定义bashrc字符串（"/bin/bash --rcfile rcfile"）
    Dim personalBashrcStr: personalBashrcStr = Chr(34) & "/bin/bash --rcfile " & personalBashrcPath & Chr(34)

    '创建WshShell对象
    Dim runCmd
    Dim wshShell
    Set wshShell = WScript.CreateObject ("WScript.Shell")
    '打开最后一个打开的VSCode，[-r]参数
    'wshShell.run vscodePath & " -r"
    'WScript.Sleep 3000
    '拆分终端终端
    wshShell.SendKeys("{F1}")
    WScript.Sleep 500
    wshShell.SendKeys("workbench.action.terminal.split")
    WScript.Sleep 500
    wshShell.SendKeys("{Enter}")
    '发送Ctrl+`  (Ctrl : ^  Shift : +  Alt : %)
    'wshShell.SendKeys("^`")
    WScript.Sleep 1000
    '开始ssh连接
    runCmd = sshConnnectStr
    If personalBashrc = True Then
        runCmd = runCmd & " " & personalBashrcStr
    End if
    wshShell.SendKeys(runCmd)
    wshShell.SendKeys("{Enter}")
    WScript.Sleep 3000
    wshShell.SendKeys(passWord)
    wshShell.SendKeys("{Enter}")

    Set wshShell = Nothing
