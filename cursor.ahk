ReplaceSystemCursor(old := "", new := "")
{
   static IMAGE_CURSOR := 2, SPI_SETCURSORS := 0x57
        , exitFunc := Func("ReplaceSystemCursor").Bind("", "")
        , setOnExit := false
        , SysCursors := { IDC_APPSTARTING: 32650
                        , IDC_ARROW      : 32512
                        , IDC_CROSS      : 32515
                        , IDC_HAND       : 32649
                        , IDC_HELP       : 32651
                        , IDC_IBEAM      : 32513
                        , IDC_NO         : 32648
                        , IDC_SIZEALL    : 32646
                        , IDC_SIZENESW   : 32643
                        , IDC_SIZENWSE   : 32642
                        , IDC_SIZEWE     : 32644
                        , IDC_SIZENS     : 32645 
                        , IDC_UPARROW    : 32516
                        , IDC_WAIT       : 32514 }
   if !old {
      DllCall("SystemParametersInfo", "UInt", SPI_SETCURSORS, "UInt", 0, "UInt", 0, "UInt", 0)
      OnExit(exitFunc, 0), setOnExit := false
   }
   else  {
      hCursor := DllCall("LoadCursor", "Ptr", 0, "UInt", SysCursors[new], "Ptr")
      hCopy := DllCall("CopyImage", "Ptr", hCursor, "UInt", IMAGE_CURSOR, "Int", 0, "Int", 0, "UInt", 0, "Ptr")
      DllCall("SetSystemCursor", "Ptr", hCopy, "UInt", SysCursors[old])
      if !setOnExit
         OnExit(exitFunc), setOnExit := true
   }
}