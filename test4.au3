;~ Opt("MustDeclareVars", 1)
;~ #AutoIt3Wrapper_UseX64=y
;~ #AutoIt3Wrapper_Change2CUI=y
#RequireAdmin

#include "_ImageSearch_UDF.au3"

HotKeySet("{Esc}", "_Exit")
Func _Exit()
   Exit 0
EndFunc   ;==>_Exit

_ImageSearch_Example()

Func _ImageSearch_Example()
   Local $_enter = @ScriptDir & "\enter.bmp"
   Local $_accept = @ScriptDir & "\accept.bmp"
   Local $_leave = @ScriptDir & "\leave.bmp"
   ;Local $_ok = @ScriptDir & "\ok.bmp"
   Local $_ok = @ScriptDir & "\Seach_1.bmp"
   Local $find_ListImage = $_enter & '|' & $_accept & '|' & $_leave & '|' & $_ok
   Local $counter = 10

   Local $return = _ImageSearch($find_ListImage)
   If $return[0] == 1 Then
	  MouseMove($return[1], $return[2])
	  MsgBox(0, 'Example 1', 'found image')
   Else
	  MsgBox(0, 'Example 1', 'Cannot find image')
   EndIf


;~    while $counter <> 0
;~ 	  Sleep (15000)
;~ 	  Send ( "g" )
;~ 	  while 1
;~ 		 Local $return = _ImageSearch($find_ListImage)
;~ 		 If $return[0] == 1 Then
;~ 			MouseMove($return[1], $return[2])
;~ 			MouseClick("primary")
;~ 			Sleep (1000)
;~ 		 Else
;~ 			MsgBox(0, 'Example 1', 'Cannot find image')
;~ 		 EndIf
;~ 		 Local $return = _ImageSearch($find_ListImage)
;~ 		 If $return[0] == 1 Then
;~ 			MouseMove($return[1], $return[2])
;~ 			MouseClick("primary")
;~ 			Sleep (5000)
;~ 			ExitLoop
;~ 		 EndIf
;~ 	  WEnd
;~ 	  while 1
;~ 		 Local $hTimer = TimerInit()
;~ 		 Send ( "f" )
;~ 		 Sleep (50)
;~ 		 Send ( "q" )
;~ 		 Sleep (50)
;~ 		 Send ( "f" )
;~ 		 Sleep (50)
;~ 		 Send ( "w" )
;~ 		 Sleep (50)
;~ 		 Send ( "e" )
;~ 		 Sleep (50)
;~ 		 Send ( "r" )
;~ 		 Sleep (50)
;~ 		 Send ( "s" )
;~ 		 Sleep (50)
;~ 		 Send ( "d" )
;~ 		 Sleep (50)
;~ 		 if TimerDiff($hTimer) > 130000 Then
;~ 			Local $return = _ImageSearch($find_ListImage)
;~ 			If $return[0] == 1 Then
;~ 			   MouseMove($return[1], $return[2])
;~ 			   MouseClick("primary")
;~ 			   Sleep (1000)
;~ 			EndIf
;~ 			Local $return = _ImageSearch($find_ListImage)
;~ 			If $return[0] == 1 Then
;~ 			   MouseMove($return[1], $return[2])
;~ 			   MouseClick("primary")
;~ 			   Sleep (1000)
;~ 			   ExitLoop
;~ 			EndIf
;~ 		 EndIf
;~ 	  WEnd
;~ 	  $counter -= 1
;~    WEnd

EndFunc
