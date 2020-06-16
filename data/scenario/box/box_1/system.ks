; debug

;[3d_debug_camera]
;[s]

; メインシステム
[nowait]
#あなた
[eval exp="tf.orientation = getOrientation()"]
[if exp="tf.orientation[1] == 'up'"]
    空が見える。[r]
    [switch exp="getTimeZone()"]
        [case is="day"]
            せっかく良い天気なのになぁ
        [case is="sunset"]
            もう夕方じゃないか
        [case is="night"]
            もうすっかり夜じゃないか
    [endswitch]
[elsif exp="tf.orientation[1] == 'down'"]
    床だ。
[else]
    [if exp="tf.orientation[0] == 'front'"]
        謎を解かないとこの扉は開かない。
    [elsif exp="tf.orientation[0] == 'back'"]
        さっきの部屋には戻れないようだ。
    [elsif exp="tf.orientation[0] == 'left'"]
        箱が３つ……？
        [clickable x="200" y="300" width="850" height="250" color="black" opacity="0" mouseopacity="100" storage="box/box_1/system.ks" target="start_event"]
    [elsif exp="tf.orientation[0] == 'right'"]
        右の壁には何もない。
    [endif]
[endif]
[endnowait]

[jump storage="main.ks" target="return_system"]


*start_event
[clearfix]
[hide_message]
[3d_anim name="camera" pos="1,0,0"]
*return_event
;[eval exp="console.log(f.item)"]
[clearfix]
[clickable x="220" y="330" width="270" height="230" color="black" opacity="0" mouseopacity="0" target="click_box1"]
[clickable x="520" y="330" width="240" height="230" color="black" opacity="0" mouseopacity="0" target="click_box2"]
[clickable x="790" y="330" width="270" height="230" color="black" opacity="0" mouseopacity="0" target="click_box3"]
[button name="down" target="back_main" exp="f.to_direction='down'" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&sf.button_size" height="&sf.button_size" fix="true"]
[show_item_button name="box1" hint="赤色の箱を持つ" storage="box/box_1/system.ks" target="return_event"]
[show_item_button name="box2" hint="青色の箱を持つ" storage="box/box_1/system.ks" target="return_event"]
[show_item_button name="box3" hint="緑色の箱を持つ" storage="box/box_1/system.ks" target="return_event"]
[s]

*click_box1
[iscript]
//console.log('--> click box1');
tf.num = 0;
[endscript]
[jump target="common_box"]

*click_box2
[iscript]
//console.log('--> click box2');
tf.num = 1;
[endscript]
[jump target="common_box"]

*click_box3
[iscript]
//console.log('--> click box3');
tf.num = 2;
[endscript]
[jump target="common_box"]

*common_box
[cm][clearstack]
[clearfix]
;[eval exp="console.log(f.item.current == 'box1' || f.item.current == 'box2' || f.item.current == 'box3')"]
[if exp="f.qbox.box[tf.num] != null"]
    [get_item name="&f.qbox.box[tf.num]"]
    [iscript]
    tf.n = `s1${f.qbox.box[tf.num]}`;
    f.qbox.box[tf.num] = null;
    [endscript]
    [3d_hide name="&tf.n" time="10"]
[elsif exp="f.item.current == 'box1' || f.item.current == 'box2' || f.item.current == 'box3' || f.item.hold.length > 0"]
    [use_current_item var="tf.item"]
    [iscript]
    f.qbox.box[tf.num] = tf.item;
    tf.n = `s1${tf.item}`;
    tf.p = f.qbox.pos[tf.num];
    [endscript]
    [delete_item name="&tf.item"]
    [3d_show name="&tf.n" pos="&tf.p" time="10"]
[else]
    [no_hold_item_text]
[endif]
;[eval exp="console.log(f.qbox)"]
[iscript]
tf.bool = true;
for (let i=0; i<f.qbox.box.length; i++) {
    if (f.qbox.box[i] != f.qbox.correct[i]) tf.bool = false;
}
[endscript]
[jump target="return_event" cond="!tf.bool"]
[jump target="correct" cond="tf.bool"]
[s]


*back_main
[clearfix]
[3d_anim name="camera" pos="0,0,0"]
[show_message]
[jump storage="main.ks" target="return"]


*correct
[iscript]
console.log('--> correct');
[endscript]
[3d_anim name="camera" pos="0,0,0"]
[eval exp="f.to_direction = 'left'"]
[direction_manager]
[jump storage="main.ks" target="next_room"]
