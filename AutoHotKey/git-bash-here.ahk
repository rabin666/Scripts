; AutoHotkey Version: 2.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Yibo
;
; Script Function:
;   Define the shortcut Ctrl + Alt + T for launching Git bash and Ctrl + Alt + C for launching VS Code in the current folder in Windows Explorer
;

SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

#NoTrayIcon

SetTitleMatchMode("RegEx")
return

; Stuff to do when Windows Explorer is open
;
#HotIf WinActive("ahk_class ExploreWClass") || WinActive("ahk_class CabinetWClass")

; open Git bash in the current directory
; Use Ctrl + Alt + T for Git Bash activation
^!t:: {
    OpenGbHere()
}
; open VS Code in the current directory
; Use Ctrl + Alt + C for VS Code activation
^!c:: {
    OpenVSCodeHere()
}
#HotIf

; Opens the Git bash shell in the directory browsed in Explorer.
; Note: expecting to be run when the active window is Explorer.
OpenGbHere() {
    ; Retrieve the full path of the active Explorer window
    full_path := GetExplorerPath()

    ; If the path is valid, launch Git Bash in that directory
    if full_path {
        Run 'C:\Program Files\Git\git-bash.exe', full_path
    } else {
        MsgBox "Could not retrieve the path from the Explorer window."
    }
}

; Opens Visual Studio Code in the directory browsed in Explorer.
OpenVSCodeHere() {
    ; Retrieve the full path of the active Explorer window
    full_path := GetExplorerPath()

    ; Build the path to VS Code dynamically using A_UserName
    vscode_path := "C:\Users\" A_UserName "\AppData\Local\Programs\Microsoft VS Code\Code.exe"

    ; If the path is valid, launch VS Code in that directory
    if full_path {
        Run vscode_path " " full_path  ; Pass the directory as an argument to VS Code
    } else {
        MsgBox "Could not retrieve the path from the Explorer window."
    }
}

; Function to retrieve the path of the active Windows Explorer folder
GetExplorerPath() {
    for window in ComObject("Shell.Application").Windows {
        if window.hwnd = WinExist("A") {
            return window.Document.Folder.Self.Path
        }
    }
    return ""
}
