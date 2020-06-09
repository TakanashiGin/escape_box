[jump target="skip_tutorial" cond="sf.skip.tutorial == true"]

[switch exp="sf.stage_data.box_0.status"]
    [case is="0"]
        #？？？
        『やっほー、起きた？』[p]
        『え？
        _ どこから話しかけているかって？』[p]
        『後ろだよ、後ろー』[p]
        『[graph storage="left_sub.png"]か[graph storage="right_sub.png"]で左右に振り向けるよ』[p]
        #
        [eval exp="sf.stage_data.box_0.status++"]
    [case is="1"]
        [eval exp="tf.deg_y = getMeasuringDegrees(tyrano.plugin.kag.tmp.three.camera.rotation.y)"]
        [if exp="tf.deg_y % 180 == 0 && tf.deg_y != 0"]
            [3d_show name="akane_happy" pos="0,0,9" scale="2.5,4,1" time="700"]
            #アカネ
            『やっほー、アカネだよ』[p]
            [3d_anim name="camera" pos="0,0,1" time="300"]
            [mod_sprite name="akane_normal" hide_name="akane_happy" pos="0,0,9" scale="2.5,4,1" time="10"]
            『びっくりした？』[p]
            『え？
            _ ここはどこかって？』[p]
            [mod_sprite name="akane_happy" hide_name="akane_normal" pos="0,0,9" scale="2.5,4,1" time="10"]
            『――――知りたい？』[p]
            [mod_sprite name="akane_normal" hide_name="akane_happy" pos="0,0,9" scale="2.5,4,1" time="10"]
            [nowait]
            『ここは……』
            [3d_anim name="camera" pos="0,0,2" time="1"][p]
            『なんと……！』
            [3d_anim name="camera" pos="0,0,3" time="1"][p]
            『なんとなんとなんと……！！』
            [3d_anim name="camera" pos="0,0,4" time="1"][p]
            [mod_sprite name="akane_happy" hide_name="akane_normal" pos="0,0,9" scale="2.5,4,1" time="10"]
            [font size="40"]『謎解きをしないと[r]
            _ 出られない部屋でーす！』[resetfont]
            [3d_anim name="camera" pos="0,0,5" time="1"][p]
            [endnowait]
            [3d_anim name="camera" pos="0,0,1" time="300"]
            [mod_sprite name="akane_normal" hide_name="akane_happy" pos="0,0,9" scale="2.5,4,1" time="10"]
            『といってもギミックはそんなに難しいものではないから、[r]
            _ 心配しなくても大丈夫だよ』[p]
            『右を向いてみて』[p]
            #
            [eval exp="f.to_direction = 'right'"]
            [3d_anim name="camera" pos="0" wait="false"]
            [direction_manager]
            #アカネ
            『いかにも怪しそうなパネルがあるねぇ、なんだろうねぇ』[p]
            『さらに右を向いてみて』[p]
            #
            [eval exp="f.to_direction = 'right'"]
            [direction_manager]
            #アカネ
            『謎を解いたら、この扉が開いて次の部屋に進むよ』[p]
            #
            [eval exp="f.to_direction = 'left'"]
            [direction_manager][direction_manager]
            [mod_sprite name="akane_doki" hide_name="akane_normal" pos="0,0,9" scale="2.5,4,1" time="10"]
            #アカネ
            『そうそう、言い忘れてたけど、制限時間以内に脱出できないと部屋が爆発しちゃうから気を付けてね』[p]
            [mod_sprite name="akane_happy" hide_name="akane_doki" pos="0,0,9" scale="2.5,4,1" time="10"]
            『それじゃ、頑張ってねぇ～』[p]
            #
            [3d_hide name="akane_happy" time="10"]
            [eval exp="sf.stage_data.box_0.status++"]
        [else]
            #？？？
            『そっちじゃないよー』[p]
            #
        [endif]
[endswitch]

*skip_tutorial
[iscript]
if (sf.skip.tutorial && sf.stage_data.box_0.status == 0) sf.stage_data.box_0.status = 2;
[endscript]

; タイマーを起動（ついでにナンバー配列も初期化）
[if exp="sf.stage_data.box_0.status == 2"]
    [start_timer]
    [iscript]
    f.answer = '4,1,2,3';
    f.ans_nums = [];
    f.ans_model = [];
    sf.stage_data.box_0.status++;
    [endscript]
[endif]

; メインシステム
[iscript]
if (sf.stage_data.box_0.status == 3) {
    let deg_y = getMeasuringDegrees(tyrano.plugin.kag.tmp.three.camera.rotation.y) % 360;
    let deg_y_abs = Math.abs(deg_y);
    let bool1 = deg_y_abs % 90 == 0 && deg_y_abs % 180 != 0 && deg_y_abs % 360 != 0;
    let bool2 = deg_y == 90 || deg_y == -270;
    tf.bool1 = bool1 && bool2;
    tf.bool2 = bool1 && !bool2;
} else {
    tf.bool1 = false;
    tf.bool2 = false;
}
[endscript]
[clickable storage="box/box_0/system.ks" target="panel" x="470" y="65" width="340" height="570" color="black" opacity="0" mouseopacity="100" cond="tf.bool1 == true"]
[clickable storage="box/box_0/system.ks" target="hint" x="470" y="190" width="340" height="340" color="black" opacity="50   " mouseopacity="100" cond="tf.bool2 == true"]

[jump storage="main.ks" target="return_system"]





; == [panel] ===========================================================
*panel
[cm][clearstack]
[clearfix]
[3d_anim name="camera" pos="-1,0,0" time="500"]
[hide_message]
[button name="down" target="back_main" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&tf.size" height="&tf.size" fix="true"]
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
[s]

*push_num
[cm][clearstack]
[clearfix]
[iscript]
console.log(`push ${tf.push_num}`);
tf.num_obj = `s0num${tf.push_num}`;
tf.bool = f.ans_nums.includes(tf.push_num);
f.ans_nums.push(tf.push_num);
f.ans_model.push(tf.num_obj);
switch (f.ans_nums.length) {
    case 1: tf.pos = '-9.1,2.15,1.29'; break;
    case 2: tf.pos = '-9.1,2.15,0.43'; break;
    case 3: tf.pos = '-9.1,2.15,-0.43'; break;
    case 4: tf.pos = '-9.1,2.15,-1.29'; break;
}
[endscript]
[if exp="f.ans_nums.length == 5 || tf.bool"]
    [for name="tf.i" from="0" len="&f.ans_model.length" deep="1"]
        [eval exp="tf.model = f.ans_model[tf.i]"]
        [3d_hide name="&tf.model" time="10" wait="false"]
    [nextfor]
    [wait time="10"]
    [iscript]
    f.ans_nums = [];
    f.ans_model = [];
    [endscript]
[else]
    [3d_show name="&tf.num_obj" pos="&tf.pos" rot="&getRotate(0,90,0)" scale="0.85,0.85,0.01" time="10" wait="false"]
    [wait time="10"]
[endif]
[jump target="panel"]

*ok
[cm][clearstack]
[clearfix]
[jump target="correct" cond="f.ans_nums.join(',') == f.answer"]
[for name="tf.i" from="0" len="&f.ans_model.length"]
    [eval exp="tf.model = f.ans_model[tf.i]"]
    [3d_hide name="&tf.model" time="10" wait="false"]
[nextfor]
[wait time="10"]
[iscript]
f.ans_nums = [];
f.ans_model = [];
[endscript]
[jump target="panel"]

*back
[cm][clearstack]
[clearfix]
[if exp="f.ans_nums.length != 0"]
    [eval exp="tf.model = f.ans_model[f.ans_model.length-1]"]
    [3d_hide name="&tf.model" time="10" wait="false"]
    [iscript]
    f.ans_nums.pop();
    f.ans_model.pop();
    [endscript]
    [wait time="10"]
[endif]
[jump target="panel"]

*correct
[iscript]
console.log('--> correct');
[endscript]
[3d_anim name="camera" pos="0,0,0"]
[eval exp="f.to_direction = 'right'"]
[direction_manager]
[jump storage="main.ks" target="next_room"]





*hint
[cm][clearstack]
[clearfix]
[3d_anim name="camera" pos="1,0,0" time="500"]
[hide_message]
[button name="down" target="back_main" graphic="down.png" x="&sf.button.down.x" y="&sf.button.down.y" width="&tf.size" height="&tf.size" fix="true"]
[s]





*back_main
[cm][clearstack]
[clearfix]
[3d_anim name="camera" pos="0,0,0" time="500"]
[show_message]
[jump storage="main.ks" target="return"]