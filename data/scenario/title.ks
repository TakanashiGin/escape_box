*start
[cm][clearstack]
[mask time="500"]
    [eval exp="sf.in_the_title = true"]
    [3d_init layer="0"]
    [3d_camera pos="-50,26,50" rot="-0.34,-0.8,0" scale="1,1,1"]
;    [show_sky_box storage="title.png" r="100" rot="0,0,0"]
    [show_panoramic_image name="title" storage="title.png" rad="100"]
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
    [glink text="START" color="btn_07_white" size="30" target="start_game" x="270" y="550" width="300" height="70" clickse="&getSe()"]
    [glink text="CONFIG" color="btn_07_white" size="30" target="config" x="710" y="550" width="300" height="70" clickse="&getSe()"]
    [glink text="CREDIT" color="btn_07_white" size="25" target="credit" x="40" y="15" width="280" height="60" clickse="&getSe()"]
    [glink text="DELETE" color="btn_07_white" size="25" target="delete" x="960" y="15" width="280" height="60" clickse="&getSe()"]
    [fbgm name="main" time="500"]
[mask_off time="500"]
[eval exp="$.setDebugCtrlTimer()"]
[s]

*start_game
[eval exp="sf.in_the_title = false"]
[eval exp="$.clearDebugCtrlTimer()"]
[fadeoutbgm time="1000"]
[eval exp="f.loading_text = getLoadingText()"]
[pmask text="&f.loading_text" size="40" left="0" top="200" align="center" width="1280" auto_change="true" auto_change_interval="750" auto_change_random="false"]
[free layer="1" name="title" time="10"]
[remove_panoramic_image name="title"]
[iscript]
sf.rafStop();
[endscript]
[3d_close]
[jump storage="first.ks" target="return_title"]

*config
[eval exp="sf.in_the_title = false"]
[eval exp="$.clearDebugCtrlTimer()"]
[remove_panoramic_image name="title"]
[iscript]
sf.rafStop();
[endscript]
[3d_close]
[jump storage="config.ks"]
*return_config
[cm][clearstack]
[clearfix]
[jump target="start"]

*credit
[cm][clearstack]
[clearfix]
[eval exp="sf.in_the_title = false"]
[eval exp="$.clearDebugCtrlTimer()"]
[free layer="1" name="title" time="10"]
[position layer="message0" left="0" top="0" width="1280" height="720" page="fore" visible="true" opacity="200"]
[position layer="message0" page="fore" margint="45" marginl="50" marginr="70" marginb="10"]
[chara_config ptext="chara_name_area"]
[nowait]
[layopt layer="message0" visible="true"]
#
作った人：小鳥遊銀[r]
3Dモデル協力：hideichi[r]
[r]
テクスチャ素材：ぱくたそ[r]
アイコン素材：ICOON MONO[r]
効果音：効果音ラボ[r]
[r]
=>
_ クリックで戻る
[endnowait]
[l]
[mask time="500"]
[layopt layer="message0" visible="false"]
[remove_panoramic_image name="title"]
[eval exp="sf.rafStop()"]
[3d_close]
[jump target="start"]





*delete
[dialog type="confirm" text="プレイデータを削除しますか？" target="d_yes" target_cancel="d_no"]
[s][s][s][s][s]
*d_yes
[wait time="1000"]
[eval exp="$.resetPlayerData()"]
[dialog text="プレイデータを削除しました" target="d_no"]
[s][s][s][s][s]
*d_no
[mask time="500"]
[remove_panoramic_image name="title"]
[eval exp="sf.rafStop()"]
[3d_close]
[jump target="start"]
