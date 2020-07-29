[iscript]
sf.title = 'Escape Box';
[endscript]
[title name="&sf.title"]

@stop_keyconfig
@hidemenubutton
@layopt layer="message0" visible="false"
@layopt layer="message1" visible="false"
@layopt layer="0" visible="true"
@layopt layer="1" visible="true"
@layopt layer="2" visible="true"
@layopt layer="fix" visible="true"

@loadjs storage="js/init.js"
@loadjs storage="../scenario/system/system.js"
@loadjs storage="../scenario/system/function.js"
@loadjs storage="../scenario/system/classies.js"

@plugin name="for"
@plugin name="switch"
@plugin name="loadcsv"
@plugin name="circle_timer"
@plugin name="debug_three_model_by_key"

@call storage="setup/loadcsv.ks"
@call storage="setup/macro/macro_main.ks"

*return_game
@cm
@clearstack

@jump storage="title.ks" cond="!sf.skip.title"
*return_title
@eval exp="sf.rafStop()"


; -- test -------------------------------------------------------------------
; ---------------------------------------------------------------------------


@jump storage="main.ks"
