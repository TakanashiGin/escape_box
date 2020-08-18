; メインシステム
[nowait]
#あなた
[eval exp="$.log(sf.stage_data.box_3)"]
[eval exp="tf.orientation = getOrientation()"]
[if exp="tf.orientation[1] == 'up'"]
    空が見える。[r]
    [switch exp="getTimeZone()"]
        [case is="day"]
            綺麗な「青」空だな
        [case is="sunset"]
            真っ「赤」な夕焼けだ
        [case is="night"]
            真っ「黒」な空の上で星が瞬いでいる
    [endswitch]
[elsif exp="tf.orientation[1] == 'down'"]
    [if exp="sf.stage_data.box_3.status == 0"]
        何か落ちているようだ
        [clickable x="0" y="0" width="1280" height="720" color="black" opacity="0" mouseopacity="100" storage="box/box_3/system.ks" target="hammer"]
    [else]
        このハンマーでなら「何か」を壊せそうだ
    [endif]
[else]
    [if exp="tf.orientation[0] == 'front'"]
        謎を解かないとこの扉は開かない。
    [elsif exp="tf.orientation[0] == 'back'"]
        さっきの部屋には戻れないようだ。
    [elsif exp="tf.orientation[0] == 'left'"]
        左の壁には何もない。
    [elsif exp="tf.orientation[0] == 'right'"]
        [if exp="sf.stage_data.box_3.status == 0"]
            箱が並べられている[r]
            何かで壊せそうだが……
        [else]
            手に入れたハンマーで壊せそうだ[r]
            でもどれを壊せばいいんだ？
        [endif]
        [clickable x="300" y="50" width="680" height="620" color="black" opacity="0" mouseopacity="100" storage="box/box_3/system.ks" target="start_event"]
    [endif]
[endif]
[endnowait]

[jump storage="main.ks" target="return_system"]





*hammer
[cm][clearstack]
[clearfix]
[hide_message]
[playse storage="&sf.se.storage.click"]
[iscript]
const o = tf.orientation[0];
tf.p = {};
tf.p.x = o == 'front' || o == 'left'? 650 : 475;
tf.p.y = o == 'front' || o == 'right'? 200 : 375;
[endscript]
[clickable x="&tf.p.x" y="&tf.p.y" width="150" height="150" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="get_item"]
[button name="down" target="back_main" exp="f.to_direction='down'" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&sf.se.storage.click"]
[s]

*get_item
[cm][clearfix]
[get_item name="hammer"]
[3d_hide name="hammer" time="10"]
[eval exp="sf.stage_data.box_3.status++"]
[jump target="back_main"]
[s]





*start_event
[cm][clearstack]
[clearfix]
[hide_message]
[3d_anim name="camera" pos="-1,0,0" time="500"]
[playse storage="&sf.se.storage.click"]
[clickable x="760" y="120" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box1" cond="!!f.boxies.map[0][0]"]
[clickable x="580" y="120" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box2" cond="!!f.boxies.map[0][1]"]
[clickable x="400" y="120" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box3" cond="!!f.boxies.map[0][2]"]
[clickable x="760" y="300" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box4" cond="!!f.boxies.map[1][0]"]
[clickable x="580" y="300" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box5" cond="!!f.boxies.map[1][1]"]
[clickable x="400" y="300" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box6" cond="!!f.boxies.map[1][2]"]
[clickable x="760" y="480" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box7" cond="!!f.boxies.map[2][0]"]
[clickable x="580" y="480" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box8" cond="!!f.boxies.map[2][1]"]
[clickable x="400" y="480" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box9" cond="!!f.boxies.map[2][2]"]
[button name="down" target="back_main" exp="f.to_direction='down'" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&sf.se.storage.click"]
[s]

*box1
[eval exp="tf.box_num = 1"]
[jump target="common"][s]
*box2
[eval exp="tf.box_num = 2"]
[jump target="common"][s]
*box3
[eval exp="tf.box_num = 3"]
[jump target="common"][s]
*box4
[eval exp="tf.box_num = 4"]
[jump target="common"][s]
*box5
[eval exp="tf.box_num = 5"]
[jump target="common"][s]
*box6
[eval exp="tf.box_num = 6"]
[jump target="common"][s]
*box7
[eval exp="tf.box_num = 7"]
[jump target="common"][s]
*box8
[eval exp="tf.box_num = 8"]
[jump target="common"][s]
*box9
[eval exp="tf.box_num = 9"]
[jump target="common"][s]

*common
[cm][clearstack]
[clearfix]
[jump target="no_item" cond="sf.stage_data.box_3.status == 0"]
[iscript]
const index = parseInt((tf.box_num-1)/3);
const box = tf.box_num - 1 - (3 * index);
tf.box = f.boxies.map[index][box];
tf.obj = 's3' + tf.box;
f.boxies.broke.push(tf.box);
f.boxies.map[index][box] = null;
$.log(f.boxies);
[endscript]
[3d_hide name="&tf.obj" time="10"]
[jump storage="main.ks" target="faild" cond="f.boxies.broke.filter(v => f.boxies.correct.indexOf(v) < 0).length > 0"]
[jump target="correct" cond="f.boxies.broke.filter(v => f.boxies.correct.indexOf(v) != -1).length == 3"]
[jump target="start_event"][s]

*no_item
[no_hold_item_text]
[jump target="start_event"]

*correct
[iscript]
$.log('--> correct');
[endscript]
[playse storage="&sf.se.storage.correct"]
[3d_anim name="camera" pos="0,0,0"]
[eval exp="f.to_direction = 'left'"]
[direction_manager]
[jump storage="main.ks" target="next_room"]





*back_main
[cm][clearfix]
[clearfix]
[show_message]
[3d_anim name="camera" pos="0" time="500" cond="tyrano.plugin.kag.tmp.three.camera.position.x != 0"]
[jump storage="main.ks" target="return"]
