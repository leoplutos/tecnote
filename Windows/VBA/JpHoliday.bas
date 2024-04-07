Option Explicit

Sub getPublicHolidayList()

    '祝日一覧を読み込むシート名
    Const SHEET_PUBLIC_HOLIDAY As String = "祝日一覧"
    '取得したい表を持つURL(今年の祝日一覧)
    Const TARGET_URL As String = "https://www8.cao.go.jp/chosei/shukujitsu/gaiyou.html"

    Dim sheet As Worksheet
    Dim sheetPublicHoliday As Worksheet

    '------------------------------------------------
    '既にシート「祝日一覧」が存在する場合は削除
    '------------------------------------------------
    For Each sheet In ThisWorkbook.Worksheets
        If sheet.Name = SHEET_PUBLIC_HOLIDAY Then
            '確認メッセージを非表示
            Application.DisplayAlerts = False
            'シート削除
            Worksheets(SHEET_PUBLIC_HOLIDAY).Delete
            '確認メッセージを表示
            Application.DisplayAlerts = True
        End If
    Next

    '------------------------------------------------
    'シート「祝日一覧」を新規作成
    '------------------------------------------------
    Set sheetPublicHoliday = Worksheets.Add(After:=Worksheets(Worksheets.Count))
    sheetPublicHoliday.Name = SHEET_PUBLIC_HOLIDAY

    '------------------------------------------------
    'シート「祝日一覧」にWebサイト上の表(今年の祝日一覧)を読み込んで表を作成
    '------------------------------------------------
    With Worksheets(SHEET_PUBLIC_HOLIDAY).QueryTables.Add(Connection:="URL;" + TARGET_URL, _
                                          Destination:=Range("B2"))
        '列幅を元の表と同じにする
        .AdjustColumnWidth = True
        '書式は設定しない
        .WebFormatting = xlWebFormattingNone
        '指定したテーブルのみ取得する
        .WebSelectionType = xlSpecifiedTables
        '2つ目の表(今年の祝日一覧)を取得する
        .WebTables = 2
        'データ取得を実行する
        .Refresh BackgroundQuery:=False
        '作成される「クエリと接続」を削除
        .Delete
    End With

    '------------------------------------------------
    '表をテーブル化
    '------------------------------------------------
    With Worksheets(SHEET_PUBLIC_HOLIDAY)
        '対象シートをアクティブにする
        .Activate
        'テーブル化したい範囲の一番左上を選択状態にする
        .Range("B2").Select
        'テーブル化する(名前定義も含む)
        .ListObjects.Add.Name = "祝日一覧テーブル"
    End With

End Sub

'####################################
'日付が土日祝日かどうか判別する
'------------------------------------
'引数:day 土日祝日か確認したい日付
'    :dic 祝日が格納されたDictionaryオブジェクト
'####################################
Public Function IsHoliday(ByVal day As Date, ByVal dic As Object) As Boolean
    Dim strDay As String
    strDay = Format(day, "yyyy/m/d")
    If dic.Exists(strDay) = True Or Weekday(day) = 1 Or Weekday(day) = 7 Then
        IsHoliday = True
    Else
        IsHoliday = False
    End If
End Function
