*start
[cm][clearstack]

; 暗転
[mask]

; canvas表示
[3d_init]

[iscript]
f.current = 0;
f.rooms = (sf.shuffle_array)? shuffleArray(sf.rooms) : sf.rooms;
f.rooms.unshift(0);
console.log(`--> rooms ${f.rooms}`);
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
[3d_camera pos="0,0,0" rot="0,0,0"]
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
; アイテム欄を表示
[if exp="f.rooms[f.current] == 0"]
    [reset_item]
    [show_item]
[endif]
[mask_off time="500"]

; タイマーをスタート
[ctrl_circle_timer name="game_timer" content="start" cond="f.rooms[f.current] != 0 && sf.on_timer == true"]

*return
[cm][clearstack]
; ステージシステム読み込み
[jump storage="&f.stage_file.system"]
*return_system
; スキップ（デバッグモード）
[eval exp="tf.skip_bool = sf['skip'][`box_${f.rooms[f.current]}`]"]
[if exp="tf.skip_bool"]
    [iscript]
    console.log('--> click to skip');
    [endscript]
    [l]
    [jump storage="main.ks" target="next_room"]
[endif]
; カメラ制御ボタンを表示
[camera_button]
; ============================================================================
; debug用
;[start_timer]
;[eval exp="console.log(tyrano.plugin.kag.tmp.three.models)"]
;[3d_debug_camera]
;[3d_hide]
[iscript]
const debug_model = () => {
    const three = TYRANO.kag.tmp.three;
    const target = three.models.test1.model;
    const d = 0.1;
    console.log(target);
    $(window).on('keydown.debug_three_model_by_key', de => {
        switch (de.keyCode) {
            case 65:  // a
                var tmp = target.position.x;
                target.position.x -= d;
                console.log(`${tmp} => ${target.position.x}`);
                break;
            case 68:  // d
                var tmp = target.position.x;
                target.position.x += d;
                console.log(`${tmp} => ${target.position.x}`);
                break;
            case 87:  // w
                var tmp = target.position.z;
                target.position.z -= d;
                console.log(`${tmp} => ${target.position.z}`);
                break;
            case 83:  // s
                var tmp = target.position.z;
                target.position.z += d;
                console.log(`${tmp} => ${target.position.z}`);
                break;
            case 81:  // q
                var tmp = target.position.y;
                target.position.y += d;
                console.log(`${tmp} => ${target.position.y}`);
                break;
            case 69:  // e
                var tmp = target.position.y;
                target.position.y -= d;
                console.log(`${tmp} => ${target.position.y}`);
                break;
        }
    });
}
[endscript]
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
[ctrl_circle_timer name="game_timer" content="stop" cond="sf.on_timer == true"]
; クリア判定
[eval exp="tf.clear = f.current >= f.rooms.length - 1"]
; クリアの場合、akaneオブジェクトを表示・天球を回転
[if exp="tf.clear"]
    [3d_show name="akane_normal" pos="0,-5,-50" scale="6,19.5,1" time="10"]
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
[wait time="1000"]
[mask time="2000"]
; 現在のステージ3Dデータを削除
[delete_stage_objects stage="&f.rooms[f.current]"]
; 現在のルームを一つ進める
[iscript]
f.current++;
console.log(`--> next to ${f.rooms[f.current]}`);
[endscript]
; 次のルームに進む
[jump target="start_room" cond="f.current < f.rooms.length"]


*clear_game
[iscript]
console.log('--> clear game');
[endscript]
; タイマー削除
[ctrl_circle_timer name="game_timer" content="delete" cond="sf.on_timer == true"]
; アイテム欄削除
[close_item]
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
; cameraの位置を調整（バグ対策でJSから操作）
[iscript]
const camera = tyrano.plugin.kag.tmp.three.camera;
['x','y','z'].forEach(d => {
    camera.rotation[d] = 0;
    camera.position[d] = d == 'z'? -30 : 0;
});
[endscript]
; メッセージウィンドウを表示
[show_message]
[mask_off]

; 最初にカメラでふりふり
[3d_anim name="camera" rot="&getRotate(0,20,0)" time="500"]
[wait time="500"]
[3d_anim name="camera" rot="&getRotate(0,-20,0)" time="1000"]
[wait time="500"]
[3d_anim name="camera" rot="&getRotate(0,0,0)" time="500"]
[wait time="500"]

#アカネ
おめでとう、無事に脱出できたね！[p]
;[3d_debug_camera]
[jump target="return_game"]


*timeout
; ホワイトアウト
[mask color="white"]
[cm][clearstack]
; 名前欄解放
#
[iscript]
console.log('--> time out');
[endscript]
; fixレイヤ解放
[clearfix]
; タイマー削除
[ctrl_circle_timer name="game_timer" content="delete" cond="sf.on_timer == true"]
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
――脱出失敗[l]
[jump target="return_game"]


*return_game
[mask]
[close_item]
[3d_close]
#
[hide_message]
[jump storage="first.ks" target="return_game"]
