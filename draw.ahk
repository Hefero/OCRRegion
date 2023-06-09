

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


DoDrawFunction(){

	KeyWait, LButton, D
		MouseGetPos , FirstX, FirstY
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
				Gui, Square:Color, Blue
				Gui, Square:+AlwaysOnTop -Caption +ToolWindow	
				Gui, Square:Show, x%DisplayX% y%DisplayY% w%CurrWidth% h%CurrHeight%, Test2
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
				Gui, OCRClicker:Default
				GuiControl,, X, %DisplayX%
				GuiControl,, Y, %DisplayY%
				GuiControl,, Width, %CurrWidth%
				GuiControl,, Height, %CurrHeight%				
				return
			}	
				
		}
	;for debugging remove comments:
return
}