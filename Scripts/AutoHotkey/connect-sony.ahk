#Requires AutoHotkey v2.0
+F5::{

    SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

    ; Start the sequence when Shift + F5 is pressed
    MyHotkeyFunction()
    Return

    MyHotkeyFunction() {
        ; Wait for a moment before starting the sequence
        Sleep(1000)

        ; bluetooth icon taskbar
        MouseMove(3178, 1418)
        Click("Right")
        Sleep(1000)

        ; Show bluetooth devices
        MouseMove(3254, 1257)
        Click()
        Sleep(1000)

        ; 3 dots
        MouseMove(2333, 921)
        Click()
        Sleep(1000)

        ; remove device
        MouseMove(2329, 881)
        Click()
        Sleep(1000)

        ;add device
        MouseMove(2287, 224)
        Click()
        Sleep(1000)

        ;Bluetooth
        MouseMove(1707, 538)
        Click()
        Sleep(5000)

        ;Pair
        MouseMove(1729, 541)
        Click()
        Sleep(1000)

        ;close windows
        Send("!{F4}")
        Sleep(100)
        Send("!{F4}")
        Sleep(1000)

        RightClickSoundTaskbar()

        ;sound settings
        MouseMove(3315, 1364)
        Click()
        Sleep(1000)

        ;more sound settings
        MouseMove(1865, 1224)
        Click()
        Sleep(1000)

        ; recording
        LeftClickAt(1829, 482)

        ; scroll down
        MouseMove(1929, 643)
        Sleep(100)
        Click(17, "WheelDown")

        ; rightclick device
        RightClickAt(1908, 774)
        LeftClickAt(2042, 841)
    }

    RightClickSoundTaskbar() {
        MouseMove(3308, 1410)
        Click("Right")
        Sleep(100)
    }

    LeftClickAt(xScreen, yScreen) {
        MouseMove(xScreen, yScreen)
        Click()
        Sleep(1000)
    }

    RightClickAt(xScreen, yScreen) {
        MouseMove(xScreen, yScreen)
        Click("Right")
        Sleep(1000)
    }
}