;#NoTrayIcon
#singleinstance force
#NoEnv
#include OCRRegion.ahk

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
	GetKeyState, MousePressedOutside, LButton
	if (MousePressedOutside = "D")
	{
		SetTimer, DoFocusView, Off
	}
	
	if (MousePressedOutside = "U")
	{
		if (FocusView = 1)
		{
			Show := 1
			SetTimer, DoFocusView, 100
		}
		if (FocusView = 0)
		{
			SetTimer, DoFocusView, Off
			Show := 0
		}
	}
	
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
	DrawSquare(X,Y,Width,Height)
	SetTimer, OCRRegionLabel, 500
return

DoStop:
	FocusView := 0
	Show := 0
	SetTimer, OCRRegionLabel, Off
	CancelSquare()
	ToolTip
return

DoDraw:	
	KeyWait, LButton, D		
		MouseGetPos , FirstX, FirstY
		Gui, OCRClicker:Show
		Loop
		{		
			DisplayX := FirstX
			DisplayY := FirstY
			GetKeyState, MousePressed, LButton
			if (MousePressed = "D")
			{
				MouseGetPos , CurrX, CurrY			
				if (CurrX < FirstX)
				{
					CurrWidth := FirstX - CurrX					
					DisplayX := CurrX
				}
				else
				{
					CurrWidth := CurrX - FirstX
				}
				if (CurrY < FirstY)
				{					
					CurrHeight := FirstY - CurrY					
					DisplayY := CurrY
				}
				else
				{
					CurrHeight := CurrY - FirstY
				}
				Gui, Square2:Color, Blue
				Gui, Square2:+AlwaysOnTop -Caption +ToolWindow	
				Gui, Square2:Show, x%DisplayX% y%DisplayY% w%CurrWidth% h%CurrHeight%, Test2
				    MouseGetPos , OutputVarXXX, OutputVarYYY
					if (OutputVarXXX != OutputVarXX && OutputVarYYY!= OutputVarYY  )
					{
						OutputVarXX := OutputVarXXX
						OutputVarYY := OutputVarYYY
						Gui, OCRClicker:Default
						GuiControl,, Xcurr, %OutputVarXX%
						GuiControl,, Ycurr, %OutputVarYY%
					}
				WinSet, Transparent, 100, Test2				
			}
			
			else
			{
				MouseGetPos , CurrX, CurrY			
				if (CurrX < FirstX)
				{
					CurrWidth := FirstX - CurrX					
					DisplayX := CurrX
				}
				else
				{
					CurrWidth := CurrX - FirstX
				}
				if (CurrY < FirstY)
				{					
					CurrHeight := FirstY - CurrY					
					DisplayY := CurrY
				}
				else
				{
					CurrHeight := CurrY - FirstY
				}				
				Gui, Square2:Hide				
				Gui, OCRClicker:Show
				Gui, OCRClicker:Default
				GuiControl,, x, %DisplayX%
				GuiControl,, y, %DisplayY%
				GuiControl,, width, %CurrWidth%
				GuiControl,, height, %CurrHeight%				
				return
			}	
				
		}
	;for debugging remove comments:
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

DoFocusView:
    Gui, OCRClicker:Show
return

OCRRegionLabel:
	OCRRegionFunction(X,Y,Width,Height,TextRead)
return

F11::
	Show := 0
	FocusView := 0
return