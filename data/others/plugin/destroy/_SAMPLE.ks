[plugin name="destroy"]

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

クリックしてください。[l]

[destroy avoid="0,message0,fix"]

0とmessage0とfixレイヤーを残して全て削除・非表示にしました。[p]

[destroy avoid="message0"]

message0だけを残して全て削除・非表示にしました。[p]

[destroy layer="message0"]

[iscript]
alert('message0だけを指定して全て削除しました');
[endscript]

@add_window
@layopt layer="message0" visible="true"
@bg storage="room.jpg" time="1"
@chara_show name="akane" time="1"

以上です[s]
