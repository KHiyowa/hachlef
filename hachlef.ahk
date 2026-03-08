; ----------------------------------------------------------------------
; Hachlef!! - AutoHotkey v2.0
;
; Author:       Hiyowa Kyobashi  https://github.com/KHiyowa/hachlef

; ----------------------------------------------------------------------
;@Ahk2Exe-SetCompanyName Hiyowa Records
;@Ahk2Exe-SetCopyright Hiyowa Kyobashi
;@Ahk2Exe-SetDescription Hachlef!!
;@Ahk2Exe-SetFileVersion 1.0.1
;@Ahk2Exe-SetInternalName Hachlef!!
;@Ahk2Exe-SetOrigFilename hachlef.exe
;@Ahk2Exe-SetProductName Hachlef!!
;@Ahk2Exe-SetProductVersion 1.0.1
;@Ahk2Exe-SetMainIcon hachlef.ico

#Requires AutoHotkey v2.0
#SingleInstance Force
SetStoreCapsLockMode False
A_IconTip := "Hachlef!!"

; Enable hotkeys only when google-chat-desktop.exe is active
#HotIf WinActive("ahk_exe google-chat-desktop.exe")

; Allow handling of rapid key presses by permitting multiple threads
#MaxThreadsPerHotkey 2

~LAlt & Shift::
~Shift & LAlt::
{
    ; 1. Send dummy key first to prevent menu activation
    SendEvent("{Blind}{vkFF}")
    ; 2. Wait for Alt key release
    KeyWait("LAlt")
    ; 3. Switch input language
    if (A_PriorKey = "LAlt" || A_PriorKey = "LShift" || A_PriorKey = "RShift" || A_PriorKey = "vkE8") {
        try {
            ctl := ControlGetFocus("A")
        } catch {
            ctl := ""
        }

        if (ctl)
            PostMessage(0x0050, 0x0002, 0, ctl, "A") ; WM_INPUTLANGCHANGEREQUEST
        else
            PostMessage(0x0050, 0x0002, 0, , "A")
    }
}
; Reset hotkey condition
#HotIf