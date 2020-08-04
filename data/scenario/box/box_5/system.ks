; メインシステム





#
[iscript]
//console.log(f.to_direction);
if (f.to_direction) {
    const system = f.room_system;
    system.dir.push(f.to_direction);
    for (let i=0; i<system.dir.length; i++) {
        if (system.dir[i] != system.correct[i]) {
            system.dir = [];
            system.correct_se = true;
            break;
        }
    }
    if (system.dir.length == system.correct.length) {
        system.clear = true;
    }
}
//console.log(f.room_system);
[endscript]

[if exp="f.room_system.correct_se"]
;    [playse storage="correct.ogg"]
    [eval exp="f.room_system.correct_se = false"]
[endif]

[jump target="clear" cond="f.room_system.clear"]





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
        左の壁には何もない。
    [elsif exp="tf.orientation[0] == 'right'"]
        右の壁には何もない。
    [endif]
[endif]
[endnowait]

[jump storage="main.ks" target="return_system"]





*clear
[eval exp="console.log('-->_correct')"]
[wait time="500"]
[to_front]
[jump storage="main.ks" target="next_room"]
[s]
