#include cmd.ahk
;Loop, %0%  ; For each parameter:
;{
;    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
;    MsgBox, 4,, Parameter number %A_Index% is %param%.  Continue?
;    IfMsgBox, No
;        break
;}
;ListVars
;Pause


OCR(x,y,w,h)
{
	;OCR Reader
	CoordsForm := x . " " . y . " " . x+w . " " . y+h		
	CLIpath := """" . A_ScriptDir . "\Capture2Text\Capture2Text_CLI.exe" . """"
	CLIappend := " -o lastread.txt --screen-rect " . """"  CoordsForm """"
	CLIcommand :=  CLIpath . CLIappend
	StringReturn := RunWaitOne(CLIcommand)
	FileReadLine, OutputVar, lastread.txt, 1
	return OutputVar
}