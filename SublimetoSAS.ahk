; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.
;
; Keys:
;# WindowsKey
;! Alt
;^ Ctrl
;+ Shift
; The shortcuts will only be effective in Sublime

; Start sas from current sas file location
#IfWinActive, ahk_class PX_WINDOW_CLASS
{
	^!s::
		WinGetTitle, title, A
		; app_name = .sas
		IfInString, title, .sas
		{
			Clipboard =
			Sendinput, ^!+f
			ClipWait
			haystack := Clipboard
			needle := "\\([^\\]*)\.sas$"
			replacement := ""
			result := RegExReplace(haystack, needle, replacement)
			Clipboard :=
			Clipboard := result

			if ! WinExist("ahk_class SAS aws")
			{
				Run "sas" -rsasuser, %Clipboard%, Maximize
				WinWaitActive, ahk_class SAS aws
			}
			Else 
				{
					WinActivate
					Clipboard =
					Clipboard := "x 'cd " . result . "';"
					ClipWait		
					Send, {F1}
				}
			sleep, 700
			Send, {F5}
			sleep, 100
			Send ^{F4}
			sleep, 200
			Send {F7}
			sleep, 100
			Send ^{F4}
			sleep, 700	
			Send, {F6}			

		}	
	return
}

; Copy selected text to the clipboard and switch to SAS to submit it
#IfWinActive, ahk_class PX_WINDOW_CLASS
SetTitleMatchMode, 2
{
	F3::
		WinGetTitle, title, A
		IfInString, title, .sas
		{
			Send ^c
			if ! WinExist("ahk_class SAS aws")
			{
				msgbox SAS Program Not Open!
			}
			Else 
				{
					WinActivate
					sleep, 200
					Send, {F1}		
					WinActivate, ahk_class PX_WINDOW_CLASS			
				}
		}
	return
}


; Clear contents

#IfWinActive, ahk_class PX_WINDOW_CLASS
{
	F12::
		WinGetTitle, title, A
		app_name = Sublime Text
		IfInString, title, %app_name%
		{
			if WinExist("ahk_class SAS aws")
			{
				WinActivate
				sleep, 200
				Send, {F12}
				WinActivate, ahk_class PX_WINDOW_CLASS
			}
			Else
			{
				msgbox SAS Program Not Open!
			}	
		}
	return	
}

