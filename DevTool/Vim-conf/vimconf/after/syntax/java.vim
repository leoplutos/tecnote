scriptencoding utf-8
"after/syntax/java.vim

"Java
syn match javaCustomOperator "[-+&|<>=!\/~.,;:*%&^?()\[\]{}]"
syn match javaCustomParen "?=(" contains=javaParen
syn match javaCustomFunc "\.\s*\w\+\s*(\@=" contains=javaCustomOperator,javaCustomParen
syn match javaCustomComment "\/\/.*$"
syn region javaFuncDef start=+^\s\+\(\(public\|protected\|private\|static\|abstract\|final\|native\|synchronized\)\s\+\)*\(\(void\|boolean\|char\|byte\|short\|int\|long\|float\|double\|\([A-Za-z_][A-Za-z0-9_$]*\.\)*[A-Z][A-Za-z0-9_$]*\)\(<[^>]*>\)\=\(\[\]\)*\s\+[a-z][A-Za-z0-9_$]*\|[A-Z][A-Za-z0-9_$]*\)\s*\ze(+ end=+\ze(+ contains=javaScopeDecl,javaType,javaStorageClass,javaComment,javaLineComment,@javaClasses
syn region javaCustomComment start="\/\*" end="\*\/"
hi clear javaCustomOperator
hi link javaCustomFunc Function
hi link javaFuncDef Function
hi link javaCustomComment Comment
hi link javaX_JavaLang Structure
hi link javaC_JavaLang Structure
hi link javaR_JavaLang Structure
hi link javaClassDecl Structure
hi link javaAnnotation Annotation
