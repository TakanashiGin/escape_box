

; plugin
[plugin name="turn_page"]


; layer option
[layopt layer="message0" visible="false"]
[layopt layer="message1" visible="false"]
[layopt layer="0" visible="true"]
[layopt layer="1" visible="false"]
[layopt layer="2" visible="false"]
[layopt layer="fix" visible="false"]


; setting
[iscript]
f.width = $('#tyrano_base').width() / 2;
f.height = $('#tyrano_base').height() / 2;
[endscript]

; start bookblock
[iscript]
f.turn_page = true;
f.storage = [
  "color/col1.png",
  "color/col2.png",
  "color/col3.png",
  "color/col4.png",
  "color/col5.png",
];
[endscript]
[turn_page layer="0" storage='&f.storage' left="&f.width/2" top="&f.height/2" width="&f.width" height="&f.height"]


[l]
[control_page content="next"]

[l]
[control_page content="next"]

[l]
[control_page content="next"]

[l]
[control_page content="prev"]

[l]
[control_page content="last"]

[l]
[control_page content="remove"]
[eval exp="f.turn_page = false"]
; freeタグ freeimageタグも可（nameにはturn_page_base・その場合は[clear_turn_page]を必ず実行）
; [free name="turn_page_base" layer="0" time="1000"]
; [clear_turn_page]


[s]
