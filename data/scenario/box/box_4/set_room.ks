[iscript]
f.balance = {
    disc: {
        right: {
            box: null,
            pos: 'horizon'
        },
        left: {
            box: null,
            pos: 'horizon'
        }
    },
    boxies: {},
    mode: 'horizon'
};
let weights = shuffleArray([1,2,3,4]);
let add_weight = getRand(1,4);
weights.push(add_weight);
tf.hint = `s4hint${add_weight}`;
for (let i=1; i<=5; i++) {
    f.balance.boxies['box' + i] = {
        weight: weights[i-1]
    };
}
tf.box_right = [-8,1.1,-1.75].join(',');
tf.box_left = [-8,1.1,1.75].join(',');
$.log(f.balance);
[endscript]

[macro name="balance"]
    [iscript]
    f.balance.mode = mp.weight;
    const disc = f.balance.disc;
    const r = 2;
    const deg = f.balance.mode=='right'? -25 : f.balance.mode=='left'? 25 : 0;
    const dx = r * (1 - Math.cos(getRadian(deg)));
    const dy = r * Math.sin(getRadian(deg));
    tf.rot = getRotate( deg, 0, 0 );
    switch(mp.weight){
        case 'left':
            tf.pos_right = [-8, 0.3+dy, -1.75+dx].join(',');
            tf.pos_left = [-8, 0.3-dy, 1.75-dx].join(',');
            tf.disc_right = [-8, 0.6+dy, -1.75+dx].join(',');
            tf.disc_left = [-8, 0.6-dy, 1.75-dx].join(',');
            tf.box_right = [-8,1.1+dy,-1.75+dx].join(',');
            tf.box_left = [-8,1.1-dy,1.75-dx].join(',');
            break;
        case 'right':
            tf.pos_right = [-8, 0.3+dy, -1.45-dx].join(',');
            tf.pos_left = [-8, 0.3-dy, 1.45+dx].join(',');
            tf.disc_right = [-8, 0.6+dy, -1.45-dx].join(',');
            tf.disc_left = [-8, 0.6-dy, 1.45+dx].join(',');
            tf.box_right = [-8, 1.1+dy, -1.45-dx].join(',');  // ?
            tf.box_left = [-8, 1.1-dy, 1.45+dx].join(',');
            break;
        case 'horizon':
            tf.pos_right = [-8, 0.3, -1.75].join(',');
            tf.pos_left = [-8, 0.3, 1.75].join(',');
            tf.disc_right = [-8, 0.6, -1.75].join(',');
            tf.disc_left = [-8, 0.6, 1.75].join(',');
            tf.box_right = [-8,1.1,-1.75].join(',');
            tf.box_left = [-8,1.1,1.75].join(',');
            break;
    }
    [endscript]
    [3d_anim name="s4balance_main" rot="&tf.rot" time="500" wait="false"]
    [3d_anim name="s4balance_disc_prop_right" pos="&tf.pos_right" time="500" wait="false"]
    [3d_anim name="s4balance_disc_prop_left" pos="&tf.pos_left" time="500" wait="false"]
    [3d_anim name="s4balance_disc_right" pos="&tf.disc_right" time="500" wait="false"]
    [3d_anim name="s4balance_disc_left" pos="&tf.disc_left" time="500" wait="false"]
    [if exp="f.balance.disc.right.box"]
        [eval exp="tf.model = 's4' + f.balance.disc.right.box"]
        [3d_anim name="&tf.model" pos="&tf.box_right" time="500" wait="false"]
    [endif]
    [if exp="f.balance.disc.left.box"]
        [eval exp="tf.model = 's4' + f.balance.disc.left.box"]
        [3d_anim name="&tf.model" pos="&tf.box_left" time="500" wait="false"]
    [endif]
    [wait time="500"]
[endmacro]

[3d_show name="&tf.hint"]

[3d_show name="s4box1" time="10" wait="false"]
[3d_show name="s4box2" time="10" wait="false"]
[3d_show name="s4box3" time="10" wait="false"]
[3d_show name="s4box4" time="10" wait="false"]
[3d_show name="s4box5" time="10" wait="false"]

[3d_show name="s4balance_prop" time="10" wait="false"]
[3d_show name="s4balance_base" time="10" wait="false"]
[3d_show name="s4balance_main" time="10" wait="false"]
[3d_show name="s4balance_disc_prop_right" time="10" wait="false"]
[3d_show name="s4balance_disc_prop_left" time="10" wait="false"]
[3d_show name="s4balance_disc_right" time="10" wait="false"]
[3d_show name="s4balance_disc_left" time="10" wait="false"]

[3d_show name="s4table" time="10" wait="false"]
[3d_show name="s4table_base" time="10" wait="true"]

[return]
