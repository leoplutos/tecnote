scriptencoding utf-8
"syntax/qvs.vim

"内容取自 https://github.com/ChristianNogueira/Qlikview_Vim_Syntax

" Vim syntax file
" Language:    Qlikview
" Maintainer:  Christian Stickel Nogueira
" Last Change: 2016, jun
" Version:     1.0.0
" Description: inicial release
"
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syn case ignore

syn keyword qvsStatement CALL RESIDENT NOCONCATENATE MAPPING WHERE LOAD FROM FOR IF END ELSE STORE DROP NEXT SUB FIRST TO TABLE THEN AND ORDER BY
syn keyword qvsKeyItems SET LET EXIT

syn keyword qvsAggregateFunction sum min max only mode firstsortedvalue
syn keyword qvsAggregateFunction MinString MaxString FirstValue LastValue concat
syn keyword qvsAggregateFunction count NumericCount TextCount NullCount MissingCount
syn keyword qvsAggregateFunction fractile kurtosis correl avg stdev skew median sterr steyx linest_m linest_b linest_r2 linest_sem linest_seb linest_sey linest_df linest_f linest_ssreg linest_ssresid
syn keyword qvsAggregateFunction irr xirr npv xnpv
syn keyword qvsAggregateFunction chi2test_p chi2test_df chi2test_chi2 TTest_t TTest_df TTest_sig TTest_dif TTest_sterr TTest_conf TTest_lower TTest_upper TTestw_t TTestw_df TTestw_sig TTestw_dif
syn keyword qvsAggregateFunction TTestw_sterr TTestw_conf TTestw_lower TTestw_upper TTest1_t TTest1_df TTest1_sig TTest1_dif TTest1_sterr TTest1_conf TTest1_lower TTest1_upper TTest1w_t TTest1w_df
syn keyword qvsAggregateFunction TTest1w_sig TTest1w_dif TTest1w_sterr TTest1w_conf TTest1w_lower TTest1w_upper ZTest_z ZTest_sig ZTest_dif ZTest_sterr ZTest_conf ZTestw_z ZTestw_sig ZTestw_dif
syn keyword qvsAggregateFunction ZTestw_sterr ZTestw_conf

syn keyword qvsGeneralFunction	div mod fmod ceil floor frac round fabs numsum numcount numavg nummin nummax fact combin permut even odd sign bitcount concatenate

syn keyword qvsScriptRangeFunction rangesum rangeavg rangecount rangemin rangemax rangestdev rangeskew rangekurtosis rangefractile rangenumericcount rangetextcount rangenullcount rangemissingcount
syn keyword qvsScriptRangeFunction rangeminstring rangeminstring rangemode rangeonly rangecorrel rangeirr rangenpv rangexirr rangexnpv

syn keyword qvsExpLogFunction exp log log10 sqrt sqr pow

syn keyword qvsTrigonometricFunction cos acos sin asin tan atan atan2 cosh sinh tanh

syn keyword qvsStatisticalFunction chidist chiinv normdist norminv tdist tinv fdist finv

syn keyword qvsFinancialFunction fv nper pmt pv rate BlackAndSchole

syn keyword qvsMathConstants e pi rand true false 

syn keyword qvsCounterFunction RecNo RowNo IterNo autonumber autonumberhash128 autonumberhash256 fieldvaluecount

syn keyword qvsStringFunction ord chr len left right mid index upper lower repeat ltrim rtrim subfield KeepChar PurgeChar capitalize evaluate TextBetween Replace FindOneOf hash128 hash160 hash256
syn keyword qvsStringFunction substringcount applycodepage

syn keyword qvsMapFunction applymap mapsubstring

syn keyword qvsInterRecordFunction exists previous peek FieldValue FieldIndex lookup

"syn keyword qvsConditionalFunction if alt pick match mixmatch wildmatch class 
syn keyword qvsConditionalFunction alt pick match mixmatch wildmatch class 

syn keyword qvsLogicalFuction IsNum IsText IsPartialReload Null IsNull

syn keyword qvsSystemFuction ClientPlatform OSuser QVuser ComputerName ReloadTime GetActiveSheetID GetCurrentField GetFieldSelections GetSelectedCount GetPossibleCount GetExcludedCount
syn keyword qvsSystemFuction GetAlternativeCount GetNotSelectedCount GetRegistryString qlikviewversion MsgBox Input DocumentName DocumentPath DocumentTitle GetObjectField GetExtendedProperty

syn keyword qvsFileFunction Attribute ConnectString filebasename filedir fileextension filename filepath filesize filetime GetFolderPath QvdCreateTime QvdNoOfRecords QvdNoOfFields QvdFieldName
syn keyword qvsFileFunction QvdTableName

syn keyword qvsTableFunction FieldName FieldNumber NoOfFields NoOfRows NoOfTables TableName TableNumber

syn keyword qvsDocumentFuction TableNumber ReportName ReportID ReportNumber NoOfReports

syn keyword qvsDateTimeFunction second minute hour day week month year weekyear weekday now today LocalTime MakeDate MakeWeekDate MakeTime AddMonths YearToDate TimeZone GMT UTC DaylightSaving 
syn keyword qvsDateTimeFunction SetDateYear SetDateYearMonth InYear InYearToDate InQuarter InQuarterToDate InMonth InMonthToDate InMonths InMonthsToDate InWeek InWeekToDate InLunarWeek 
syn keyword qvsDateTimeFunction InLunarWeekToDate InDay InDayToTime YearStart YearName QuarterStart QuarterEnd QuarterName MonthStart MonthEnd MonthName MonthsStart MonthsEnd MonthsName
syn keyword qvsDateTimeFunction WeekStart WeekEnd WeekName LunarweekStart LunarweekEnd LunarWeekName DayStart DayEnd DayName age networkdays firstworkdate lastworkdate ConvertToLocalTime
syn keyword qvsDateTimeFunction DayNumberOfYear DayNumberOfQuarter

syn keyword qvsSystemVariables ThousandSep DecimalSep MoneyThousandSep MoneyDecimalSep MoneyFormat DirectMoneyDecimalSep DirectMoneyFormat TimeFormat DateFormat TimestampFormat MonthNames
syn keyword qvsSystemVariables LongMonthNames DayNames LongDayNames

syn keyword qvsFormatFunction Num Money Date Time Dual Interval timestamp

" Strings and characters
syn region qvsString		start=+'+    end=+'+
syn region qvsVariable		start=+$(+ end=+)+

" Numbers
syn match qvsNumber		"-\=\<\d*\.\=[0-9_]\>"
syn match qvsNumber		'\d\+' contained display
syn match qvsNumber 		'[-+]\d\+' contained display
syn match qvsNumber		'\d\+\.\d*' contained display
syn match qvsNumber		'[-+]\d\+\.\d*' contained display

" Comments
"syn region qvsTableName		start=/^[a-zA-Z_\-1-9]/ end=/:/
"syn region qvsTableName		start=/^[a-zA-Z_\-1-9]/ end=/:/ end=/$/
syn match  qvsTableName		"\w*:$"
syn region qvsComment		start=/\/\// end=/$/ 
syn region qvsMultiComment	start="/\*" end="\*/" contains=qvsMultiComment
syn cluster qvsComment		contains=qvsComment,qvsMultiComment

hi def link qvsComment		Comment
hi def link qvsMultiComment	Comment
hi def link qvsNumber	        Number
hi def link qvsString	        String

hi def link qvsKeyItems	        Keyword
hi def link qvsStatement	Statement
hi def link qvsMathConstants	Statement
hi def link qvsSystemVariables	Statement
hi def link qvsVariable		Include
hi def link qvsTableName	Typedef

hi def link qvsAggregateFunction 	Function
hi def link qvsGeneralFunction		Function
hi def link qvsScriptRangeFunction 	Function
hi def link qvsExpLogFunction		Function
hi def link qvsTrigonometricFunction	Function
hi def link qvsStatisticalFunction	Function
hi def link qvsFinancialFunction	Function
hi def link qvsCounterFunction		Function
hi def link qvsStringFunction		Function
hi def link qvsMapFunction		Function
hi def link qvsInterRecordFunction	Function
hi def link qvsConditionalFunction	Function
hi def link qvsLogicalFuction		Function
hi def link qvsSystemFuction		Function
hi def link qvsFileFunction		Function
hi def link qvsTableFunction		Function
hi def link qvsDocumentFuction		Function
hi def link qvsDateTimeFunction		Function
hi def link qvsFormatFunction		Function
let b:current_syntax = "qvs"
