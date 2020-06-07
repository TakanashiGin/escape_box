*start
[cm][clearstack]

[load_stage_objects stage="global"]
[load_stage_objects stage="0"]

[3d_show name="sky" scale="1,1,1" pos="0,50,0" rot="&getRotate(90,0,0)"]
[3d_show name="front_door" pos="0,0,-10.5" scale="25,25,0.5"]
[3d_show name="wall_front_door" pos="0,0,-10" scale="20,20,1"]
[3d_show name="floor" pos="0,-10,0" rot="&getRotate(90,0,0)" scale="20,20,1"]
[3d_show name="wall_right" pos="10,0,0" rot="&getRotate(0,90,0)" scale="20,20,1"]
[3d_show name="wall_left" pos="-10,0,0" rot="&getRotate(0,-90,0)" scale="20,20,1"]
[3d_show name="wall_back" pos="0,0,10" rot="&getRotate(0,0,0)" scale="20,20,1"]
[3d_show name="ceiling" pos="0,10,0" rot="&getRotate(90,0,0)" scale="20,20,1"]

*return
[camera_button]
[s]

*control_camera
[cm]
[direction_manager]
[jump target="return"]
