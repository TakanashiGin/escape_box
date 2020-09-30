; メインシステム
[nowait]
#あなた
[eval exp="$.log(sf.stage_data.box_3)"]
[eval exp="tf.orientation = getOrientation()"]
[if exp="tf.orientation[1] == 'up'"]
    空が見える[r]
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
        [iscript]
        const o = tf.orientation[0];
        tf.p = {};
        tf.p.x = o == 'front' || o == 'left'? 650 : 475;
        tf.p.y = o == 'front' || o == 'right'? 200 : 375;
        [endscript]
        [clickable x="&tf.p.x" y="&tf.p.y" width="150" height="150" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="get_item"]
    [else]
        このハンマーでなら「何か」を壊せそうだ
    [endif]
[else]
    [if exp="tf.orientation[0] == 'front'"]
        謎を解かないとこの扉は開かない
    [elsif exp="tf.orientation[0] == 'back'"]
        さっきの部屋には戻れないようだ
    [elsif exp="tf.orientation[0] == 'left'"]
        これはさっきと同じパネルか
        [clickable storage="box/box_3/system.ks" target="panel_first" x="470" y="65" width="340" height="570" color="black" opacity="0" mouseopacity="100"]
    [elsif exp="tf.orientation[0] == 'right'"]
        [if exp="sf.stage_data.box_3.status == 0"]
            箱が並べられている[r]
            何かで壊せそうだが……
        [elsif exp="sf.stage_data.box_3.status == 1"]
            手に入れたハンマーで壊せそうだ[r]
            でもどれを壊せばいいんだ？
        [else]
            箱を壊したら数字が出てきたけど、順番が分からないな[r]
            番号が合っていたらテキトーでいいのか
        [endif]
        [clickable x="300" y="50" width="680" height="620" color="black" opacity="0" mouseopacity="100" storage="box/box_3/system.ks" target="start_event"]
    [endif]
[endif]
[endnowait]

[jump storage="main.ks" target="return_system"]





*get_item
[cm][clear_button]
[get_item name="hammer"]
[3d_hide name="hammer" time="10"]
[eval exp="sf.stage_data.box_3.status++"]
[jump target="back_main"]
[s]





*start_event
[pse name="click"]
*return_event
[cm][clearstack]
[clear_button]
[hide_message]
[3d_anim name="camera" pos="-1,0,0" time="500"]
[clickable x="760" y="120" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box1" cond="!!f.s3boxies.map[0][0]"]
[clickable x="580" y="120" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box2" cond="!!f.s3boxies.map[0][1]"]
[clickable x="400" y="120" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box3" cond="!!f.s3boxies.map[0][2]"]
[clickable x="760" y="300" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box4" cond="!!f.s3boxies.map[1][0]"]
[clickable x="580" y="300" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box5" cond="!!f.s3boxies.map[1][1]"]
[clickable x="400" y="300" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box6" cond="!!f.s3boxies.map[1][2]"]
[clickable x="760" y="480" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box7" cond="!!f.s3boxies.map[2][0]"]
[clickable x="580" y="480" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box8" cond="!!f.s3boxies.map[2][1]"]
[clickable x="400" y="480" width="120" height="120" color="black" opacity="0" mouseopacity="0" storage="box/box_3/system.ks" target="box9" cond="!!f.s3boxies.map[2][2]"]
[button name="down" target="back_main" exp="f.to_direction='down'" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&getSe()"]
[cbk dir="down" storage="box/box_3/system.ks" target="back_main"]
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
[clear_button]
[jump target="no_item" cond="sf.stage_data.box_3.status == 0"]
[iscript]
const index = parseInt((tf.box_num-1)/3);
const box = tf.box_num - 1 - (3 * index);
tf.box = f.s3boxies.map[index][box];
tf.obj = 's3' + tf.box;
f.s3boxies.map[index][box] = null;
$.log(f.s3boxies);
[endscript]
[pse name="break_box"]
[3d_hide name="&tf.obj" time="10"]
[eval exp="sf.stage_data.box_3.status++"]
[jump target="return_event"]
[s]

*no_item
[no_hold_item_text]
[jump target="return_event"]





*panel_first
[pse name="click"]
*panel
[cm][clearstack]
[clear_button]
[3d_anim name="camera" pos="-1,0,0" time="500"]
*return_panel
[hide_message]
[button name="down" target="back_main" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&getSe()"]
[for name="tf.i" from="0" len="3" deep="0"]
    [for name="tf.j" from="0" len="3" deep="1"]
        [iscript]
        tf.num = 1 + tf.j + (3 * tf.i);
        tf.name = `num${tf.num},num_button`;
        tf.x = 480 + (107*tf.j);
        tf.y = 200 + (107*tf.i);
        [endscript]
        [button name="&tf.name" target="push_num" exp="tf.push_num=preexp;" preexp="&tf.num" graphic="../fgimage/color/empty.png" x="&tf.x" y="&tf.y" width="100" height="100" fix="true"]
    [nextfor]
[nextfor]
[button name="ok" target="ok" graphic="../fgimage/color/empty.png" x="534" y="526" width="100" height="100" fix="true"]
[button name="back" target="back" graphic="../fgimage/color/empty.png" x="641" y="526" width="100" height="100" fix="true"]
[cbk dir="down" storage="box/box_3/system.ks" target="back_main"]
[s]

*push_num
[cm][clearstack]
[clear_button]
[iscript]
$.log(`push ${tf.push_num}`);
tf.num_obj = `s3num${tf.push_num}`;
tf.bool = f.s3panel.pushed_num.includes(tf.push_num);
f.s3panel.pushed_num.push(tf.push_num);
f.s3panel.pushed_obj.push(tf.num_obj);
switch (f.s3panel.pushed_num.length) {
    case 1: tf.pos = '-9.1,2.15,1.29'; break;
    case 2: tf.pos = '-9.1,2.15,0.43'; break;
    case 3: tf.pos = '-9.1,2.15,-0.43'; break;
    case 4: tf.pos = '-9.1,2.15,-1.29'; break;
}
[endscript]
[jump target="incorrect" cond="f.s3panel.pushed_num.length == 5 || tf.bool"]
[pse name="push_button"]
[3d_show name="&tf.num_obj" pos="&tf.pos" rot="&getRotate(0,90,0)" scale="0.85,0.85,0.01" time="10" wait="false"]
[wait time="10"]
[jump target="return_panel"]

*ok
[cm][clearstack]
[clear_button]
[jump target="correct" cond="f.s3panel.pushed_num.filter(val => f.s3number.correct.includes(val)).length == 3 && f.s3panel.pushed_num.length == 3"]
[jump target="incorrect"]

*back
[cm][clearstack]
[clear_button]
[if exp="f.s3panel.pushed_num.length != 0"]
    [eval exp="tf.model = f.s3panel.pushed_obj[f.s3panel.pushed_obj.length-1]"]
    [3d_hide name="&tf.model" time="10" wait="false"]
    [iscript]
    f.s3panel.pushed_num.pop();
    f.s3panel.pushed_obj.pop();
    [endscript]
    [wait time="10"]
[endif]
[jump target="panel"]

*correct
[iscript]
$.log('--> correct');
[endscript]
[pse name="correct"]
[3d_anim name="camera" pos="0,0,0"]
[eval exp="f.to_direction = 'right'"]
[direction_manager]
[jump storage="main.ks" target="next_room"]

*incorrect
[pse name="incorrect"]
[for name="tf.i" from="0" len="&f.s3panel.pushed_obj.length" deep="1"]
    [eval exp="tf.model = f.s3panel.pushed_obj[tf.i]"]
    [3d_hide name="&tf.model" time="10" wait="false"]
[nextfor]
[iscript]
f.s3panel.pushed_num = [];
f.s3panel.pushed_obj = [];
[endscript]
[jump target="panel"]





*back_main
[cm][clear_button]
[clear_button]
[show_message]
[3d_anim name="camera" pos="0" time="500" cond="tyrano.plugin.kag.tmp.three.camera.position.x != 0"]
[jump storage="main.ks" target="return"]
