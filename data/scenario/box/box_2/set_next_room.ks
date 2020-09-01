[iscript]
f.s2correct = shuffleArray(['r','b','y']).pop();
$.log('correct: ' + f.s2correct);
[endscript]





; 定義

[3d_model_new name="scissors" storage="scissors.gltf" pos="7.5,-1.6,0" scale="0.08" rot="&getRotate(0,-45,0)"]
[3d_model_new name="bar" storage="bar.gltf" pos="9,-4,-3" scale="0.75" rot="&getRotate(10,0,0)"]

[3d_model_new name="bomb" storage="bomb.gltf" pos="-7.8,-1.4,0" scale="0.1" rot="&getRotate(0,0,0)"]
[3d_model_new name="bomb_wire_b" storage="bomb_wire_b.gltf" pos="-7.8,-1.4,0" scale="0.1" rot="&getRotate(0,0,0)"]
[3d_model_new name="bomb_wire_r" storage="bomb_wire_r.gltf" pos="-7.8,-1.4,0" scale="0.1" rot="&getRotate(0,0,0)"]
[3d_model_new name="bomb_wire_y" storage="bomb_wire_y.gltf" pos="-7.8,-1.4,0" scale="0.1" rot="&getRotate(0,0,0)"]





; 表示

; 右側：机、はさみ、棒
[3d_show name="s2table_right" pos="&getObjecttPos('s2table_right', true)" time="10" wait="false"]
[3d_show name="scissors" pos="&getObjecttPos('scissors', true)" time="10" wait="false"]
[3d_show name="bar" pos="&getObjecttPos('bar', true)" time="10" wait="false"]

; 左側：机、ワイヤー３色、爆弾
[3d_show name="s2table_left" pos="&getObjecttPos('s2table_left', true)" time="10" wait="false"]
[3d_show name="bomb" pos="&getObjecttPos('bomb', true)" time="10" wait="false"]
[3d_show name="bomb_wire_b" pos="&getObjecttPos('bomb_wire_b', true)" time="10" wait="false"]
[3d_show name="bomb_wire_r" pos="&getObjecttPos('bomb_wire_r', true)" time="10" wait="false"]
[3d_show name="bomb_wire_y" pos="&getObjecttPos('bomb_wire_y', true)" time="10" wait="false"]

; 上：箱
[3d_show name="s2hint_box" pos="&getObjecttPos('s2hint_box', true)" time="10" wait="false"]





[return]
