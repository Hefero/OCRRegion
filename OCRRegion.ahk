; #NoTrayIcon
#singleinstance force
#NoEnv

#include OCR.ahk

SetWorkingDir %A_ScriptDir%
SendMode Input
CoordMode, Mouse, Screen
X = %1%

if(X == "kill")
{
	ExitApp
}

Y = %2%
Width = %3%
Height = %4%
TextRead = %5%
W:= X + Width
H:= Y + Height



;Loop, %0%  ; For each parameter:
;{
;    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
;    MsgBox, 4,, Parameter number %A_Index% is %param%.  Continue?
;    IfMsgBox, No
;        break
;}
;ListVars
;Pause

DrawSquare(X,Y,Width,Height)
Loop
{
    CoordMode, Pixel, Screen
    CoordMode, ToolTip, Screen	
	ToolTip, Reading, %W%, %H%, 1	
    if (ErrorLevel == 0)
    {   
        ; Perform actions based on the recognized text
		if(OCRRegion(X,Y,Width,Height,TextRead))
		{
			; Take action if the desired text is found
			; Replace "TextToSearch" with the text you want to search for
			ToolTip, %ocrText%, %W%, %H%, 1								
			Gui, Square:Cancel			
			MouseGetPos, OutputVarX, OutputVarY	
			Gosub, ActionToPerform
			MouseMove, OutputVarX, OutputVarY, 0			
			DrawSquare(X,Y,Width,Height)
				
			Sleep, 1500
		}
    }	
	Sleep, 1500
    ; Delay between OCR checks
    
}



OCRRegion(X,Y,Width,Height,TextRead){
	ocrText := OCR(X,Y,Width,Height)
	; find textread on recognized text
	IfInString, ocrText, %TextRead%
	{
		return true
	}
	else
	{
		return false	
	}
}

DrawSquare(X,Y,Width,Height)
{
	Gui, Square:Color, Blue
	Gui, Square:+AlwaysOnTop -Caption +ToolWindow	
	Gui, Square:Show, x%X% y%Y% w%Width% h%Height%, SquareGui
	WinSet, Transparent, 100, SquareGui
}

ActionToPerform:
	SendInput, {Click %X%, %Y%}
return





F11::ExitApp


