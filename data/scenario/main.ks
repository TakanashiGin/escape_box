*start
[cm][clearstack]

[iscript]
f.current = 0;
f.rooms = [0,1];
[endscript]

; 全体で使う3Dデータをロード
[load_stage_objects stage="global"]

; 静的3Dデータを表示
[call storage="box/call/set_room.ks" target="setup"]

*start_room
; 現在のステージ3Dデータをロード
[load_stage_objects stage="&f.rooms[f.current]"]
; 次のステージ3Dデータをロード
[load_stage_objects stage="&f.rooms[f.current]" cond="f.current < f.rooms.length-1"]
; 共通3Dデータを表示
[call storage="box/call/set_room.ks" target="set_room"]
; ステージのファイルを取得
[eval exp="tf.stage_file = { three_show:`box/box_${f.rooms[f.current]}/set_room.ks`, system:`box/box_${f.rooms[f.current]}/system.ks` }"]
; ステージ3Dデータを表示
[call storage="&tf.stage_file.three_show"]
; 次のステージ3Dデータを表示
; [call]
; ステージシステム読み込み
[call storage="&tf.stage_file.system"]
; 表示待ち
[wait time="10"]

*return
[cm][clearstack]
; カメラ制御ボタンを表示
;[camera_button]
; debug用
;[3d_debug_camera]
[mask_off time="500"]
[s]


*control_camera
[cm]
[direction_manager]
[jump target="return"]


*next_room
[mask]
; ステージ3Dデータを削除
[delete_stage_objects stage="&f.rooms[f.current]"]
; 現在のルームを一つ進める
[eval exp="f.current++"]
[jump target="start_room" cond="f.current < f.rooms.length"]
; クリア処理
[jump target="clear_game" cond="f.current >= f.rooms.length"]


*clear_game
[iscript]
console.log('--> clear game');
[endscript]
[s]
