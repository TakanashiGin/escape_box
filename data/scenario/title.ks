*start
[cm][clearstack]
[mask time="500"]
    [3d_init]
    [3d_camera pos="-50,26,50" rot="-0.34,-0.8,0" scale="1,1,1"]
    [show_sky_box storage="title.png" r="100" rot="0,0,0"]
    [load_stage_objects stage="global"]
    [3d_show name="floor" pos="0,-10,0" rot="&getRotate(90,0,0)" scale="20,20,1" time="10" wait="false"]
    [3d_show name="wall_right" pos="10,0,0" rot="&getRotate(0,90,0)" scale="20,20,1" time="10" wait="false"]
    [3d_show name="wall_left" pos="-10,0,0" rot="&getRotate(0,-90,0)" scale="20,20,1" time="10" wait="false"]
    [3d_show name="ceiling" pos="0,10,0" rot="&getRotate(90,0,0)" scale="20,20,1" time="10" wait="false"]
    [3d_show name="wall_front_door" pos="0,0,-10" scale="20,20,1" time="10" wait="false"]
    [3d_show name="wall_back_door" pos="0,0,10" rot="&getRotate(0,0,0)" scale="20,20,1" time="10" wait="false"]
    [3d_show name="front_door" pos="0,-2,-9.5" scale="15,15,0.5" time="10" wait="false"]
    [3d_show name="back_door" pos="0,-2,9.5" scale="15,15,0.5" time="10" wait="false"]
    [wait time="10"]
    [eval exp="sf.raf_animation = true"]
    [ptext layer="1" name="title" text="&sf.title" size="75" bold="bold" shadow="black" x="0" y="100" width="1280" align="center" time="10"]
    [glink text="START" color="btn_07_white" size="30" target="start_game" x="270" y="550" width="300" height="70"]
    [glink text="CONFIG" color="btn_07_white" size="30" target="config" x="710" y="550" width="300" height="70"]
[mask_off time="500"]
[s]

*start_game
[mask time="1000"]
[free layer="1" name="title" time="10"]
[iscript]
sf.rafStop();
[endscript]
[3d_close]
[jump storage="first.ks" target="return_title"]

*config
[iscript]
sf.rafStop();
[endscript]
[3d_close]
[jump storage="config.ks"]
*return_config
[cm][clearstack]
[clearfix]
[jump target="start"]
