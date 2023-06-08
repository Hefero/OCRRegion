; #NoTrayIcon
#singleinstance force
#NoEnv
SetWorkingDir %A_ScriptDir%
SendMode Input
CoordMode, Mouse, Screen
Clipboard := ""
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
Gui, Color, Blue
Gui, +AlwaysOnTop -Caption +ToolWindow
Gui, Show, x%X% y%Y% w%Width% h%Height%, Test
WinSet, Transparent, 100, Test

OCR(x,y,w,h)
{
	;OCR Reader
	StringRun := A_ScriptDir . "\Capture2Text\Capture2Text_CLI.exe --clipboard -o lastread.txt --screen-rect """ . x . " " . y . " " . x+w . " " . y+h . """"
	RunWait, %StringRun%,%A_ScriptDir%, Hide, ocrPID
	Process, WaitClose, %ocrPID%
}

Loop
{
	Clipboard := ""
    CoordMode, Pixel, Screen
    CoordMode, ToolTip, Screen	
	ToolTip, Reading, %W%, %H%, 1
	
    if (ErrorLevel == 0)
    {
        ; Perform OCR on the captured image
        ocrText := OCR(X,Y,Width,Height)		

        ; Perform actions based on the recognized text
		IfInString, Clipboard, %TextRead%
		{
			; Take action if the desired text is found
			; Replace "TextToSearch" with the text you want to search for
			ToolTip, Text found!, %W%, %H%, 1
			MouseGetPos , OutputVarX, OutputVarY
			;MouseMove, %X%, %Y%
			Gui, Cancel
			SendInput, {Click %X%, %Y%}
			Gui, Color, Blue
			Gui, +AlwaysOnTop -Caption +ToolWindow
			Gui, Show, x%X% y%Y% w%Width% h%Height%, Test
			WinSet, Transparent, 100, Test
			MouseMove, OutputVarX, OutputVarY, 0	
			Sleep, 1500
		}
    }	
	Sleep, 1500
    ; Delay between OCR checks
    
}

F11::ExitApp


