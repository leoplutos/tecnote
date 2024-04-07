Option Explicit

Public Function StartsWith(ByVal target_str As String, ByVal search_str As String) As Boolean
'####################################################################
'target_str文字列がsearch_str文字列で始まっているか確認する
'search_strで始まっている場合はTrue
'search_strで始まっていない、もしくはsearch_strがtarget_strの文字数を超える場合はFalseを返す
'####################################################################
    If Len(search_str) > Len(target_str) Then
        Exit Function
    End If
    If Left(target_str, Len(search_str)) = search_str Then
        StartsWith = True
    End If
End Function

Public Function EndsWith(ByVal target_str As String, ByVal search_str As String) As Boolean
'####################################################################
'target_str文字列がsearch_str文字列で終わっているか確認する
'search_strで終わっている場合はTrue
'search_strで終わっていない、もしくはsearch_strがtarget_strの文字数を超える場合はFalseを返す
'####################################################################
    If Len(search_str) > Len(target_str) Then
        Exit Function
    End If

    If Right(target_str, Len(search_str)) = search_str Then
        EndsWith = True
    End If
End Function
