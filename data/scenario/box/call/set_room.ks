*setup
[3d_show name="sky" scale="1,1,1" pos="0,50,0" rot="&getRotate(90,0,0)" time="10" wait="false"]
[3d_show name="floor" pos="0,-10,0" rot="&getRotate(90,0,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="wall_right" pos="10,0,0" rot="&getRotate(0,90,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="wall_left" pos="-10,0,0" rot="&getRotate(0,-90,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="ceiling" pos="0,10,0" rot="&getRotate(90,0,0)" scale="20,20,1" time="10" wait="false"]
[3d_show name="wall_front_door" pos="0,0,-10" scale="20,20,1" time="10" wait="false"]
[return]


*set_room

[eval exp="tf.room_num = f.rooms[f.current]"]

[3d_show name="front_door" pos="0,0,-10.5" scale="25,25,0.5" cond="tf.room_num == 0" time="10" wait="false"]
[3d_show name="back_door" pos="0,0,-10.5" scale="25,25,0.5" cond="tf.room_num != 0" time="10" wait="false"]

[3d_show name="wall_back" pos="0,0,10" rot="&getRotate(0,0,0)" scale="20,20,1" cond="tf.room_num == 0" time="10" wait="false"]
[3d_show name="wall_back_door" pos="0,0,-10" rot="&getRotate(0,0,0)" scale="20,20,1" cond="tf.room_num != 0" time="10" wait="false"]

[return]
