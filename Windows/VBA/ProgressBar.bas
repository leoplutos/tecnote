Option Explicit

Sub ShowProgress(progressNum As Long, maxNum As Long)
    '''ステータスバーに進捗を表示させる
    '''maxNum:最大値
    '''progressNum:進捗値

    Static staticNum As Long '前回と同じか確認用

    ''progressNum=maxNumとなったら表示を戻す
    If progressNum = maxNum Then
        Application.StatusBar = False
        staticNum = 0
        Exit Sub
    End If

    Dim tmp As Long
    tmp = Int(progressNum / maxNum * 10) 'progressNumを0-10の進捗へ変換

    'tmp=0のときは初期値をｾｯﾄ
    If tmp = 0 Then
        Application.StatusBar = "実行中…" & String(10, "□")
        Exit Sub
    End If

    '前回と同じときはExit
    If tmp = staticNum Then Exit Sub

    staticNum = tmp
    Application.StatusBar = "実行中…" & String(tmp, "■") & String(10 - tmp, "□")
End Sub

Sub Sample()
    Dim i As Long
    For i = 1 To 10000
        'プロシージャの呼び出し
        ShowProgress i, 10000
        Cells(i, 1) = i
    Next
End Sub
