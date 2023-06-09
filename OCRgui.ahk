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

First := 1
Loop{
		Gosub, UpdateMouseXYIndicator
}

GuiLayout:
	Gui, OCRClicker:+AlwaysOnTop +ToolWindow
	Gui, OCRClicker:Add, CheckBox, x259 y45 w90 h30 gSquareOnLabel vSquareOn, Show Square
	Gui, OCRClicker:Add, GroupBox, x22 y19 w340 h290,
	Gui, OCRClicker:Add, Edit, x112 y89 w60 h20 vX, %x%
	Gui, OCRClicker:Add, Edit, x112 y129 w60 h20 vY, %y%
	Gui, OCRClicker:Add, Edit, x112 y169 w60 h20 vWidth, %width%
	Gui, OCRClicker:Add, Edit, x112 y209 w60 h20 vHeight, %height%
	Gui, OCRClicker:Add, Text, x32 y89 w70 h20, X
	Gui, OCRClicker:Add, Text, x32 y129 w70 h20, Y
	Gui, OCRClicker:Add, Text, x193 y92 w40 h20 vXcurr, X
	Gui, OCRClicker:Add, Text, x193 y132 w40 h20 vYcurr, Y
	Gui, OCRClicker:Add, Text, x32 y171 w70 h20, Width
	Gui, OCRClicker:Add, Text, x32 y211 w70 h20, Height
	Gui, OCRClicker:Add, Edit, x112 y249 w110 h20 vTextRead, %TextRead%
	Gui, OCRClicker:Add, Text, x32 y249 w70 h20, TextRead
	Gui, OCRClicker:Add, Button, x242 y239 w100 h30 vStartBtn gDoStart, Start
	Gui, OCRClicker:Add, Button, x242 y199 w100 h30 gDoStop, Stop
	Gui, OCRClicker:Add, Button, x242 y159 w100 h30 gDoReload, Reload
	Gui, OCRClicker:Add, Button, x242 y119 w100 h30 gDoExit, Exit
	Gui, OCRClicker:Add, Button, x242 y79 w100 h30 gDoDraw, Draw
	Gui, OCRClicker:Add, Text, x32 y49 w70 h20 +Left, Parameter
	Gui, OCRClicker:Add, Text, x112 y49 w60 h20 +Left, Value
	Gui, OCRClicker:Add, Text, x682 y318 w260 h20 +Left, Press F12 to stop
	Gui, OCRClicker:Add, Text, x23 y318 w250 h20 +Left vOCRRead, Press Start

	Gui, OCRClicker:Add, GroupBox, x410 y19 w340 h290,
	Gui, OCRClicker:Add, Text, x432 y93 w70 h20, Click Position
	Gui, OCRClicker:Add, Text, x520 y93 w70 h20, X
	Gui, OCRClicker:Add, Edit, x532 y89 w60 h20 vClickX, %ClickX%
	Gui, OCRClicker:Add, Text, x612 y93 w70 h20, Y
	Gui, OCRClicker:Add, Edit, x622 y89 w60 h20 vClickY, %ClickY%

	Gui, OCRClicker:Add, Text, x432 y125 w70 h20, Send Text
	Gui, OCRClicker:Add, Edit, x532 y122 w60 h20 vSendInputAct, %SendInputAct%

	Gui, OCRClicker:Add, Text, x432 y155 w70 h20, Send Keys
	Gui, OCRClicker:Add, Edit, x532 y152 w60 h20 vSendKeysAct, %SendKeysAct%


	Gui, OCRClicker:Show, w781 h341, OCRClicker
	; Generated using SmartGUI Creator for SciTE
return

OCRRegionLabel:
	OCRRegionFunction(X,Y,Width,Height,TextRead,ClickX,ClickY,SendInputAct,SendKeysAct)
return

DoStart:
	Gui, OCRClicker:Default	
	GuiControl,, OCRRead, Started
	GuiControl,, SquareOn, 1
	Gosub, SquareOnLabel
	Gosub, IniWriter
	SetTimer, OCRRegionLabel, 500
	GuiControl, +Default, Start
return

DoDraw:
		DoDrawFunction()
		Gosub, SquareOnLabel
return

SquareOnLabel:
	Gui, OCRClicker:Submit, NoHide
	if(SquareOn = 0){
		CancelSquare()
	}
	else
	{
		DrawSquare(X,Y,Width,Height)
	}
return

UpdateMouseXYIndicator:
		MouseGetPos , OutputVarXX, OutputVarYY
		Gui, OCRClicker:Default
		GuiControl,, Xcurr, %OutputVarXX%
		GuiControl,, Ycurr, %OutputVarYY%
return

DoStop:
	SetTimer, OCRRegionLabel, Off
	Gui, OCRClicker:Default
	GuiControl,, OCRRead, Stopped
	Gosub, SquareOnLabel
	GuiControl, +Default, Stop
	ToolTip
return


IniReader:
	IniRead, X, OCRsettings.ini, Settings, X
	IniRead, Y, OCRsettings.ini, Settings, Y
	IniRead, Width, OCRsettings.ini, Settings, Width
	IniRead, Height, OCRsettings.ini, Settings, Height
	IniRead, TextRead, OCRsettings.ini, Settings, TextRead
	IniRead, ClickX, OCRsettings.ini, Settings, ClickX
	IniRead, ClickY, OCRsettings.ini, Settings, ClickY
	IniRead, SendInputAct, OCRsettings.ini, Settings, SendInputAct
	IniRead, SendKeysAct, OCRsettings.ini, Settings, SendKeysAct
return

IniWriter:
	IniWrite, %X%, OCRsettings.ini, Settings, X
	IniWrite, %Y%, OCRsettings.ini, Settings, Y
	IniWrite, %Width%, OCRsettings.ini, Settings, Width
	IniWrite, %Height%, OCRsettings.ini, Settings, Height
	IniWrite, %TextRead%, OCRsettings.ini, Settings, TextRead
	IniWrite, %ClickX%, OCRsettings.ini, Settings, ClickX
	IniWrite, %ClickY%, OCRsettings.ini, Settings, ClickY
	IniWrite, %SendInputAct%, OCRsettings.ini, Settings, SendInputAct
	IniWrite, %SendKeysAct%, OCRsettings.ini, Settings, SendKeysAct
return

F12::
	SetTimer, OCRRegionLabel, Off
	CancelSquare()
	ToolTip
return

DoExit:
	ExitApp
return

DoReload:
	Reload
return
