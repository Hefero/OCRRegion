#include OCR.ahk
#include draw.ahk

OCRRegionFunction(X,Y,Width,Height,TextRead,ClickX,ClickY,SendInputAct,SendKeysAct){
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
			SendInput, {Click %ClickX%, %ClickY%}			
			Sleep, 10
			SendRaw, %SendInputAct%
			Sleep, 10
			Send, {%SendKeysAct%}
			Sleep, 10
			MouseMove, OutputVarX, OutputVarY, 0
			;;action end
			Gosub, SquareOnLabel
		}
	}
	
	if (OCRTextRegion != PrevText)
	{ ;shows tooltip case new
		if (OCRTextRegion != 0 && OCRTextRegion != "<Error>")
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