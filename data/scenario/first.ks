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

@loadjs storage="../scenario/system/system.js"
@loadjs storage="../scenario/system/function.js"
@loadjs storage="../scenario/system/classies.js"
@loadjs storage="js/init.js"
@eval exp="f.played_tutorial = false"

@plugin name="for"
@plugin name="switch"
@plugin name="loadcsv"
@plugin name="circle_timer"
@plugin name="debug_three_model_by_key"
@plugin name="pmask"

@call storage="setup/loadcsv.ks"
@call storage="setup/macro/macro_main.ks"
@loadjs storage="../scenario/setup/media.js"
@call storage="setup/pmask.ks"

@jump storage="setup/preload.ks" cond="sf.system.var.preload"
*return_preload

@call storage="setup/novecole/novecole.ks"

*return_game
@cm
@clearstack

@jump storage="title.ks" cond="!sf.system.skip.title"
*return_title
@eval exp="sf.rafStop()"


; -- test -------------------------------------------------------------------
; ---------------------------------------------------------------------------


@jump storage="main.ks"
