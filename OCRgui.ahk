;#NoTrayIcon
#SingleInstance Off
#NoEnv
#include OCRRegion.ahk
#include draw.ahk

SetWorkingDir %A_ScriptDir%
SendMode Input
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen

Gosub, IniReader
Gosub, GuiLayout

OutputVarXX =  0
OutputVarYY = 0
First := 1
Show := 0
FocusView:=0
toggle := false
Loop{	
    MouseGetPos , OutputVarXXX, OutputVarYYY
	if (OutputVarXXX != OutputVarXX && OutputVarYYY!= OutputVarYY  )
	{
		OutputVarXX := OutputVarXXX
		OutputVarYY := OutputVarYYY
		Gui, OCRClicker:Default
		GuiControl,, Xcurr, %OutputVarXX%
		GuiControl,, Ycurr, %OutputVarYY%
	}
}

DoExit:
	StringKill := A_ScriptDir . "\OCRRegion.ahk kill"
	Run, %StringKill%, %A_ScriptDir%, Hide, ocrAHKPID 
	ExitApp
return

DoReload:
	StringKill := A_ScriptDir . "\OCRRegion.ahk kill"
	Run, %StringKill%, %A_ScriptDir%, Hide, ocrAHKPID	
	Reload
return


DoStart:
	FocusView := 1
	Show := 1
	Gui, OCRClicker:Submit, NoHide
	Gosub, IniWriter
	SetTimer, OCRRegionLabel, 500
return

DoStop:
	SetTimer, OCRRegionLabel, Off
	CancelSquare()
	ToolTip
return


IniReader:
	IniRead, X, OCRsettings.ini, Settings, X
	IniRead, Y, OCRsettings.ini, Settings, Y
	IniRead, Width, OCRsettings.ini, Settings, Width
	IniRead, Height, OCRsettings.ini, Settings, Height
	IniRead, TextRead, OCRsettings.ini, Settings, TextRead
return

IniWriter:
	IniWrite, %X%, OCRsettings.ini, Settings, X
	IniWrite, %Y%, OCRsettings.ini, Settings, Y
	IniWrite, %Width%, OCRsettings.ini, Settings, Width
	IniWrite, %Height%, OCRsettings.ini, Settings, Height
	IniWrite, %TextRead%, OCRsettings.ini, Settings, TextRead
return

GuiLayout:
	Gui, OCRClicker:+AlwaysOnTop +ToolWindow
	Gui, OCRClicker:Add, GroupBox, x22 y19 w340 h290 ,
	Gui, OCRClicker:Add, Edit, x112 y89 w60 h20 vx , %x%
	Gui, OCRClicker:Add, Edit, x112 y129 w60 h20 vy , %y%
	Gui, OCRClicker:Add, Edit, x112 y169 w60 h20 vWidth , %width%
	Gui, OCRClicker:Add, Edit, x112 y209 w60 h20 vHeight , %height%
	Gui, OCRClicker:Add, Text, x32 y89 w70 h20, X
	Gui, OCRClicker:Add, Text, x32 y129 w70 h20, Y
	Gui, OCRClicker:Add, Text, x193 y92 w40 h20 vXcurr , X
	Gui, OCRClicker:Add, Text, x193 y132 w40 h20 vYcurr , Y
	Gui, OCRClicker:Add, Text, x32 y171 w70 h20 , Width
	Gui, OCRClicker:Add, Text, x32 y211 w70 h20 , Height
	Gui, OCRClicker:Add, Edit, x112 y249 w110 h20 vTextRead , %TextRead%
	Gui, OCRClicker:Add, Text, x32 y249 w70 h20 , TextRead
	Gui, OCRClicker:Add, Button, x242 y239 w100 h30 gDoStart , Start
	Gui, OCRClicker:Add, Button, x242 y199 w100 h30 gDoStop , Stop
	Gui, OCRClicker:Add, Button, x242 y159 w100 h30 gDoReload , Reload
	Gui, OCRClicker:Add, Button, x242 y119 w100 h30 gDoExit , Exit
	Gui, OCRClicker:Add, Button, x242 y79 w100 h30 gDoDraw , Draw
	Gui, OCRClicker:Add, Text, x32 y49 w70 h20 +Left, Parameter
	Gui, OCRClicker:Add, Text, x112 y49 w60 h20 +Left, Value
	Gui, OCRClicker:Add, Text, x282 y318 w260 h20 +Left, Press F11 to stop
	Gui, OCRClicker:Add, Text, x23 y318 w250 h20 +Left vOCRRead, Press Start
	Gui, OCRClicker:Show, w381 h341, OCRClicker
	; Generated using SmartGUI Creator for SciTE
return


OCRRegionLabel:
	OCRRegionFunction(X,Y,Width,Height,TextRead)
return

F11::
	SetTimer, OCRRegionLabel, Off
	CancelSquare()
	ToolTip
return

DoDraw:
	DoDrawFunction()
return