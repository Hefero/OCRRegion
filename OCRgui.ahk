#NoTrayIcon
#singleinstance force
#NoEnv
SetWorkingDir %A_ScriptDir%
SendMode Input
Clipboard = Press Start

IniRead, X, OCRsettings.ini, Settings, X
IniRead, Y, OCRsettings.ini, Settings, Y
IniRead, Width, OCRsettings.ini, Settings, Width
IniRead, Height, OCRsettings.ini, Settings, Height
IniRead, TextRead, OCRsettings.ini, Settings, TextRead

Gui, +AlwaysOnTop +ToolWindow
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
Gui, OCRClicker:Add, Text, x32 y2 w70 h20 , Height
Gui, OCRClicker:Add, Edit, x112 y249 w110 h20 vTextRead , %TextRead%
Gui, OCRClicker:Add, Text, x32 y249 w70 h20 , TextRead
Gui, OCRClicker:Add, Button, x242 y239 w100 h30 gDoStart , Start
Gui, OCRClicker:Add, Button, x242 y199 w100 h30 gDoStop , Stop
Gui, OCRClicker:Add, Button, x242 y159 w100 h30 gDoReload , Reload
Gui, OCRClicker:Add, Button, x242 y119 w100 h30 gDoExit , Exit
Gui, OCRClicker:Add, Button, x242 y79 w100 h30 gDoDraw , Draw
Gui, OCRClicker:Add, Text, x32 y49 w70 h20 +Left, Parameter
Gui, OCRClicker:Add, Text, x112 y49 w60 h20 +Left, Value
Gui, OCRClicker:Add, Text, x282 y318 w260 h20 +Left, Press F12 to stop
Gui, OCRClicker:Add, Text, x23 y318 w250 h20 +Left vOCRRead, Press Start
Gui, OCRClicker:Show, w381 h341, OCRClicker
; Generated using SmartGUI Creator for SciTE


OutputVarXX =  0
OutputVarYY = 0
PrevLine = ""
First := 1
Loop{
	CoordMode, Mouse, Screen
    MouseGetPos , OutputVarXXX, OutputVarYYY
	if (OutputVarXXX != OutputVarXX && OutputVarYYY!= OutputVarYY  )
	{
		OutputVarXX := OutputVarXXX
		OutputVarYY := OutputVarYYY
		Gui, OCRClicker:Default
		GuiControl,, Xcurr, %OutputVarXX%
		GuiControl,, Ycurr, %OutputVarYY%
	}
	LastLine = %Clipboard%
	if (LastLine != PrevLine){
		Gui, OCRClicker:Default
		if (LastLine != ""){			
			GuiControl,, OCRRead, %LastLine%
			PrevLine := LastLine
		}
		else 
		{			
			GuiControl,, OCRRead, %PrevLine%
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
	ExitApp
return


DoStart:
	;ListVars
	Gui, OCRClicker:Submit, NoHide
	IniWrite, %X%, OCRsettings.ini, Settings, X
	IniWrite, %Y%, OCRsettings.ini, Settings, Y
	IniWrite, %Width%, OCRsettings.ini, Settings, Width
	IniWrite, %Height%, OCRsettings.ini, Settings, Height
	IniWrite, %TextRead%, OCRsettings.ini, Settings, TextRead
	StringRun := A_ScriptDir . "\OCRRegion.ahk " . "" x "" . " " . "" y "" . " " . "" width "" . " " . "" height "" . " " . """" . "" TextRead "" . """"
	;textRead can be multiple so it has quadruple quotes to include quotes and double quotes to contain spaces	
	Run, %StringRun%, %A_ScriptDir%, Hide, ocrAHKPID
return

DoStop:	
	StringKill := A_ScriptDir . "\OCRRegion.ahk kill"
	Run, %StringKill%, %A_ScriptDir%, Hide, ocrAHKPID
	;for debugging remove comments:
	;ListVars
	;Pause
return

F11::
MsgBox, a
	MouseGetPos , X, Y
return

DoDraw:	
	StringKill := A_ScriptDir . "\OCRRegion.ahk kill"
	Run, %StringKill%, %A_ScriptDir%, Hide, ocrAHKPID		
	KeyWait, LButton, D		
		MouseGetPos , FirstX, FirstY
		Gui, OCRClicker:Show
		Loop
		{			
			GetKeyState, MousePressed, LButton
			if (MousePressed = "D")
			{					
				MouseGetPos , CurrX, CurrY			
				if (CurrX < FirstX)
				{
					CurrWidth := FirstX - CurrX					
					FirstX := CurrX
				}
				else
				{
					CurrWidth := CurrX - FirstX
				}
				if (CurrY < FirstY)
				{					
					CurrHeight := FirstY - CurrY					
					FirstY := CurrY
				}
				else
				{
					CurrHeight := CurrY - FirstY
				}
				Gui, Square:Color, Blue
				Gui, Square:+AlwaysOnTop -Caption +ToolWindow	
				Gui, Square:Show, x%FirstX% y%FirstY% w%CurrWidth% h%CurrHeight%, Test2
				WinSet, Transparent, 100, Test2
			}
			else
			{				
				Gui, Square:Hide				
				Gui, OCRClicker:Show
				Gui, OCRClicker:Default
				GuiControl,, x, %FirstX%
				GuiControl,, y, %FirstY%
				GuiControl,, width, %CurrWidth%
				GuiControl,, height, %CurrHeight%				
				return
			}		
		}
	;for debugging remove comments:
return

