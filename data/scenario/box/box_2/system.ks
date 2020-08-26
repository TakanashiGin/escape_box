; メインシステム
[nowait]
#あなた
[eval exp="$.log(sf.stage_data.box_2)"]
[eval exp="tf.orientation = getOrientation()"]
[if exp="tf.orientation[1] == 'up'"]
    [if exp="sf.stage_data.box_2.status == 0"]
        天井の上に何か乗っているようだ
        [clickable x="0" y="0" width="1280" height="720" color="black" opacity="0" mouseopacity="100" storage="box/box_2/system.ks" target="roof"]
    [else]
        棒を使って天井の箱を床に落とした
    [endif]
[elsif exp="tf.orientation[1] == 'down'"]
    [if exp="sf.stage_data.box_2.status == 0"]
        床だ
    [else]
        天井にあった箱が壊れて[r]
        中に入っていたものが床に落ちている
    [endif]
[else]
    [if exp="tf.orientation[0] == 'front'"]
        謎を解かないとこの扉は開かない
    [elsif exp="tf.orientation[0] == 'back'"]
        さっきの部屋には戻れないようだ
    [elsif exp="tf.orientation[0] == 'left'"]
        「C4」って……[r]
        まさかこれって爆弾か！？
        [clickable x="300" y="360" width="680" height="360" color="black" opacity="0" mouseopacity="100" storage="box/box_2/system.ks" target="bomb_view1"]
    [elsif exp="tf.orientation[0] == 'right'"]
        [if exp="f.item.hold.length != 2"]
            何か置いてあるな
            [clickable x="300" y="200" width="680" height="520" color="black" opacity="0" mouseopacity="100" storage="box/box_2/system.ks" target="item"]
        [else]
            棒とハサミで一体何をすればいいんだ……？
        [endif]
    [endif]
[endif]
[endnowait]
[jump storage="main.ks" target="return_system"]





*roof
[cm][clearstack]
[clearfix]
[hide_message]
[playse storage="&sf.se.storage.click"]
[iscript]
const camera = tyrano.plugin.kag.tmp.three.camera;
const o = tf.orientation[0];
if (!tf.tmp_rot) {
    tf.tmp_rot = [
        camera.rotation.x,
        camera.rotation.y,
        camera.rotation.z
    ].join(',');
}
tf.pos = {
    x: o == 'front' || o == 'right'? 890 : 240,
    y: o == 'front' || o == 'left'? -30 : 600
};
[endscript]
[3d_anim name="camera" pos="0,-4,0" time="500"]
*return_roof
[clearfix]
[cm][clearstack]
[button name="down" target="back_main" exp="f.to_direction='down'" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&sf.se.storage.click"]
[if exp="sf.stage_data.box_2.status == 0"]
    [show_item_button name="scissors" hint="ハサミを持つ" storage="box/box_2/system.ks" target="return_roof"]
    [show_item_button name="bar" hint="棒を持つ" storage="box/box_2/system.ks" target="return_roof"]
    [clickable x="&tf.pos.x" y="&tf.pos.y" width="150" height="150" color="black" opacity="0" mouseopacity="0" storage="box/box_2/system.ks" target="fall_box"]
[endif]
[s]

*fall_box
[clearfix]
[cm][clearstack]
[jump target="no_item_roof" cond="f.item.hold.length == 0"]
[jump target="match_item" cond="f.item.current == 'bar'"]
[show_message]
[nowait]
ハサミでは何も出来ないようだ[p]
[endnowait]
[hide_message]
[jump target="return_roof"][s]

*no_item_roof
[show_message]
[nowait]
素手では届かないな[p]
[endnowait]
[hide_message]
[jump target="return_roof"][s]

*match_item
[show_message]
[nowait]
この棒を使えば天井に乗っている箱を取れそうだ[p]
[endnowait]
[hide_message]
; マスク中はタイマーを一時停止
[ctrl_circle_timer name="game_timer" content="stop" cond="sf.system.var.on_timer"]
[mask]
[eval exp="sf.stage_data.box_2.status++"]
[3d_hide name="s2hint_box" time="10" wait="false"]
[eval exp="tf.model = 's2hint_' + f.correct"]
[3d_show name="&tf.model" pos="2,-9,2" rot="&getRotate(90,0,20)" time="10" wait="false"]
[mask_off]
[ctrl_circle_timer name="game_timer" content="start" cond="sf.system.var.on_timer"]
[jump target="back_main"][s]





*item
[cm][clearstack]
[clearfix]
[hide_message]
[playse storage="&sf.se.storage.click"]
[iscript]
const camera = tyrano.plugin.kag.tmp.three.camera;
if (!tf.tmp_rot) {
    tf.tmp_rot = [
        camera.rotation.x,
        camera.rotation.y,
        camera.rotation.z
    ];
}
tf.rot = tf.tmp_rot.concat();
tf.rot[0] += getRadian(-15);
tf.tmp_rot = tf.tmp_rot.join(',');
[endscript]
[3d_anim name="camera" pos="2,0,0" rot="&tf.rot.join(',')" time="500"]
*return_item
[button name="down" target="back_main" exp="f.to_direction='down'" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&sf.se.storage.click"]
[clickable x="550" y="310" width="280" height="150" color="black" opacity="0" mouseopacity="0" storage="box/box_2/system.ks" target="get_scissors" cond="!f.item.checkGotItem('scissors')"]
[clickable x="275" y="0" width="140" height="450" color="black" opacity="0" mouseopacity="0" storage="box/box_2/system.ks" target="get_bar" cond="!f.item.checkGotItem('bar')"]
[s]

*get_scissors
[cm][clearstack]
[clearfix]
[get_item name="scissors"]
[3d_hide name="scissors" time="10"]
[jump target="return_item"]

*get_bar
[cm][clearstack]
[clearfix]
[get_item name="bar"]
[3d_hide name="bar" time="10"]
[jump target="return_item"]





*bomb_view1
[cm][clearstack]
[clearfix]
[show_message]
[playse storage="&sf.se.storage.click"]
[iscript]
const camera = tyrano.plugin.kag.tmp.three.camera;
if (!tf.tmp_rot) {
    tf.tmp_rot = [
        camera.rotation.x,
        camera.rotation.y,
        camera.rotation.z
    ];
}
tf.rot = tf.tmp_rot.concat();
tf.rot[0] += getRadian(-15);
tf.tmp_rot = tf.tmp_rot.join(',');
[endscript]
*return_bomb_view1
[cm][clearstack]
[clearfix]
[3d_anim name="camera" pos="-2,0,0" rot="&tf.rot.join(',')" time="500"]
[nowait]
[if exp="sf.stage_data.box_2.status == 0"]
    もしかして正しいワイヤーを切って爆弾を解除しないと[r]
    ここから出られない仕組みなのか？
[else]
    このハサミでワイヤーを切れば爆弾を解除出来そうだ[r]
    でもどのワイヤーを切ればいいんだ？
[endif]
[endnowait]
[button name="left" target="bomb_view2" exp="f.to_direction='left';tf.rot[1] += getRadian(-90);" graphic="left.png" x="&sf.button.left.x" y="&sf.button.left.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&sf.se.storage.click"]
[button name="down" target="back_main" exp="f.to_direction='down'" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&sf.se.storage.click"]
[s]





*bomb_view2
[cm][clearstack]
[clearfix]
[hide_message]
[playse storage="&sf.se.storage.click"]
[3d_anim name="camera" pos="-7.75,0,4" rot="&tf.rot.join(',')" time="500"]
*return_bomb_view2
[cm][clearstack]
[clearfix]
[hide_message]
[button name="right" target="back_bomb_view1" exp="f.to_direction='right';tf.rot[1] -= getRadian(-90);" graphic="right.png" x="&sf.button.right.x" y="&sf.button.right.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&sf.se.storage.click"]
[show_item_button name="scissors" hint="ハサミを持つ" storage="box/box_2/system.ks" target="return_bomb_view2"]
[show_item_button name="bar" hint="棒を持つ" storage="box/box_2/system.ks" target="return_bomb_view2"]
[clickable x="565" y="320" width="30" height="230" color="black" opacity="0" mouseopacity="0" storage="box/box_2/system.ks" target="cut_wire_r"]
[clickable x="615" y="320" width="30" height="230" color="black" opacity="0" mouseopacity="0" storage="box/box_2/system.ks" target="cut_wire_b"]
[clickable x="665" y="320" width="30" height="230" color="black" opacity="0" mouseopacity="0" storage="box/box_2/system.ks" target="cut_wire_y"]
[s]

*back_bomb_view1
[cm][clearstack]
[clearfix]
[show_message]
[playse storage="&sf.se.storage.click"]
[jump target="return_bomb_view1"]
[s]

*cut_wire_r
[eval exp="tf.cut_wire = 'r'"]
[jump target="cut_wire"][s]
*cut_wire_b
[eval exp="tf.cut_wire = 'b'"]
[jump target="cut_wire"][s]
*cut_wire_y
[eval exp="tf.cut_wire = 'y'"]
[jump target="cut_wire"][s]
*cut_wire
[cm][clearstack]
[clearfix]
[jump target="no_item" cond="f.item.hold.length == 0"]
[jump target="no_match_item_in_bomb" cond="f.item.current != 'scissors'"]
[iscript]
tf.model = 'bomb_wire_' + tf.cut_wire;
$.log('cut: ' + tf.cut_wire)
[endscript]
[3d_hide name="&tf.model" time="100"]
[wait time="1000"]
[jump target="correct" cond="tf.cut_wire == f.correct"]
[jump storage="main.ks" target="faild"][s]

*no_item
[no_hold_item_text]
[jump target="return_bomb_view2"]

*no_match_item_in_bomb
[show_message]
[nowait]
棒を使っても意味ない[p]
[endnowait]
[hide_message]
[jump target="return_bomb_view2"][s]





*correct
[iscript]
$.log('--> correct');
[endscript]
[3d_anim name="camera" pos="0,0,0" rot="&tf.tmp_rot"]
[wait time="100"]
[iscript]
f.to_direction = 'right';
delete tf.tmp_rot;
[endscript]
[direction_manager]
[jump storage="main.ks" target="next_room"][s]






*back_main
[cm][clearfix]
[clearfix]
[3d_anim name="camera" pos="0,0,0" rot="&tf.tmp_rot" time="500"]
[eval exp="tf.tmp_rot = null"]
[show_message]
[jump storage="main.ks" target="return"]
