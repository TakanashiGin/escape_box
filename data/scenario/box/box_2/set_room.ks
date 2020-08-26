

[iscript]
f.correct = shuffleArray(['r','b','y']).pop();
$.log('correct: ' + f.correct);
[endscript]


; 右側：机、はさみ、棒
[3d_model_new name="scissors" storage="scissors.gltf" pos="7.5,-1.6,0" scale="0.08" rot="&getRotate(0,-45,0)"]
[3d_model_new name="bar" storage="bar.gltf" pos="9,-4,-3" scale="0.75" rot="&getRotate(10,0,0)"]
[3d_show name="s2table_right" time="10" wait="false"]
[3d_show name="scissors" time="10" wait="false"]
[3d_show name="bar" time="10" wait="false"]


; 左側：机、ワイヤー３色、爆弾
[3d_model_new name="bomb" storage="bomb.gltf" pos="-7.8,-1.4,0" scale="0.1" rot="&getRotate(0,0,0)"]
[3d_model_new name="bomb_wire_b" storage="bomb_wire_b.gltf" pos="-7.8,-1.4,0" scale="0.1" rot="&getRotate(0,0,0)"]
[3d_model_new name="bomb_wire_r" storage="bomb_wire_r.gltf" pos="-7.8,-1.4,0" scale="0.1" rot="&getRotate(0,0,0)"]
[3d_model_new name="bomb_wire_y" storage="bomb_wire_y.gltf" pos="-7.8,-1.4,0" scale="0.1" rot="&getRotate(0,0,0)"]
[3d_show name="s2table_left" time="10" wait="false"]
[3d_show name="bomb" time="10" wait="false"]
[3d_show name="bomb_wire_b" time="10" wait="false"]
[3d_show name="bomb_wire_r" time="10" wait="false"]
[3d_show name="bomb_wire_y" time="10" wait="false"]


; 上：箱
[3d_show name="s2hint_box" time="10" wait="false"]


[return]
