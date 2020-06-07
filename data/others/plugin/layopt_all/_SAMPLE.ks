[plugin name="layopt_all"]

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

[layopt_all avoid="message0,fix" base="true" console="true"]

message0とfixを残して全てのレイヤーを非表示[p]

[layopt_all visible="true" avoid="message1,1,2" base="true" fix="true"]

baseと0を表示[p]

[layopt_all avoid="0" base="true"]
[iscript]
alert('0を残して全てのレイヤーを非表示\n（クリックで進行）');
[endscript]

[l]

[layopt_all all="true"]

[iscript]
alert('全て非表示\n（クリックで進行）');
[endscript]

[l]

[layopt_all visible="true" all="true"]

config.tjsに登録されている全てのレイヤーを表示[p]
終了[s]
