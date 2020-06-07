[plugin name="fall_mask"]

[chara_new  name="akane" storage="chara/akane/normal.png" jname="あかね"]
[chara_face name="akane" face="angry" storage="chara/akane/angry.png"]
[chara_face name="akane" face="doki" storage="chara/akane/doki.png"]
[chara_face name="akane" face="happy" storage="chara/akane/happy.png"]
[chara_face name="akane" face="sad" storage="chara/akane/sad.png"]

[macro name="add_window"]
  [iscript]
  tf.top = $('#tyrano_base').height() - 300 - 25;
  tf.width = $('#tyrano_base').width() - 50;
  [endscript]
  [position layer="message0" left="25" top="&tf.top" width="&tf.width" height="300"]
[endmacro]

; 初期化
@add_window
@layopt layer="message0" visible="true"
@bg storage="room.jpg" time="1"
@chara_show name="akane" time="1"

クリックしてください。[p]

[fall_mask color="yellow"]

[s]
