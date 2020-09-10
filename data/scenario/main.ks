*start
[cm][clearstack]

; canvas表示
[3d_init]

[iscript]
f.current = 0;
const rooms = !!sf.system.var.shuffle_array? shuffleArray(sf.system.rooms) : sf.system.rooms;
rooms.unshift(0);
f.rooms = rooms.slice(0,4);
$.log(`--> rooms ${f.rooms}`);
// 各ステージのステータスを設定
for (let stage in sf.stage_data) sf.stage_data[stage]['status'] = 0;
// 時間帯を取得
sf.time_zone = getTimeZone();
[endscript]

; 全体で使う3Dデータ・next_roomの3Dデータをロード
[load_stage_objects stage="global"]
[load_stage_objects stage="next_room"]

; 静的3Dデータを表示
[call storage="box/call/set_room.ks" target="setup"]

; 次の部屋の壁・扉を表示
[call storage="box/call/set_room.ks" target="set_next_room"]

; 最初のステージ3Dデータをロード
[load_stage_objects stage="&f.rooms[f.current]"]

*start_room
[cm][clearstack]
; 次のステージ3Dデータをロード
[load_stage_objects stage="&f.rooms[f.current+1]" cond="f.current < f.rooms.length-1"]
; カメラをリセット
[3d_camera pos="0,0,0" rot="0,0,0"]
; 共通3Dデータを表示
[call storage="box/call/set_room.ks" target="set_room"]
[iscript]
// ステージのファイルを取得
f.stage_file = {
    show_three: `box/box_${f.rooms[f.current]}/set_room.ks`,
    system: `box/box_${f.rooms[f.current]}/system.ks`,
    camera_system: `box/box_${f.rooms[f.current]}/camera_system.ks`,
    set_next_room: `box/box_${f.rooms[f.current + 1]}/set_next_room.ks`
};
// 次の部屋のオブジェクトを取得
//f.next_room_object = sf.stage_data['box_' + f.rooms[f.current + 1]]['objects'];
if (f.current < f.rooms.length-1) {
    f.next_room_object = getOriginObjectData(f.rooms[f.current + 1]);
    $.log('--> next room');
    $.log(f.next_room_object);
} else {
    delete f.next_room_object;
}
[endscript]
; ステージ3Dデータを表示
[call storage="&f.stage_file.show_three"]
; 次の部屋のステージ3Dデータを表示
[call storage="&f.stage_file.set_next_room" cond="f.current < f.rooms.length-1"]
; 表示待ち
[wait time="100"]
; メッセージを表示
[show_message]
; アイテム欄を表示
[if exp="f.rooms[f.current] == 0"]
    [reset_item]
    [show_item]
[endif]
; バックタイトルボタン表示（廃止）
;[show_system_button]
[wait time="2500"]
; カメラをリセット（追い打ち）
[3d_camera pos="0,0,0" rot="0,0,0"]
[mask_off time="500"]
[pmask_off time="500"]

; タイマーをスタート
[ctrl_circle_timer name="game_timer" content="start" cond="f.rooms[f.current] != 0 && sf.system.var.on_timer"]

*return
[cm][clearstack]
; ステージシステム読み込み
[jump storage="&f.stage_file.system"]
*return_system
; スキップ（デバッグモード）
[eval exp="tf.skip_bool = sf.system['skip'][`box_${f.rooms[f.current]}`]"]
[if exp="tf.skip_bool"]
    [iscript]
    $.log('--> click to skip');
    [endscript]
    [l]
    [jump storage="main.ks" target="next_room"]
[endif]
; カメラ制御ボタンを表示
[camera_button]
; ============================================================================
; debug用
;[eval exp="$.log(sf)"]
;[eval exp="$.log(tyrano.plugin.kag.tmp.three.models)"]
;[eval exp="getOrientation(true)"]
;[start_timer]
;[l]
;[clear_button]
;[3d_camera pos="-8,1,5" rot="&getRotate(-30,0,0)"]
;[3d_debug_camera]
;[3d_hide]
; ============================================================================
[s]


*control_camera
[cm][clear_button]
[call storage="&f.stage_file.camera_system"]
[direction_manager]
[jump target="return"]
[s]


*next_room
[cm][clearstack]
[clear_button]
; カメラ角度を一時保存する変数を初期化
[eval exp="tf.tmp_rot = null"]
; クリアした部屋をplayer_dataに登録
[eval exp="sf.player_data.clear_box['box_' + f.rooms[f.current]] = true"]
; タイマーを一時停止
[ctrl_circle_timer name="game_timer" content="stop" cond="sf.system.var.on_timer == true"]
; クリア判定
[eval exp="tf.clear = f.current >= f.rooms.length - 1"]
; ゲームクリアの場合、akaneオブジェクトを表示・天球を回転
[if exp="tf.clear"]
    [3d_show name="akane_normal_full" pos="0,-5,-50" scale="6,19.5,1" time="10"]
    [iscript]
    let sky = getModel('sky');
    sky.rotation.y = 180;
    sky.rotation.z = 180;
    // 並行光を削除
    let three = tyrano.plugin.kag.tmp.three;
    three.scene.remove(three.light);
    delete three.light;
    [endscript]
[endif]
; 扉を削除
[eval exp="tf.room_num = f.rooms[f.current]"]
[3d_hide name="front_door" wait="false"]
[3d_hide name="wall_back" cond="tf.room_num == 0"]
[3d_hide name="back_door" cond="tf.room_num != 0"]
[wait time="1000"]
; クリアの場合、ラベルにジャンプ
[jump target="clear_game" cond="tf.clear"]
; 次の部屋に進む場合の処理
[3d_anim name="camera" pos="0,0,-5" time="3000" wait="false"]
[playse storage="&sf.se.storage.walk"]
[wait time="1000"]
; 暗転
[eval exp="f.loading_text = getLoadingText()"]
[pmask text="&f.loading_text" size="40" left="0" top="200" align="center" width="1280" auto_change="true" auto_change_interval="750" auto_change_random="false"]
; アイテムをリセット
[reset_item]
; 現在のステージ3Dデータを削除
[delete_stage_objects stage="&f.rooms[f.current]"]
; 次の部屋のステージ3Dオブジェクトを非表示に
[delete_stage_objects stage="&f.rooms[f.current + 1]" delete="false" cond="f.current+1 < f.rooms.length-1"]
; 現在のルームを一つ進める
[iscript]
f.current++;
$.log(`--> next to ${f.rooms[f.current]}`);
[endscript]
; 次のルームに進む
[jump target="start_room" cond="f.current < f.rooms.length"]


*clear_game
[iscript]
$.log('--> clear game');
f.clear_time = sf.system.var.on_timer? parseInt(TYRANO.kag.stat.circle_timer_array[0].timer.getTime() / 1000) : 0;
$.log(`clear time: ${f.clear_time}`);
[endscript]
; タイマー削除
[ctrl_circle_timer name="game_timer" content="delete" cond="sf.system.var.on_timer == true"]
; アイテム欄削除
[close_item]
; bgmフェードアウト
[fadeoutbgm time="3000"]
; カメラ移動
[3d_anim name="camera" pos="0,0,-10" time="3000" wait="false"]
[wait time="1000"]
[mask time="2000"]
; 現在のステージ3Dデータを削除
[delete_stage_objects stage="&f.rooms[f.current]"]
; グローバル3Dデータを削除
[delete_stage_objects stage="global"]
; 現在のルームを一つ進める（便宜的）
[eval exp="f.current++"]
; cameraの位置を調整
[iscript]
const camera = tyrano.plugin.kag.tmp.three.camera;
['x','y','z'].forEach(d => {
    camera.rotation[d] = 0;
    camera.position[d] = d == 'z'? -30 : 0;
});
$.log(`ajast camera position z: ${camera.position.z != -30}`);
if (camera.position.z != -30) {  // 追い打ち
    camera.position.z = -30;
    $.log(camera.position.z);
}
[endscript]
; メッセージウィンドウを表示
[show_message]
[fadeinbgm storage="&sf.bgm.storage.game3" time="1000"]
[mask_off time="1000"]

; 最初にカメラでふりふり
[3d_anim name="camera" rot="&getRotate(0,20,0)" time="500"]
[wait time="500"]
[3d_anim name="camera" rot="&getRotate(0,-20,0)" time="1000"]
[wait time="500"]
[3d_anim name="camera" rot="&getRotate(0,0,0)" time="500"]
[wait time="500"]

[mod_sprite name="akane_happy_full" hide_name="akane_normal_full" pos="0,-5,-50" scale="6,19.5,1" time="10"]
#アカネ
『おめでとう、無事に脱出できたね！』[p]
[mod_sprite name="akane_normal_full" hide_name="akane_happy_full" pos="0,-5,-50" scale="6,19.5,1" time="10"]
『クリア時間は「[emb exp="f.clear_time"]
_ 秒」……』[p]
[if exp="f.clear_time < 60"]
    [mod_sprite name="akane_happy_full" hide_name="akane_normal_full" pos="0,-5,-50" scale="6,19.5,1" time="10"]
    『スゴイスゴイ！[r]
    1分を切ってるね！』[p]
    [mod_sprite name="akane_normal_full" hide_name="akane_happy_full" pos="0,-5,-50" scale="6,19.5,1" time="10"]
    『これは脱出ゲームマスターって言っても過言じゃないね！』[p]
[elsif exp="f.clear_time < 120"]
    『2分を切ってるよ！[r]
    もしかして君才能あるかもしれないね』[p]
[elsif exp="f.clear_time < 180"]
    『3分かぁ[r]
    君ならまだまだ行けると思うな』[p]
    『次はもっとはやく脱出してみよう』[p]
[else]
    『難しかったかな』[p]
    『でも次はもっと上手くいけると思うよ！』[p]
[endif]

[call storage="badge.ks" target="first" cond="!sf.player_data.badge.clear_first && sf.system.var.badge_system"]
[call storage="badge.ks" target="three_min" cond="!sf.player_data.badge.three_min && f.clear_time < 180 && sf.system.var.badge_system"]
[call storage="badge.ks" target="two_min" cond="!sf.player_data.badge.two_min && f.clear_time < 120 && sf.system.var.badge_system"]
[call storage="badge.ks" target="a_min" cond="!sf.player_data.badge.a_min && f.clear_time < 60 && sf.system.var.badge_system"]
[call storage="badge.ks" target="clear_all_box" cond="!sf.player_data.badge.clear_all_box && !!Object.keys(sf.player_data.clear_box).every(box => !!sf.player_data.clear_box[box]) && sf.system.var.badge_system"]
[eval exp="$.log(sf.player_data)"]

[mod_sprite name="akane_happy_full" hide_name="akane_normal_full" pos="0,-5,-50" scale="6,19.5,1" time="10" cond="tf.akane_face != 'akane_happy_full'"]
それじゃ機会があったらまた会おうねぇ～[p]
;[3d_debug_camera]
[jump target="return_game"]


*timeout
[fadeoutbgm time="1000"]
[playse storage="&sf.se.storage.explosion"]
; ホワイトアウト
[mask color="white" time="1000"]
[cm][clearstack]
; 名前欄解放
#
[iscript]
$.log('--> time out');
[endscript]
; wait_canvel
[wait_cancel]
; fixレイヤ解放
[clear_button]
; タイマー削除
[ctrl_circle_timer name="game_timer" content="delete" cond="sf.system.var.on_timer == true"]
; アイテム欄削除
[close_item]
; canvas削除
[3d_close]
; メッセージウィンドウ表示
[show_message]
; wait
[wait time="2000"]
; マスク解除
[mask_off]
[jump target="faild_common"]

*faild
[show_message]
#あなた
あっ…………
[fadeoutbgm time="1000"]
[wait time="1000"]
[playse storage="&sf.se.storage.explosion"]
; ホワイトアウト
[mask color="white" time="1000"]
[cm][clearstack]
; 名前欄解放
#
[iscript]
$.log('--> faild');
[endscript]
; fixレイヤ解放
[clear_button]
; タイマー削除
[ctrl_circle_timer name="game_timer" content="delete" cond="sf.system.var.on_timer == true"]
; アイテム欄削除
[close_item]
; canvas削除
[3d_close]
; メッセージウィンドウ表示
[show_message]
; wait
[wait time="2000"]
; マスク解除
[mask_off]
仕掛けによって部屋が爆発した[p]
[jump target="faild_common"]

*faild_common
――脱出失敗[r]
クリックでタイトルに戻ります[p]
[jump target="return_game"]
[s]



*return_game
[mask]

[close_item]
[3d_close]
#
[hide_message]
[eval exp="$.hideSystemButton()"]
[jump storage="first.ks" target="return_game"]



*back_title
[cm][clearstack]
[clear_button]
[ctrl_circle_timer name="game_timer" content="stop" cond="sf.system.var.on_timer == true"]
[dialog type="confirm" text="タイトルに戻りますか？" target="back_title_yes" target_cancel="back_title_no"]
[s]

*back_title_yes
[wait time="500"]
[ctrl_circle_timer name="game_timer" content="delete" cond="sf.system.var.on_timer == true"]
[jump target="return_game"]
[s]

*back_title_no
[wait time="500"]
[ctrl_circle_timer name="game_timer" content="start" cond="sf.system.var.on_timer == true"]
[jump target="return"]
[s]
