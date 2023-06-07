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
Gui, Add, Button, x242 y159 w100 h30 gDoReload , Reload
Gui, Add, Button, x242 y119 w100 h30 gDoExit , Exit
Gui, Add, Text, x32 y49 w70 h20 +Left, Parameter
Gui, Add, Text, x112 y49 w60 h20 +Left, Value
; Generated using SmartGUI Creator for SciTE
Gui, Add, Text, x282 y318 w260 h20 +Left, Press F12 to stop
Gui, Show, w381 h341, OCR Clicker

OutputVarXX =  0
OutputVarYY = 0
PrevLine = ""
Loop{
	CoordMode, Mouse, Screen
    MouseGetPos , OutputVarXXX, OutputVarYYY
	if (OutputVarXXX != OutputVarXX && OutputVarYYY!= OutputVarYY  )
	{
		OutputVarXX := OutputVarXXX
		OutputVarYY := OutputVarYYY
		Gui, Add, Text, x193 y89 w40 h20 , %OutputVarXX%	
		Gui, Add, Text, x193 y129 w40 h20 , %OutputVarYY%
	}
	LastLine = %Clipboard%
	if (LastLine != PrevLine){
		if (LastLine != NULL){			
			Gui, Add, Text, x23 y318 w250 h20 +Left, %LastLine%
			PrevLine := LastLine
		}
		else 
		{			
			Gui, Add, Text, x23 y318 w250 h20 +Left, %PrevLine%
		}
	}	
	
	
	Sleep, 150
	
}


return

DoExit:
	StringKill := A_ScriptDir . "\OCRRegion.ahk kill"
	Run, %StringKill%, %A_ScriptDir%, Hide, ocrAHKPID 
	GuiClose:
ExitApp

DoReload:
	StringKill := A_ScriptDir . "\OCRRegion.ahk kill"
	Run, %StringKill%, %A_ScriptDir%, Hide, ocrAHKPID
	Run, %A_ScriptFullPath%
return


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
	;for debugging remove comments:
	ListVars
	Pause
return

