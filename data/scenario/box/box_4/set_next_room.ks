[iscript]
f.s4balance = {
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
tf.s4hint = `s4hint${add_weight}`;
for (let i=1; i<=5; i++) {
    f.s4balance.boxies['box' + i] = {
        weight: weights[i-1]
    };
}
f.box_right = [-8,1.1,-1.75].join(',');
f.box_left = [-8,1.1,1.75].join(',');
$.log(f.s4balance);
[endscript]





[3d_show name="&tf.s4hint" pos="&getObjecttPos(tf.s4hint, true)" time="10" wait="false"]

[3d_show name="s4box1" pos="&getObjecttPos('s4box1', true)" time="10" wait="false"]
[3d_show name="s4box2" pos="&getObjecttPos('s4box2', true)" time="10" wait="false"]
[3d_show name="s4box3" pos="&getObjecttPos('s4box3', true)" time="10" wait="false"]
[3d_show name="s4box4" pos="&getObjecttPos('s4box4', true)" time="10" wait="false"]
[3d_show name="s4box5" pos="&getObjecttPos('s4box5', true)" time="10" wait="false"]

[3d_show name="s4balance_prop" pos="&getObjecttPos('s4balance_prop', true)" time="10" wait="false"]
[3d_show name="s4balance_base" pos="&getObjecttPos('s4balance_base', true)" time="10" wait="false"]
[3d_show name="s4balance_main" pos="&getObjecttPos('s4balance_main', true)" time="10" wait="false"]
[3d_show name="s4balance_disc_prop_right" pos="&getObjecttPos('s4balance_disc_prop_right', true)" time="10" wait="false"]
[3d_show name="s4balance_disc_prop_left" pos="&getObjecttPos('s4balance_disc_prop_left', true)" time="10" wait="false"]
[3d_show name="s4balance_disc_right" pos="&getObjecttPos('s4balance_disc_right', true)" time="10" wait="false"]
[3d_show name="s4balance_disc_left" pos="&getObjecttPos('s4balance_disc_left', true)" time="10" wait="false"]

[3d_show name="s4table" pos="&getObjecttPos('s4table', true)" time="10" wait="false"]
[3d_show name="s4table_base" pos="&getObjecttPos('s4table_base', true)" time="10" wait="true"]





[return]
