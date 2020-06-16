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
        左の壁には何もない。
    [elsif exp="tf.orientation[0] == 'right'"]
        右の壁には何もない。
    [endif]
[endif]
[endnowait]

[jump storage="main.ks" target="return_system"]
