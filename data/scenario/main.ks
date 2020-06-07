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
; ステージ3Dデータを表示
; [call]
; ステージシステム読み込み
; [call]
[wait time="10"]

*return
[cm][clearstack]
[camera_button]
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
[jump target="start_room"]
