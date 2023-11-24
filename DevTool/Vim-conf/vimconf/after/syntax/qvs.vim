scriptencoding utf-8
"after/syntax/qvs.vim

"关键字中用到了 '-' 字符
setlocal iskeyword+=-

syn keyword qvsStatement     do loop while until script Each elseif Switch Add Buffer Bundle Info concatenate crosstable Generic Hierarchy HierarchyBelongsTo
syn keyword qvsStatement     Image_Size IntervalMatch Replace Sample Semantic Alias Autonumber Binary Declare Derive DIRECT QUERY Directory
syn keyword qvsStatement     drop-field drop-table Execute Force loosen-table Loosen Map Using Merge NullAsNull NullAsValue Qualify
syn keyword qvsStatement     rename-field Rename rename-table Section when unless Sleep Tag Trace Unmap Unqualify Untag FlushLog
syn keyword qvsStatement     ODBC OLEDB CUSTOM LIB CONNECT Disconnect SQL SELECT Group SQLColumns SQLTables SQLTypes Star
syn keyword qvsStatementArgs in step case default only as with capitalization upper lower mixed distinct access application Definition Tags Tagged Parameters Groups
syn keyword qvsStatementArgs from_field inline autogenerate group_by order_by extension all distinctrow top percent having asc desc on is Tables field fields
syn keyword qvsStatementArgs not and or Xor precedes follows like Explicit Implicit DIMENSION MEASURE DETAIL
syn keyword qvsPrefixes      Inner Outer Left Right Full Join Keep
syn keyword qvsRegularcomment comment comment-table
"syn match   qvsRemComment     "^Rem\($\|\s.*$\)"lc=3
syn region qvsRemComment     start=+^Rem+   end=+;+
syn keyword qvsSystemVariables ErrorMode ScriptError ScriptErrorCount ScriptErrorList
syn keyword qvsSystemVariables FirstWeekDay BrokenWeeks ReferenceDay FirstMonthOfYear HidePrefix HideSuffix StripComments Verbatim OpenUrlTimeout CollationLocale
syn keyword qvsSystemVariables NullDisplay NullInterpret NullValue OtherSymbol CreateSearchIndexOnReload Floppy CD QvPath QvRoot QvWorkPath QvWorkRoot WinPath WinRoot
syn keyword qvsSystemVariables NumericalAbbreviation DirectCacheSeconds DirectConnectionMax DirectUnicodeStrings DirectDistinctSupport DirectEnableSubquery SQLSessionPrefix
syn keyword qvsSystemVariables SQLSessionPrefix DirectFieldColumnDelimiter DirectStringQuoteChar DirectIdentifierQuoteStyle DirectIdentifierQuoteChar DirectTableBoxListThreshold
syn keyword qvsSystemVariables DirectTimeFormat DirectDateFormat DirectTimestampFormat
syn region qvsStringDouble   start=+"+    end=+"+    contains=qvsVariable
syn region qvsBracket        start="\["   end="\]"   contains=qvsVariable

hi def link qvsStringDouble String
hi def link qvsBracket String

hi link qvsTableName ThinTitle
hi link qvsStatementArgs Special
hi link qvsPrefixes Debug
hi link qvsRegularcomment Comment
hi link qvsRemComment Comment
hi link qvsVariable Special
hi link qvsSystemVariables Variables
