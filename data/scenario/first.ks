[iscript]
sf.title = 'Escape Box';
[endscript]
[title name="&sf.title"]

[stop_keyconfig]
[hidemenubutton]
[layopt layer="message0" visible="false"]
[layopt layer="message1" visible="false"]
[layopt layer="0" visible="true"]
[layopt layer="1" visible="false"]
[layopt layer="2" visible="false"]
[layopt layer="fix" visible="true"]

@loadjs storage="../scenario/system/system.js"
@loadjs storage="../scenario/system/function.js"
@loadjs storage="../scenario/system/classies.js"

@plugin name="for"
@plugin name="loadcsv"
@plugin name="circle_timer"

@3d_init layer="0"
@3d_anim name="camera" pos="0,0,0" time="10"

@call storage="setup/tyrano.ks"
@call storage="setup/loadcsv.ks"
@call storage="setup/macro/macro_main.ks"

@jump storage="main.ks"
