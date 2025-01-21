#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe CivilizationV_DX11.exe")

; Replace XButton2 with XButton1 for the back button
XButton2::
{
  SendMode("InputThenPlay")
  MouseGetPos(&start_x, &start_y)
  MouseMove(3272, 1190, 0)
  DllCall("user32.dll\mouse_event", "UInt", 0x2, "Int", 0, "Int", 0, "UInt", 0, "Ptr", 0) ; MOUSEEVENTF_LEFTDOWN
  Sleep(50)
  DllCall("user32.dll\mouse_event", "UInt", 0x4, "Int", 0, "Int", 0, "UInt", 0, "Ptr", 0) ; MOUSEEVENTF_LEFTUP

  MouseMove(start_x, start_y, 0)
}