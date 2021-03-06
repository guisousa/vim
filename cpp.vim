syn keyword cppCustomQtTypes   QList QString QVector QMap QStringList QStack
syn keyword cppCustomQtDebug   qDebug
syn keyword cppCustomQtRepeat  foreach
syn keyword cppCustomQtKeyword  qDeleteAll
syn match cppCustomQtUnderlined "\(const\|static\|dynamic\|reinterpret\)_cast"

syn match   cppCustomOp           "\(+\|-\|\*\|\/\(\/\|\*\)\@!\||\|?\|:\|=\|&\|!\|>\|<\)" contains=cppCustomScope
syn match   cppCustomOp2          "\((\|)\|\.\|->\|,\)" contains=cppCustomScope

syn match   cppCustomParen        "?=(" contains=cParen,cCppParen
syn match   cppCustomFunc         "\w\+\s*(\@=" contains=cppCustomParen
syn match   cppCustomScope        "::"
syn match   cppCustomClass        "\w\+\s*::" contains=cppCustomScope
syn match   cppCustomClassFunc    "\(::\)\@<=\~*\w\+\s*(\@=" contains=cppCustomScope

syn match   cppCustomStlNamespace "std::" contains=cppCustomScope

syn match   cppCustomGlobal       "m_\w\+"

"hi def link cppCustomFunc       Function
hi def link cppCustomClassFunc  Function
hi def link cppCustomQtTypes    Type
hi def link cppCustomQtRepeat   Repeat
hi def link cppCustomQtKeyword   Keyword
hi def link cppCustomQtUnderlined   Underlined

" Custom syntax definitions
hi def link cppCustomClass         CppClassNamespace
hi def link cppCustomStlNamespace  CppStlNamespace
hi def link cppCustomQtDebug    CppQtDebug
hi def link cppCustomOp    CppOp
hi def link cppCustomOp2    CppOp2
hi def link cppCustomGlobal CppGlobal
hi CppStlNamespace   ctermfg=blue
hi CppQtDebug        ctermfg=red cterm=standout
hi CppGlobal         ctermfg=250
hi CppOp             ctermfg=178
hi CppOp2            ctermfg=241
hi CppClassNamespace ctermfg=99

