!q::!F4
#q::!F4




; Emacs風キーバインドを無効にしたいウィンドウ一覧
; 必要の無い部分はコメントアウトして下さい
is_emacs()
{
	IfWinActive,ahk_class Emacs ;NTEmacs
		Return 1  
	IfWinActive,ahk_class XEmacs ;Cygwin上のXEmacs
		Return 1
	Return 0
}

; Emacs では SKK を、Emacs 以外では SKKFEP を起動
; 029 半角全角
; 07B 無変換
; 079 変換
sc07B::
        If is_emacs()
           Send {%A_ThisHotkey%}
        Else
           Send {sc029}
	Return

sc079::
        If is_emacs()
           Send {%A_ThisHotkey%}
        Else
           Send {sc029}
        Return



