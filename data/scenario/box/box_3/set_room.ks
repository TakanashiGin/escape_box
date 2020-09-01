[3d_show name="hammer" pos="&getObjecttPos('hammer')" time="10" wait="false"]
[3d_show name="s3table1" pos="&getObjecttPos('s3table1')" time="10" wait="false"]
[3d_show name="s3table2" pos="&getObjecttPos('s3table2')" time="10" wait="false"]
[3d_show name="s3table3" pos="&getObjecttPos('s3table3')" time="10" wait="false"]
[for name="tf.i" from="0" len="&f.s3boxies.map.length"]
    [for name="tf.j" from="0" len="&f.s3boxies.map[tf.i].length"]
        [iscript]
        tf.box = {
            name: 's3' + f.s3boxies.map[tf.i][tf.j],
            pos: f.s3boxies.pos[tf.i][tf.j]
        };
        tf.num = {
            name: 's3hint' + f.s3number.map[tf.i][tf.j],
            pos: f.s3number.pos[tf.i][tf.j]
        };
        [endscript]
        [3d_show name="&tf.box.name" pos="&tf.box.pos" time="10" wait="false"]
        [3d_show name="&tf.num.name" pos="&tf.num.pos" rot="&getRotate(0,-90,0)" scale="1,1,0.01" time="10" wait="false"]
    [nextfor]
[nextfor]



[3d_show name="s3num_box" pos="-9.5,0.1,0" rot="&getRotate(0,90,0)" scale="0.35" time="10" wait="false"]
[3d_show name="s3b1" pos="-9,1,1" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b2" pos="-9,1,0" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b3" pos="-9,1,-1" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b4" pos="-9,0,1" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b5" pos="-9,0,0" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b6" pos="-9,0,-1" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b7" pos="-9,-1,1" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b8" pos="-9,-1,0" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b9" pos="-9,-1,-1" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3ok" pos="-9,-2,0.5" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3back" pos="-9,-2,-0.5" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3num_monitor" pos="-9.4,2.2,0" rot="&getRotate(0,90,0)" scale="0.35" time="10" wait="false"]



[return]
