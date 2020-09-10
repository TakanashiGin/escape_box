; メインシステム
[nowait]
#あなた
[eval exp="tf.orientation = getOrientation()"]
[if exp="tf.orientation[1] == 'up'"]
    空が見える[r]
    [switch exp="getTimeZone()"]
        [case is="day"]
            せっかく良い天気なのになぁ
        [case is="sunset"]
            もう夕方じゃないか
        [case is="night"]
            もうすっかり夜じゃないか
    [endswitch]
[elsif exp="tf.orientation[1] == 'down'"]
    [if exp="f.item.hold.length == 5"]
        床に転がっていた箱は一体なんなのだろう
    [else]
        床に箱が転がっている
    [endif]
    [clickable x="0" y="0" width="1280" height="720" color="black" opacity="0" mouseopacity="100" storage="box/box_4/system.ks" target="take_box"]
[else]
    [if exp="tf.orientation[0] == 'front'"]
        謎を解かないとこの扉は開かない
    [elsif exp="tf.orientation[0] == 'back'"]
        さっきの部屋には戻れないようだ
    [elsif exp="tf.orientation[0] == 'left'"]
        この「てんびん」は一体……？
        [clickable x="350" y="150" width="&1280-700" height="&720-300" color="black" opacity="0" mouseopacity="100" storage="box/box_4/system.ks" target="balance_main"]
    [elsif exp="tf.orientation[0] == 'right'"]
        これは何かの「重さ」か……？
        [clickable x="500" y="150" width="280" height="420" color="black" opacity="0" mouseopacity="100" storage="box/box_4/system.ks" target="hint"]
    [endif]
[endif]
[endnowait]

[jump storage="main.ks" target="return_system"]





*hint
[cm][clearstack]
[clear_button]
[hide_message]
[playse storage="&sf.se.storage.click"]
[iscript]
const camera = tyrano.plugin.kag.tmp.three.camera;
if (!tf.tmp_rot) {
    tf.tmp_rot = [
        camera.rotation.x,
        camera.rotation.y,
        camera.rotation.z
    ].join(',');
}
[endscript]
[3d_anim name="camera" pos="1,0,0" time="500"]
[button name="down" target="back_main" exp="f.to_direction='down'" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&sf.se.storage.click"]
[cbk dir="down" storage="box/box_4/system.ks" target="back_main"]
[s]





*take_box
[cm][clearstack]
[clear_button]
[hide_message]
[playse storage="&sf.se.storage.click"]
[iscript]
const camera = tyrano.plugin.kag.tmp.three.camera;
if (!tf.tmp_rot) {
    tf.tmp_rot = [
        camera.rotation.x,
        camera.rotation.y,
        camera.rotation.z
    ].join(',');
}
tf.to_rot = [-0.94,0.46,0].map((to,i) => {
    to = getMeasuringDegrees(to);
    let from = getMeasuringDegrees(tf.tmp_rot.split(',')[i]);
    if (i == 1 && ((from/360) - parseInt(from/360)) * 360 == -270) to = 30 + ((from/360) * 360) - 90;
    else to += parseInt(from/360) * 360;
    return getRadian(to);
}).join(',');
[endscript]
[3d_anim name="camera" pos="5,2,5" rot="&tf.to_rot" scale="1,1,1" time="500"]
*return_take_box
[cm][clearstack]
[clear_button]
[clickable x="980" y="320" width="100" height="100" color="black" opacity="0" mouseopacity="0" target="take_box1" cond="f.item.hold.filter(v => v.name == 'box1').length != 1"]
[clickable x="770" y="460" width="100" height="100" color="black" opacity="0" mouseopacity="0" target="take_box2" cond="f.item.hold.filter(v => v.name == 'box2').length != 1"]
[clickable x="460" y="360" width="100" height="100" color="black" opacity="0" mouseopacity="0" target="take_box3" cond="f.item.hold.filter(v => v.name == 'box3').length != 1"]
[clickable x="630" y="320" width="100" height="100" color="black" opacity="0" mouseopacity="0" target="take_box4" cond="f.item.hold.filter(v => v.name == 'box4').length != 1"]
[clickable x="550" y="240" width="100" height="100" color="black" opacity="0" mouseopacity="0" target="take_box5" cond="f.item.hold.filter(v => v.name == 'box5').length != 1"]
[button name="down" target="back_main" exp="f.to_direction='down'" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&sf.se.storage.click"]
[cbk dir="down" storage="box/box_4/system.ks" target="back_main" view="item"]
[s]





*take_box1
[eval exp="tf.take_box_num = 1"]
[jump target="common_take_box"]
*take_box2
[eval exp="tf.take_box_num = 2"]
[jump target="common_take_box"]
*take_box3
[eval exp="tf.take_box_num = 3"]
[jump target="common_take_box"]
*take_box4
[eval exp="tf.take_box_num = 4"]
[jump target="common_take_box"]
*take_box5
[eval exp="tf.take_box_num = 5"]
[jump target="common_take_box"]

*common_take_box
[clear_button]
[iscript]
tf.model = `s4box${tf.take_box_num}`;
tf.item = 'box' + tf.take_box_num;
[endscript]
[3d_hide name="&tf.model" time="10"]
[get_item name="&tf.item"]
[jump target="return_take_box"]
[s]




*balance_main
[cm][clearstack]
[clear_button]
[hide_message]
[playse storage="&sf.se.storage.click"]
[iscript]
const camera = tyrano.plugin.kag.tmp.three.camera;
if (!tf.tmp_rot) {
    tf.tmp_rot = [
        camera.rotation.x,
        camera.rotation.y,
        camera.rotation.z
    ].join(',');
}
[endscript]
[3d_anim name="camera" pos="-1,1,0" time="500"]
*return_take_balance_main
[clear_button]
[cm][clearstack]
[button name="down" target="back_main" exp="f.to_direction='down'" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&sf.se.storage.click"]
[show_item_button name="box1" hint="白いタイルの箱を持つ" storage="box/box_4/system.ks" target="return_take_balance_main"]
[show_item_button name="box2" hint="茶色のタイルの箱を持つ" storage="box/box_4/system.ks" target="return_take_balance_main"]
[show_item_button name="box3" hint="丸いタイルの箱を持つ" storage="box/box_4/system.ks" target="return_take_balance_main"]
[show_item_button name="box4" hint="赤茶色のタイルの箱を持つ" storage="box/box_4/system.ks" target="return_take_balance_main"]
[show_item_button name="box5" hint="石の箱を持つ" storage="box/box_4/system.ks" target="return_take_balance_main"]
[iscript]
switch(f.s4balance.mode){
    case 'right':
        tf.pos = {
            right: { x:780, y:400 },
            left: { x:370, y:180 }
        };
        break;
    case 'left':
        tf.pos = {
            right: { x:780, y:180 },
            left: { x:370, y:400 }
        };
        break;
    default:
        tf.pos = {
            right: { x:800, y:280 },
            left: { x:350, y:280 }
        };
        break;
}
[endscript]
[clickable x="&tf.pos.right.x" y="&tf.pos.right.y" width="125" height="125" color="black" opacity="0" mouseopacity="&f.s4balance.disc.right.box != null? 0 : 100" target="put_box_on_right_disc"]
[clickable x="&tf.pos.left.x" y="&tf.pos.left.y" width="125" height="125" color="black" opacity="0" mouseopacity="&f.s4balance.disc.left.box != null? 0 : 100" target="put_box_on_left_disc"]
[cbk dir="down" storage="box/box_4/system.ks" target="back_main"]
[s]

*put_box_on_right_disc
[iscript]
tf.tmp_pos = f.box_right;
tf.put = 'right';
[endscript]
[jump target="common_put_box_on_disc"][s]

*put_box_on_left_disc
[iscript]
tf.tmp_pos = f.box_left;
tf.put = 'left';
[endscript]
[jump target="common_put_box_on_disc"][s]

*common_put_box_on_disc
[cm][clearstack]
[clear_button]
[if exp="!!f.s4balance.disc[tf.put]['box']"]
    [iscript]
    tf.item = f.s4balance.disc[tf.put]['box'];
    tf.model = 's4' + tf.item;
    f.s4balance.disc[tf.put]['box'] = null;
    [endscript]
    [get_item name="&tf.item"]
    [3d_hide name="&tf.model"]
[else]
    [jump target="no_hold_item" cond="f.item.hold.length <= 0"]
    [use_current_item var="tf.item"]
    [iscript]
    f.s4balance.disc[tf.put]['box'] = tf.item;
    tf.model = 's4' + tf.item;
    [endscript]
    [playse storage="&sf.se.storage.put_block"]
    [3d_show name="&tf.model" pos="&tf.tmp_pos" rot="0" time="10"]
    [delete_item name="&tf.item"]
[endif]
[eval exp="tf.correct = false"]
[if exp="!f.s4balance.disc.right.box && !f.s4balance.disc.left.box"]
    [balance weight="horizon"]
[elsif exp="!f.s4balance.disc.right.box"]
    [balance weight="left"]
[elsif exp="!f.s4balance.disc.left.box"]
    [balance weight="right"]
[else]
    [if exp="f.s4balance.boxies[f.s4balance.disc.right.box].weight > f.s4balance.boxies[f.s4balance.disc.left.box].weight"]
        [balance weight="right"]
        [playse storage="&sf.se.storage.incorrect"]
    [elsif exp="f.s4balance.boxies[f.s4balance.disc.right.box].weight < f.s4balance.boxies[f.s4balance.disc.left.box].weight"]
        [balance weight="left"]
        [playse storage="&sf.se.storage.incorrect"]
    [else]
        [balance weight="horizon"]
        [playse storage="&sf.se.storage.correct"]
        [eval exp="tf.correct = true"]
    [endif]
[endif]
[jump target="correct" cond="tf.correct"]
[jump target="return_take_balance_main"][s]

*no_hold_item
[cm][clearstack]
[no_hold_item_text]
[jump target="return_take_balance_main"][s]





*back_main
[cm][clear_button]
[clear_button]
[3d_anim name="camera" pos="0,0,0" rot="&tf.tmp_rot" time="500"]
[eval exp="tf.tmp_rot = null"]
[show_message]
[jump storage="main.ks" target="return"]





*correct
[iscript]
$.log('--> correct');
[endscript]
[3d_anim name="camera" pos="0,0,0"]
[eval exp="f.to_direction = 'right'"]
[direction_manager]
[jump storage="main.ks" target="next_room"]
