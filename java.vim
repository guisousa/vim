syn match cppCustomDebug  "System\.out\.println"
syn match cppCustomOp     "\(+\|-\|\*\|\/\(\/\|\*\)\@!\||\|?\|:\|=\|&\|!\|>\|<\)" contains=cppCustomScope
syn match cppCustomOp2    "\((\|)\|\.\|->\|,\)" contains=cppCustomScope

syn match cppCustomGlobal "m_\w\+"

" Custom syntax definitions
hi def link cppCustomOp     CppOp
hi def link cppCustomOp2    CppOp2
hi def link cppCustomGlobal CppGlobal
hi def link cppCustomDebug  CppDebug
hi CppGlobal ctermfg=250
hi CppOp     ctermfg=178
hi CppOp2    ctermfg=241
hi CppDebug  ctermfg=red cterm=standout
