Option Explicit

Sub Start_Click
    MsgBox "Job Start!!!"
    '选择工作Sheet
    Sheets("Work").Activate
    '最后的行
    Dim lastRow As Long
    lastRow = ActiveSheet.UsedRange.Rows.Count
    '最后的列
    Dim lastCol As Long
    lastCol = ActiveSheet.UsedRange.Columns.Count

    'D列的背景颜色重置
    Columns("D:D").Select
    With Selection.Interior
        .Pattern = xlNone
        .TintAndShade = 0
        .PatternTintAndShade = 0
    End With

    '循环每行，为A-D列设置函数
    Dim myRange As Range
    Dim i As Long
    For i = 2 To lastRow
        'A列
        Set myRange = Range("A" & & i)
        myRange.Formula = "=LEN(E" & i & ")"
        'B列
        Set myRange = Range("B" & & i)
        myRange.Formula = "=RIGHT(E" & i & ",1)"
        'C列
        Set myRange = Range("C" & & i)
        myRange.Formula = "=RIGHT(E" & i & ",3)"
        'D列
        Set myRange = Range("D" & & i)
        myRange.Formula = "=LEFT(E" & i & ",3)"
    Next

    '设定字体和文字大小
    With WorkSheet("Work").Range("A2:D" & lastRow)
        .Font.Name = "Arial"
        .Font.Size = 10
        .Font.Color = RGB(0, 0, 204)
        .Interior.Color = RGB(255, 255, 0)
    End With

    '排序
    '第一优先：E列，升序
    '第二优先：G列，升序
    Range("A2:I" & lastRow).Sort key1:=Range("E1"), order1:=xlAscending, key2:=Range("G1"), order2:=xlAscending, Header:=xlNo


    '过滤器
    Set myRange = Range("A1:DB" & lastRow)

    'A列：选择6或者10
    myRange.AutoFilter Field:=1, Criteria1:="=6", Operator:=xlOr, Cirteria2:="=10"

    'B列：数字以外
    Dim dict
    Set dict = CreateObject("Scripting.Dictionary")
    Dim arr
    arr = Application.Transpose(Range("B2:B" & lastRow).Value)
    '删除B列的重复数据
    For i = LBound(arr) To UBound(arr)
        If arr(i) <> "" Then
            dict(arr(i)) = ""
        End If
    Next
    '从Sheet[Master]取得除外内容
    '内容为数字
    For i = 2 To 11
        If dict.Exists(WorkSheet("Master").Range("A" & i).Value) = True Then
            dict.Remove (WorkSheet("Master").Range("A" & i).Value)
        End If
    Next
    Dim newArr
    newArr = dict.keys
    myRange.AutoFilter Field:=2, Criteria1:=newArr, Operator:=xlFilterValues

    'C列：不以_开头
    Set dict = CreateObject("Scripting.Dictionary")
    arr = Application.Transpose(Range("C2:C" & lastRow).Value)
    'C列除外以_开头的内容
    For i = LBound(arr) To UBound(arr)
        Dim targetStr As String
        targetStr = arr(i)
        If arr(i) <> "" And Not (StartsWith(targetStr, "_")) Then
            dict(arr(i)) = ""
        End If
    Next
    newArr = dict.keys
    myRange.AutoFilter Field:=3, Criteria1:=newArr, Operator:=xlFilterValues

    'D列：AAA和BBB
    myRange.AutoFilter Field:=4, Criteria1:=Array("AAA", "BBB"), Operator:=xlFilterValues

    'D列：过滤后的数据变成青色底色
    With myRange
        With .Columns(4).Interior
            .Pattern = xlSolid
            .PatternColorIndex = xlAutomatic
            .ThemeColor = xlThemeColorAccent5
            .TintAndShade = 0.799981688894314
            .PatternTintAndShade = 0
        End With
    End With

    '解除过滤
    ActiveSheet.AutoFilterMode = False

    '取得系统日期
    Dim dtToday As String
    dtToday = Format(Date, "yyyymmdd")
    'Debug.Print dtToday
    '保存文件对话框
    Application.GetSaveAsFilename InitialFilename:=dtToday & ".xls", FileFilter:="Excel97-2003,*.xls,Excel,*.xlsx,ExcelMacro,*.xlsm", FilterIndex=1

    '打开网页
    Dim sURL As String
    sURL = Worksheet("master").Range("F2").Value
    CreateObject("WScript.Shell").Run "msedge.exe -url " & sURL

    '打开Oulook，编辑邮件发信
    Dim objOutlook As Outlook.Application
    Dim objMail As Outlook.MailItem
    Set objOutlook = New Outlook.Application
    Set objMail = objOutlook.CreateItem(olMailItem)
    '表示发信画面
    With objMail
        .Subject = Worksheets("master").Range("B2").Value
        .To = Worksheets("master").Range("C2").Value
        .Cc = Worksheets("master").Range("D2").Value
        .Body = Worksheets("master").Range("E2").Value
        .BodyFormat = olFormatPlain
    End With

    MsgBox "Job End Sucess!!!"

End Sub
