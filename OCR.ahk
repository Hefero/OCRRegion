#include cmd.ahk

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