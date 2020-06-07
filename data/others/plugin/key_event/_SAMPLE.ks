
; プラグイン読み込み
[plugin name="key_event"]

[layopt layer="message0" visible="false"]
[layopt layer="message1" visible="false"]
[layopt layer="fix" visible="false"]
[layopt layer="0" visible="true"]
[layopt layer="1" visible="false"]
[layopt layer="2" visible="false"]

; イベントを全て削除（clear=falseを除く）
[clear_key_event]

; config
[key_event name="config" clear="false" method="keydown" key_code="67" storage="config.ks"]

; ESCキー（強制終了）
[key_event name="window_close" clear="false" method="keydown" key_code="27" target="game_end"]

; F11キー（スクリーンモード切替）
[key_event name="screen_full" clear="false" method="keydown" key_code="122" exp="screenFull()"]

; Nキー
[eval exp="tf.num = 10"]
[key_event name="alp" clear="true" method="keydown" key_code="78" exp="tf.num++;console.log(tf.num);"]

; 左クリックでジャンプ
[key_event name="clk" clear="true" method="click" target="click_target"]

; element指定（右クリック）
[image name="elem" layer="0" storage="../fgimage/color/col1.png" x="540" y="260" width="200" height="200" time="1"]
[key_event name="elem" element=".elem" clear="true" method="right_click" exp="elem_event.click()" mouseover_exp="elem_event.mouseover()" mouseout_exp="elem_event.mouseout()"]

; for文
[eval exp="tf.i = 0"]
*nextfor
[iscript]
tf.name = 'num' + tf.i;
tf.key_code = 49 + (tf.i-1);
[endscript]
[key_event name="&tf.name" clear="true" method="keyup" key_code="&tf.key_code" exp="console.log(preexp)" preexp="&tf.i"]
[eval exp="tf.i++"]
[jump target="nextfor" cond="tf.i <= 5"]


*return
[s]


*click_target
[clear_key_event name="alp"]
[iscript]
tf.num += 10;
console.log('tf.num += 10');
[endscript]
[key_event name="alp" clear="true" method="keydown" key_code="78" exp="tf.num++;console.log(tf.num);"]
[jump target="return"]


; ゲームを終了します
*game_end
[clear_key_event reset="true"]
[iscript]
console.log("クリックすると終了します");
[endscript]

[l]

[close ask="false"]
