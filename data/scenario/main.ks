*start
[cm][clearstack]

[mask]

[iscript]
f.current = 0;
f.rooms = [0,1];
// 各ステージのステータスを設定
for (let stage in sf.stage_data) sf.stage_data[stage]['status'] = 0;
[endscript]

; 全体で使う3Dデータ・next_roomの3Dデータをロード
[load_stage_objects stage="global"]
[load_stage_objects stage="next_room"]

; 静的3Dデータを表示
[call storage="box/call/set_room.ks" target="setup"]

; 疑似的な次の部屋を表示
[call storage="box/call/set_room.ks" target="set_next_room"]

*start_room
[cm][clearstack]
; ステージ3Dデータをロード
[load_stage_objects stage="&f.rooms[f.current]"]
; カメラをリセット
[3d_anim name="camera" pos="0" time="10"]
[3d_anim name="camera" rot="0" time="10"]
; 共通3Dデータを表示
[call storage="box/call/set_room.ks" target="set_room"]
; ステージのファイルを取得
[iscript]
f.stage_file = {
    show_three: `box/box_${f.rooms[f.current]}/set_room.ks`,
    system: `box/box_${f.rooms[f.current]}/system.ks`,
    camera_system: `box/box_${f.rooms[f.current]}/camera_system.ks`,
    set_next_room: `box/box_${f.rooms[f.current + 1]}/camera_system.ks`
};
[endscript]
; ステージ3Dデータを表示
[call storage="&f.stage_file.show_three"]
; 表示待ち
[wait time="100"]
; メッセージを表示
[show_message]
[mask_off time="500"]

; タイマーをスタート
[ctrl_circle_timer name="game_timer" content="stop" cond="f.rooms[f.current] != 0"]

*return
[cm][clearstack]
; ステージシステム読み込み
[jump storage="&f.stage_file.system"]
*return_system
; カメラ制御ボタンを表示
[camera_button]
; ============================================================================
; debug用
;[start_timer]
;[3d_debug_camera]
;[eval exp="getOrientation(true)"]
; ============================================================================
[s]


*control_camera
[cm][clearfix]
[call storage="&f.stage_file.camera_system"]
[direction_manager]
[jump target="return"]


*next_room
[cm][clearstack]
[clearfix]
; タイマーを一時停止
[ctrl_circle_timer name="game_timer" content="stop"]
[eval exp="tf.room_num = f.rooms[f.current]"]
[3d_hide name="front_door" wait="false"]
[3d_hide name="wall_back" cond="tf.room_num == 0"]
[3d_hide name="back_door" cond="tf.room_num != 0"]
[wait time="1000"]
[3d_anim name="camera" pos="0,0,-5" time="3000" wait="false"]
[wait time="1000"]
[mask time="2000"]
; 現在のステージ3Dデータを削除
[delete_stage_objects stage="&f.rooms[f.current]"]
; 現在のルームを一つ進める
[eval exp="f.current++"]
; 次のルームに進む
[jump target="start_room" cond="f.current < f.rooms.length"]
; クリア処理
[jump target="clear_game" cond="f.current >= f.rooms.length"]


*clear_game
[iscript]
console.log('--> clear game');
[endscript]
[s]


*timeout
[mask]
[iscript]
console.log('--> タイムアウト');
[endscript]
[clearfix]
[ctrl_circle_timer name="game_timer" content="delete"]
[3d_hide_all]
[3d_canvas_hide]
[3d_close]
[mask_off]
[show_message]
――脱出失敗
[s]
