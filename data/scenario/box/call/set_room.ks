*setup

[iscript]
tf.src = `sky_${sf.time_zone}.jpg`;
[endscript]
[show_panoramic_image name="sky" storage="&tf.src" rad="400" rot="&getRotate(45,0,0)"]

; ここでakane_fullを読み込み
;[load_stage_objects stage="akane_full"]
[eval exp="tf.faceis = [ 'normal_full', 'happy_full', 'sad_full', 'doki_full', 'angry_full' ]"]
[foreach name="tf.face" array="tf.faceis"]
    [eval exp="tf.name = 'akane_' + tf.face"]
    [eval exp="tf.src = '../../../fgimage/chara/akane/' + tf.face + '.png'"]
    [3d_sprite_new name="&tf.name" storage="&tf.src" scale="4,13,1"]
[nextfor]

[3d_show name="floor" pos="0,-10,0" rot="&getRotate(90,0,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="wall_right" pos="10,0,0" rot="&getRotate(0,90,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="wall_left" pos="-10,0,0" rot="&getRotate(0,-90,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="ceiling" pos="0,10,0" rot="&getRotate(90,0,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="wall_front_door" pos="0,0,-10" scale="20,20,1" time="10" wait="false"]
[return]



*set_next_room
[3d_show name="next_floor" pos="0,-10,-20" rot="&getRotate(90,0,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="next_wall_right" pos="10,0,-20" rot="&getRotate(0,90,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="next_wall_left" pos="-10,0,-20" rot="&getRotate(0,-90,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="next_ceiling" pos="0,10,-20" rot="&getRotate(90,0,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="next_wall_front_door" pos="0,0,-30" scale="20,20,1" time="10" wait="false"]
[3d_show name="next_front_door" pos="0,0,-30.5" scale="20,20,0.5" time="10" wait="false"]
[return]



*set_room

[eval exp="tf.room_num = f.rooms[f.current]"]

; 扉を表示
[3d_show name="front_door" pos="0,0,-10.5" scale="20,20,0.5" time="10" wait="false"]
[3d_show name="back_door" pos="0,0,10.5" scale="20,20,0.5" cond="tf.room_num != 0" time="10" wait="false"]

; 背後の壁を表示
[3d_show name="wall_back" pos="0,0,10" rot="&getRotate(0,0,0)" scale="20,20,1" cond="tf.room_num == 0" time="10" wait="false"]
[3d_show name="wall_back_door" pos="0,0,10" rot="&getRotate(0,0,0)" scale="20,20,1" cond="tf.room_num != 0" time="10" wait="false"]

; -- 最後の部屋の時の処理 -------------------------------------------------------
[if exp="f.current >= f.rooms.length - 1"]
    [iscript]
    $.log('--> set last room');
    [endscript]
; クリアオブジェクトを読み込み
    [load_stage_objects stage="clear"]
; akane_fullオブジェクトを読み込み（最初に読み込む）
;    [load_stage_objects stage="akane_full"]
; 疑似的な次の部屋を非表示
    [3d_hide name="next_floor" time="10" wait="false"]
    [3d_hide name="next_wall_right" time="10" wait="false"]
    [3d_hide name="next_wall_left" time="10" wait="false"]
    [3d_hide name="next_ceiling" time="10" wait="false"]
    [3d_hide name="next_wall_front_door" time="10" wait="false"]
    [3d_hide name="next_front_door" time="10" wait="false"]
; クリアオブジェクトを表示
    [iscript]
    tf.src = `clear_base_${sf.time_zone}`;
    [endscript]
    [3d_show name="&tf.src" pos="0,-20,0" rot="&getRotate(90,0,0)" scale="800,800,1" time="10" wait="false"]
    [wait time="10"]
; next_roomオブジェクトを削除
    [delete_stage_objects stage="next_room"]
[endif]
; -----------------------------------------------------------------------------

[return]
