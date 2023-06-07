#NoTrayIcon
#singleinstance force
#NoEnv
SetWorkingDir %A_ScriptDir%
SendMode Input

IniRead, X, OCRsettings.ini, Settings, X
IniRead, Y, OCRsettings.ini, Settings, Y
IniRead, Width, OCRsettings.ini, Settings, Width
IniRead, Height, OCRsettings.ini, Settings, Height
IniRead, TextRead, OCRsettings.ini, Settings, TextRead

Gui, +AlwaysOnTop +ToolWindow
Gui, Add, GroupBox, x22 y19 w340 h290 ,
Gui, Add, Edit, x112 y89 w60 h20 vx , %x%
Gui, Add, Edit, x112 y129 w60 h20 vy , %y%
Gui, Add, Edit, x112 y169 w60 h20 vWidth , %Width%
Gui, Add, Edit, x112 y209 w60 h20 vHeight , %Height%
Gui, Add, Text, x32 y89 w70 h20 , X
Gui, Add, Text, x32 y129 w70 h20 , Y
Gui, Add, Text, x32 y169 w70 h20 , Width
Gui, Add, Text, x32 y209 w70 h20 , Height
Gui, Add, Edit, x112 y249 w110 h20 vTextRead , %TextRead%
Gui, Add, Text, x32 y249 w70 h20 , TextRead
Gui, Add, Button, x242 y239 w100 h30 gDoStart , Start
Gui, Add, Button, x242 y199 w100 h30 gDoStop , Stop
Gui, Add, Button, x242 y159 w100 h30 gDoExit , Exit
Gui, Add, Text, x32 y49 w70 h20 +Left, Parameter
Gui, Add, Text, x112 y49 w60 h20 +Left, Value
; Generated using SmartGUI Creator for SciTE
Gui, Add, Text, x282 y319 w260 h20 +Left, Press F12 to stop
Gui, Show, w381 h341, OCR Clicker
return

DoExit:
StringKill := A_ScriptDir . "\OCRRegion.ahk kill"
Run, %StringKill%, %A_ScriptDir%, Hide, ocrAHKPID
GuiClose:
ExitApp


DoStart:
	Gui, Submit, NoHide
	IniWrite, %X%, OCRsettings.ini, Settings, X
	IniWrite, %Y%, OCRsettings.ini, Settings, Y
	IniWrite, %Width%, OCRsettings.ini, Settings, Width
	IniWrite, %Height%, OCRsettings.ini, Settings, Height
	IniWrite, %TextRead%, OCRsettings.ini, Settings, TextRead
	StringRun := A_ScriptDir . "\OCRRegion.ahk " . "" X "" . " " . "" Y "" . " " . "" Width "" . " " . "" Height "" . " " . """" . "" TextRead "" . """"
	;textRead can be multiple so it has quadruple quotes to include quotes and double quotes to contain spaces	
	Run, %StringRun%, %A_ScriptDir%, Hide, ocrAHKPID
return

DoStop:
	StringKill := A_ScriptDir . "\OCRRegion.ahk kill"
	Run, %StringKill%, %A_ScriptDir%, Hide, ocrAHKPID
return

