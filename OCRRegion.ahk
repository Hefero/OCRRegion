


#include OCR.ahk
#include draw.ahk

OCRRegionFunction(X,Y,Width,Height,TextRead,ClickX,ClickY
,SendInputAct,SendKeysAct,SendScript
,DelayClick,DelayInput,DelayKeys,DelayScript){
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
			;; action
			if (ClickX != "" && ClickY != ""){
				CancelSquare()
				Sleep, DelayClick
				MouseGetPos, OutputVarX, OutputVarY					
				SendInput, {Click %ClickX%, %ClickY%}			
				MouseMove, OutputVarX, OutputVarY, 0				
				Gosub, SquareOnLabel
			}
			if(SendInputAct != ""){					
				Sleep, DelayInput
				SendRaw, %SendInputAct%
			}
			if(SendKeysAct != ""){					
				Sleep, DelayKeys
				Send, {%SendKeysAct%}
			}
			if(SendScript != ""){					
				Sleep, DelayScript
				RunWait, {%SendScript%}
			}
			;;action end			
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
