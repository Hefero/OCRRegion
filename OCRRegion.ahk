#include OCR.ahk

OCRRegionFunction(X,Y,Width,Height,TextRead){
	W:= X + Width
	H:= Y + Height
	PrevText := ""
	; Perform actions based on the recognized text
	OCRTextRegion := OCR(X,Y,Width,Height)
	if (TextRead != ""){
		IfInString, OCRTextRegion, %TextRead%
		{
			; Take action if the desired text is found
			; Replace "TextToSearch" with the text you want to search for						
			CancelSquare()
			;; action
			MouseGetPos, OutputVarX, OutputVarY	
			SendInput, {Click %X%, %Y%}
			MouseMove, OutputVarX, OutputVarY, 0
			;;action end
			DrawSquare(X,Y,Width,Height)
		}
	}
	
	if (OCRTextRegion != PrevText)
	{ ;shows tooltip case new
		if (OCRTextRegion != 0)
		{			
			ToolTip, %OCRTextRegion%, %W%, %H%, 1
			Gui, OCRClicker:Default
			GuiControl,, OCRRead, %OCRTextRegion%
			PrevText := OCRTextRegion
		}
		else
		{
			ToolTip
		}
	}
	return
}

DrawSquare(X,Y,Width,Height)
{
	Gui, Square:Color, Blue
	Gui, Square:+AlwaysOnTop -Caption +ToolWindow	
	Gui, Square:Show, x%X% y%Y% w%Width% h%Height%, SquareGui
	WinSet, Transparent, 100, SquareGui
	return
}

CancelSquare()
{
	Gui, Square:Cancel
	return
}