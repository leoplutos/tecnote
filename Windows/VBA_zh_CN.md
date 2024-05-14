# VBA

## VBA简介

VBA 是 Visual Basic for Application 的缩写，通俗说就是用VB对程序进行控制，使用户可以自行去定义属于自己需求的软件成为可能性。它主要能用来扩展 Windows 的应用程序功能，特别是 Microsoft Office 软件。也可说是一种应用程序视觉化的 Basic 脚本。该语言于 1993 年由微软公司开发，实际上 VBA 是寄生于 VB 应用程序的版本。微软在 1994 年发行的 Excel5.0 版本中，即具备了 VBA 的功能。

#### 谈到VBA是寄生于VB的。那么两者有什么区别呢？

1. VB 设计用于创建标准的应用程序，而 VBA 是使已用的应用程序如 EXCEL 自动化。

2. VB 具有自己的开发环境，而 VBA 必须寄生于已用的应用程序上。

3. 要运行 VBA 开发的应用程序，必须依赖它的父应用程序。

## VBA开发环境

#### 添加开发工具
打开Excel，依次找到 ``文件`` -> ``选项`` -> ``自定义功能区（リボンのユーザ設定）``，在右侧主选项卡下面的选项中，找到 ``开发工具（開発）``，在前面的小框打勾，确定。返回Excel，即可在菜单栏右侧看到有开发工具

也可以在上面的功能区 -> 鼠标右键 -> ``自定义功能区（リボンのユーザ設定）``找到

#### 使用VBE

VBE 即 VBA 的编程环境。通常有两种方式可以进入

- Excel的菜单栏 -> ``开发工具`` -> ``Visual Basic``
- 快捷键：``Alt + F11``

#### 修改Excel文件的扩展名
需要 Excel 扩展名为 ``.xlsm``

## 其他小技巧

#### 宏录制
想知道一个Excel操作的代码的话可以用录制宏的功能来得到代码

#### 添加库
比如添加 ``OutLook`` 库  
在 VBE 中，``工具`` -> ``引用`` -> 选择 ``MicroSoft Outlook 16.0 Object Library``

#### 字符的转义
``""`` 有转义规则  
``"字符串""内容"`` 的结果为 ``字符串"的内容``

## 性能优化

#### 1.关闭画面刷新
在程序开始前加入代码
```vba
'关闭画面刷新
Application.ScreenUpdating = False
'关闭自动计算
'Application.Calculation = xlManual
'关闭事件
Application.EnableEvents = False
```

在程序结束前加入代码
```vba
'启用画面刷新
Application.ScreenUpdating = True
'启用自动计算
'Application.Calculation = xlAutomatic
'启用事件
Application.EnableEvents = True
'重新计算所有内容
Application.CalculateFull
```

#### 2.删除数据的优化
不要使用 ``Delete`` 函数删除行，使用 ``ClearContents`` 函数删除行后 ``Sort`` 排序

```vba
'设定过滤范围
Dim myRange As Range
Set myRange = Range("A1:X" & lastWorkRow)
'过滤为OTH的内容，并删除
myRange.AutoFilter Field:=3, Criteria1:="OTH"
If Cells(Rows.Count, "A").End(xlUp).Row > 1 Then
    'myRange.Offset(1, 0).SpecialCells(xlCellTypeVisible).EntireRow.Delete
    myRange.Offset(1, 0).SpecialCells(xlCellTypeVisible).EntireRow.ClearContents
Else
    '无数据
End If
'解除过滤器
ActiveSheet.AutoFilterMode = False
'Sort排序
Range("A2:" & lastWorkRow).Sort key1:=Range("A1"), order1:=xlAscending, Header:=xlNo
'重新计算最后行
lastWorkRow = Sheets("Work").UsedRange.Rows.Count
```

## Excel-vba 开发使用手册
https://github.com/bluetata/concise-excel-vba

## 一个VBA的示例代码
 - [Sample.bas](./VBA/Sample.bas)

## VBA显示状态条

 - [ProgressBar.bas](./VBA/ProgressBar.bas)

## VBA字符串的StartWith函数和EndWith函数

 - [String_StartsWith_EndsWith.bas](./VBA/String_StartsWith_EndsWith.bas)

## VBA取得日本休日
访问内閣府网站取得

 - [JpHoliday.bas](./VBA/JpHoliday.bas)

#### 一个使用日本休日的例子

取得本月最后一天，向前数两天营业日(如果是假日不算在这两天)

```vba
'制作[祝日一覧]Sheet
getPublicHolidayList
Sheets("祝日一覧").Columns("C:C").NumberFormatLocal = "yyyy/mm/dd;@"
'[祝日一覧]Sheet计算最后一行(因为上面是空行所以+1)
Dim lastJHRow = Sheets("祝日一覧").UsedRange.Rows.Count + 1
'定义祝日词典
Dim holidayDict
Dim i As Long
Dim arr
Set holidayDict = CreateObject("Scripting.Dictionary")
arr = Application.Transpose(Sheets("祝日一覧").Range("C3:C" & lastJHDRow).Value)
For i = LBound(arr) To UBound(arr)
    If arr(i) <> "" Then
        holidayDict(arr(i)) = ""
    End If
Next
'For i = 0 To holidayDict.Count - 1
'    Debug.Print holidayDict.Keys()(i), holidayDict.Items()(i)
'Next

'今天
Dim dtToday As String
dtTody = Format(Date, "yyyy.mm")

Dim minusDay as Integer
minusDay = 0
Dim dtDate As Date
'本月的最后一天
dtDate = DateSerial(Year(Date), Month(Date) + 1, 0)
Do While True
    If minusDay = 2 Then
        Exit Do
    End If
    If isHoliDay(dtDate, holidyDict) = True Then
        '向前移动一天
        dtDate = DateAdd("d", -1, dtDate)
    Else
        '向前移动一天，并且给minusDay加一
        dtDate = DateAdd("d", -1, dtDate)
        minusDay = minusDay + 1
    End If
Loop
```

## 打开一个Excel文件，编辑后另存

```vba
'当前路径
Dim workPath As String
workPath = ThisWorkBook.Path
'打开当前路径下的[abc.xlsx]
Dim tExcel As Object
Dim tObj As Object
Set tExcel = CreateObject("Excel.Application")
Set tObj = tExcel.Application.Workbooks.Open(Filename:=workPath & "\abc.xlsx")
'设定显示Excel
'tExcel.Visible = True

'编辑打开的文件后另存为[def.xlsx]
Dim saveNm As String
saveNm = workPath & "\def.xlsx"
'覆盖保存
tExcel.Application.DisplayAlerts = False
tObj.SaveAs Filename:=saveNm
tObj.Close
Set tObj = Nothing
tExcel.Visible = False
Set tExcel = Nothing
```

## 为了提升性能，使用数组循环表格

```vba
'最终行
Dim lastMstRow As Long
lastMstRow = Sheets("test").UsedRange.Row.Count
Dim lastMstCol As Long
lastMstCol = Sheets("test").UsedRange.Row.Count

'从表格转存到数组
Dim i As Long
Dim mstArray As Variant
mstArray = Range(Cells(2, 1), Cells(lastMstRow, lastMstCol))
'循环
'For i = LBound(mstArray) To UBound(mstArray)
'    Debug.Print mstArray(i, 1), mstArray(i, 2), mstArray(i, 3), mstArray(i, 4)
'Next i

'从数组转存到表格
Range(Cells(2, 1), Cells(lastMstRow, lastMstCol)) = mstArray
```

#### 打开其他Excel，取得数据的例子

```vba
Dim workPath As String
workPath = ThisWorkBook.Path

Dim tExcel As Object
Dim tObj As Object
Dim tWorkSheet As Object
Set tExcel = CreateObject("Excel.Application")
Set tObj = tExcel.Application.WorkBooks.Open(Filename:=workPath & "\name.xlsx")
Set tWorkSheet = tObj.Sheets("mysheet")

'最终行
Dim lastMstRow As Long
lastMstRow = tWorkSheet.UsedRange.Row.Count

'[mysheet]里面B列的内容取出
Dim i As Long
Dim mstArray As Variant
'Cells的参数为行，列，所以下面是从2行2列 到 最大数据行2列
mstArray = tWorkSheet.Range(tWorkSheet.Cells(2, 2), tWorkSheet.Cells(lastMstRow, 2))
'循环打印
For i = LBound(mstArray) To UBound(mstArray)
    Debug.Print mstArray(i, 1)
Next i
```

## 测速
```vba
Dim timerObj As Single
timerObj = Timer
MsgBox ("使用时间" & Round(Timer - timerObj, 1) & "秒")
```

## UTF8文件写入
```vba
Option Explicit

'---- LineSeparatorEnum ---
Public Const adCR = 13
Public Const adCRLF = -1
Public Const adLF = 10
'---- StreamTypeEnum ----
Public Const adTypeBinary = 1
Public Const adTypeText = 2
'---- SaveOptionEnum ----
Public Const adSaveCreateNotExit = 1
Public Const adSaveCreateOverWrite = 2
'---- StreamWriteEnum ----
Public Const adWriteChar = 0
Public Const adWriteLine = 1

Sub Start_Click()
    MsgBox "Job Start!!!"

    '当前文件夹
    Dim workPath As String
    workPath = ThisWorkBook.Path

    '定义写入流
    Dim fwStm As Object
    Set fwStm = CreateObject("ADODB.Stream")
    fwStm.Charset = "UTF-8"
    fwStm.LineSeparator = adLF
    fwStm.Open

    '写入内容
    fwStm.WriteText "utf8中文日本語", adWriteLine
    fwStm.WritrText "ここは２行目です", adWriteLine

    '去掉BOM
    fwStm.Position = 0
    fwStm.Type = adTypeBinary
    fwStm.Position = 3
    '临时用
    Dim byteData() As Byte
    byteData = fwStm.Read
    fwStm.flush
    fwStm.Close
    fwStm.Open
    fwStm.Write byteData
    fwStm.SaveToFile workPath & "\test.txt", adSaveCreateOverWrite

    fwStm.flush
    fwStm.Close
    Set fwStm = Nothing

    MsgBox "Job End Success!!!"
End Sub
```

