[switch exp="sf.stage_data.box_0.status"]
    [case is="0"]
        #？？？
        『やっほー、起きた？』[p]
        『え？
        _ どこから話しかけているかって？』[p]
        『後ろだよ、後ろー』[p]
        『[graph storage="right_sub.png"]か[graph storage="left_sub.png"]で左右に振り向けるよ』[p]
        #
        [eval exp="sf.stage_data.box_0.status++"]
    [case is="1"]
        [if exp="getMeasuringDegrees(tyrano.plugin.kag.tmp.three.camera.rotation.y) % 180 == 0"]
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
            [start_timer]
            [eval exp="sf.stage_data.box_0.status++"]
        [else]
            #？？？
            『そっちじゃないよー』[p]
            #
        [endif]
[endswitch]

; タイマーを起動
[if exp="sf.stage_data.box_0.status == 2"]
    [start_timer]
    [eval exp="sf.stage_data.box_0.status++"]
[endif]

[jump storage="main.ks" target="return_system"]
