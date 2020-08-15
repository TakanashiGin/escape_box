*first
[eval exp="sf.player_data.badge.clear_first = true"]
[give_emblem id="5576" pid="4bca8d4258922d3242fd715f19eb3302"]
[mod_sprite name="akane_happy_full" hide_name="akane_normal_full" pos="0,-5,-50" scale="6,19.5,1" time="10" cond="tf.akane_face != 'akane_happy_full'"]
はじめて脱出できたんだね！[r]
おめでとう！[p]
[return]

*three_min
[eval exp="sf.player_data.badge.three_min = true"]
[give_emblem id="5577" pid="7b0dc4f971c9a180c380e2b56540f86b"]
[mod_sprite name="akane_happy_full" hide_name="akane_normal_full" pos="0,-5,-50" scale="6,19.5,1" time="10" cond="tf.akane_face != 'akane_happy_full'"]
はじめて3分切ったんだね！[r]
すごい！[p]
[return]

*two_min
[eval exp="sf.player_data.badge.two_min = true"]
[give_emblem id="5578" pid="2fa50c31af541150ae686a5eb9d45d05"]
[mod_sprite name="akane_happy_full" hide_name="akane_normal_full" pos="0,-5,-50" scale="6,19.5,1" time="10" cond="tf.akane_face != 'akane_happy_full'"]
おぉ！[r]
はじめて2分を切ったからバッジを貰えたみたいだね！[p]
[return]

*a_min
[eval exp="sf.player_data.badge.a_min = true"]
[give_emblem id="5579" pid="42b4e0c380f7f7a51cd8cc3092fefb8d"]
[mod_sprite name="akane_happy_full" hide_name="akane_normal_full" pos="0,-5,-50" scale="6,19.5,1" time="10" cond="tf.akane_face != 'akane_happy_full'"]
1分を切って脱出したから最高レアのバッジを貰えたみたい！[r]
本当にスゴイ！[p]
[return]

*clear_all_box
[eval exp="sf.player_data.badge.clear_all_box = true"]
[give_emblem id="5580" pid="db812bdfc4f5e50c6b809799b1711170"]
[mod_sprite name="akane_doki_full" hide_name="akane_normal_full" pos="0,-5,-50" scale="6,19.5,1" time="10" cond="tf.akane_face != 'akane_doki_full'"]
え……！？[r]
私が用意した部屋を全部クリアしたの！？[p]
[mod_sprite name="akane_happy_full" hide_name="akane_normal_full" pos="0,-5,-50" scale="6,19.5,1" time="10" cond="tf.akane_face != 'akane_happy_full'"]
スゴイスゴイ！[r]
このゲームをやりこんでくれてありがとう！[p]
[return]
