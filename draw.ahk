#include cursor.ahk

DrawSquare(X,Y,Width,Height)
{
	Gui, Square:Color, Blue
	Gui, Square:+AlwaysOnTop -Caption +ToolWindow +E0x20
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
	DisplayInvisibleFullRect()
	ReplaceSystemCursor("IDC_ARROW", "IDC_CROSS")
	Loop{
		GetKeyState, MousePressed, LButton
		Gosub, UpdateMouseXYIndicator
		if (MousePressed = "D")
		{
			Gosub, UpdateMouseXYIndicator
			MouseGetPos, FirstX, FirstY
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
						DisplayX := CurrX
					}
					if (CurrY < FirstY)
					{
						DisplayY := CurrY
					}					
					DrawSquare(DisplayX,DisplayY,Abs(FirstX - CurrX),Abs(FirstY - CurrY))
					Gosub, UpdateMouseXYIndicator
				}
				
				else
				{
					MouseGetPos, CurrX, CurrY
					CurrHeight := Abs(FirstY - CurrY)
					CurrWidth := Abs(FirstX - CurrX)
					if (CurrX < FirstX)
					{
						DisplayX := CurrX
					}
					if (CurrY < FirstY)
					{
						DisplayY := CurrY
					}
					Gui, OCRClicker:Default
					GuiControl,, X, %DisplayX%
					GuiControl,, Y, %DisplayY%
					GuiControl,, Width, %CurrWidth%
					GuiControl,, Height, %CurrHeight%					
					Gui, SquareFullRect:Cancel
					ReplaceSystemCursor()
					return
				}					
			}
		}
	}
	return
}

DisplayInvisibleFullRect(){	
	SysGet, OutputVarX, 78
	SysGet, OutputVarY, 79
	Gui, Square:Color, EEAA99
	Gui, SquareFullRect:-Caption +ToolWindow +E0x20
	Gui, SquareFullRect:Show, x0 y0 w0 h0, SquareGuiRect
	Gui, SquareFullRect:Show, x0 y0 w%OutputVarX% h%OutputVarY%, SquareGuiRect
	WinSet, Transparent, 0, SquareGuiRect
	return
}