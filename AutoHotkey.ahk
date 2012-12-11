*Space::
  SendInput {RShift Down}
  If SandS_SpaceDown = 1
  {
    Return
  }
  SandS_SpaceDown := 1
  SandS_SpaceDownTime := A_TickCount ; milliseconds after computer is booted http://www.autohotkey.com/docs/Variables.htm
  SandS_AnyKeyPressed := 0
  ; watch for the next single key, http://www.autohotkey.com/docs/commands/Input.htm
  Input, SandS_AnyKey, L1 V,{LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause} 
  SandS_AnyKeyPressed := 1
  Return


*Space Up:: 
  SendInput {RShift Up}
  SandS_SpaceDown := 0
  If SandS_AnyKeyPressed = 0
  {
    If A_TickCount - SandS_SpaceDownTime < 200
    {
      SendInput {Space}
    }
    ; Send EndKey of the "Input" command above
    ; You must use Send here since SendInput is ignored by "Input"
    Send {RShift}
  }
  Return

!q::!F4
#q::!F4




; Emacs風キーバインドを無効にしたいウィンドウ一覧
is_emacs()
{
	IfWinActive,ahk_class Emacs ;NTEmacs
		Return 1  
	IfWinActive,ahk_class XEmacs ;Cygwin上のXEmacs
		Return 1
	Return 0
}


;; Emacs では SKK を、Emacs 以外では SKKFEP を起動
;; 029 半角全角
;; 07B 無変換
;; 079 変換
;sc07B::
;        If is_emacs()
;           Send {%A_ThisHotkey%}
;        Else
;           Send {sc029}
;    Return
; 
;sc079::
;        If is_emacs()
;           Send {%A_ThisHotkey%}
;        Else
;           Send {sc029}
;        Return



