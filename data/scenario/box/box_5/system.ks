; メインシステム





#
[iscript]
//$.log(f.to_direction);
if (f.to_direction) {
    const system = f.s5room_system;
    system.dir.push(f.to_direction);
    for (let i=0; i<system.dir.length; i++) {
        if (system.dir[i] != system.correct[i]) {
            system.dir = [];
            system.incorrect_se = !!tf.box5_first? false : true;
            break;
        }
    }
    if (system.dir.length == system.correct.length) {
        system.clear = true;
    }
}
$.log(f.s5room_system);
[endscript]

[if exp="f.s5room_system.incorrect_se"]
    [playse storage="&sf.se.storage.incorrect" cond="tf.box5_pass_first"]
    [eval exp="f.s5room_system.incorrect_se = false"]
[endif]
[eval exp="if (!tf.box5_first) tf.box5_pass_first = true"]

[jump target="clear" cond="f.s5room_system.clear"]





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
    床だ
[else]
    [if exp="tf.orientation[0] == 'front'"]
        謎を解かないとこの扉は開かない
    [elsif exp="tf.orientation[0] == 'back'"]
        さっきの部屋には戻れないようだ
    [elsif exp="tf.orientation[0] == 'left'"]
        矢印が４つ……？
        [clickable storage="box/box_5/system.ks" target="arrows" x="50" y="100" width="1180" height="520" color="black" opacity="0" mouseopacity="100"]
    [elsif exp="tf.orientation[0] == 'right'"]
        右の壁には何もない
    [endif]
[endif]
[endnowait]

[jump storage="main.ks" target="return_system"]





*arrows
[cm][clearstack]
[clearfix]
[playse storage="&sf.se.storage.click"]
[3d_anim name="camera" pos="1,0,0" time="500"]
[hide_message]
[button name="down" target="back_main" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true" clickse="&sf.se.storage.click"]
[s]

*back_main
[cm][clearstack]
[clearfix]
[3d_anim name="camera" pos="0,0,0" time="500"]
[show_message]
[jump storage="main.ks" target="return"]





*clear
[eval exp="$.log('-->_correct')"]
[playse storage="&sf.se.storage.correct"]
[wait time="500"]
[to_front]
[jump storage="main.ks" target="next_room"]
[s]
