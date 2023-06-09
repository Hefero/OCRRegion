Loop, 3 ; Change the number as per your requirement
{
    timerName := "MyTimer" . A_Index
    SetTimer % timerName, 1000
}

MyTimer1:
    MsgBox Timer 1 fired!
return

MyTimer2:
    MsgBox Timer 2 fired!
return

MyTimer3:
    MsgBox Timer 3 fired!
return