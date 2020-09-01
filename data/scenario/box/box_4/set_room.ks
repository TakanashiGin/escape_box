[macro name="balance"]
    [iscript]
    f.s4balance.mode = mp.weight;
    const disc = f.s4balance.disc;
    const r = 2;
    const deg = f.s4balance.mode=='right'? -25 : f.s4balance.mode=='left'? 25 : 0;
    const dx = r * (1 - Math.cos(getRadian(deg)));
    const dy = r * Math.sin(getRadian(deg));
    tf.rot = getRotate( deg, 0, 0 );
    switch(mp.weight){
        case 'left':
            tf.pos_right = [-8, 0.3+dy, -1.75+dx].join(',');
            tf.pos_left = [-8, 0.3-dy, 1.75-dx].join(',');
            tf.disc_right = [-8, 0.6+dy, -1.75+dx].join(',');
            tf.disc_left = [-8, 0.6-dy, 1.75-dx].join(',');
            f.box_right = [-8,1.1+dy,-1.75+dx].join(',');
            f.box_left = [-8,1.1-dy,1.75-dx].join(',');
            break;
        case 'right':
            tf.pos_right = [-8, 0.3+dy, -1.45-dx].join(',');
            tf.pos_left = [-8, 0.3-dy, 1.45+dx].join(',');
            tf.disc_right = [-8, 0.6+dy, -1.45-dx].join(',');
            tf.disc_left = [-8, 0.6-dy, 1.45+dx].join(',');
            f.box_right = [-8, 1.1+dy, -1.45-dx].join(',');  // ?
            f.box_left = [-8, 1.1-dy, 1.45+dx].join(',');
            break;
        case 'horizon':
            tf.pos_right = [-8, 0.3, -1.75].join(',');
            tf.pos_left = [-8, 0.3, 1.75].join(',');
            tf.disc_right = [-8, 0.6, -1.75].join(',');
            tf.disc_left = [-8, 0.6, 1.75].join(',');
            f.box_right = [-8,1.1,-1.75].join(',');
            f.box_left = [-8,1.1,1.75].join(',');
            break;
    }
    [endscript]
    [3d_anim name="s4balance_main" rot="&tf.rot" time="500" wait="false"]
    [3d_anim name="s4balance_disc_prop_right" pos="&tf.pos_right" time="500" wait="false"]
    [3d_anim name="s4balance_disc_prop_left" pos="&tf.pos_left" time="500" wait="false"]
    [3d_anim name="s4balance_disc_right" pos="&tf.disc_right" time="500" wait="false"]
    [3d_anim name="s4balance_disc_left" pos="&tf.disc_left" time="500" wait="false"]
    [if exp="f.s4balance.disc.right.box"]
        [eval exp="tf.model = 's4' + f.s4balance.disc.right.box"]
        [3d_anim name="&tf.model" pos="&f.box_right" time="500" wait="false"]
    [endif]
    [if exp="f.s4balance.disc.left.box"]
        [eval exp="tf.model = 's4' + f.s4balance.disc.left.box"]
        [3d_anim name="&tf.model" pos="&f.box_left" time="500" wait="false"]
    [endif]
    [wait time="500"]
[endmacro]





[3d_show name="&tf.s4hint" pos="&getObjecttPos(tf.s4hint)" time="10" wait="false"]

[3d_show name="s4box1" pos="&getObjecttPos('s4box1')" time="10" wait="false"]
[3d_show name="s4box2" pos="&getObjecttPos('s4box2')" time="10" wait="false"]
[3d_show name="s4box3" pos="&getObjecttPos('s4box3')" time="10" wait="false"]
[3d_show name="s4box4" pos="&getObjecttPos('s4box4')" time="10" wait="false"]
[3d_show name="s4box5" pos="&getObjecttPos('s4box5')" time="10" wait="false"]

[3d_show name="s4balance_prop" pos="&getObjecttPos('s4balance_prop')" time="10" wait="false"]
[3d_show name="s4balance_base" pos="&getObjecttPos('s4balance_base')" time="10" wait="false"]
[3d_show name="s4balance_main" pos="&getObjecttPos('s4balance_main')" time="10" wait="false"]
[3d_show name="s4balance_disc_prop_right" pos="&getObjecttPos('s4balance_disc_prop_right')" time="10" wait="false"]
[3d_show name="s4balance_disc_prop_left" pos="&getObjecttPos('s4balance_disc_prop_left')" time="10" wait="false"]
[3d_show name="s4balance_disc_right" pos="&getObjecttPos('s4balance_disc_right')" time="10" wait="false"]
[3d_show name="s4balance_disc_left" pos="&getObjecttPos('s4balance_disc_left')" time="10" wait="false"]

[3d_show name="s4table" pos="&getObjecttPos('s4table')" time="10" wait="false"]
[3d_show name="s4table_base" pos="&getObjecttPos('s4table_base')" time="10" wait="true"]

[return]
