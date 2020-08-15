



[iscript]
tf.rots = [];
tf.correct = [];
var orientation;
for (let i=0; i<4; i++) {
    const rand = getRand(0,3);
    tf.rots[i] = getRotate(...[90*rand, 90, 0]);
    tf.correct[i] = rand==0? 'up' : rand == 1? 'left' : rand == 2? 'down' : 'right';
    if (!orientation) {
        orientation = tf.correct[i];
    } else {
        if (orientation == 'up') {
            tf.correct[i] = 'down';
            orientation = 'horizon';
        } else if (orientation == 'down') {
            tf.correct[i] = 'up';
            orientation = 'horizon';
        } else {
            orientation = tf.correct[i];
        }
    }

    if (tf.correct[i-1] == 'up' || tf.correct[i-1] == 'down') {
        if (tf.correct[i-2] != 'up' && tf.correct[i-2] != 'down') {
            if (tf.correct[i-1] == 'up') {
                tf.rots[i] = getRotate(180,90,0);
                tf.correct[i] = 'down';
            } else if (tf.correct[i-1] == 'down') {
                tf.rots[i] = getRotate(0,90,0);
                tf.correct[i] = 'up';
            }
        }
    }
}
[endscript]




[3d_show name="s5arrow1" pos="-9.5,-1,5" rot="&tf.rots[0]" scale="2.5,2.5,0.1" time="10" wait="false"]
[3d_show name="s5num1" pos="-9.5,1.5,5" rot="&getRotate(0,90,0)" scale="2,2,0.1" time="10" wait="false"]

[3d_show name="s5arrow2" pos="-9.5,-1,1.75" rot="&tf.rots[1]" scale="2.5,2.5,0.1" time="10" wait="false"]
[3d_show name="s5num2" pos="-9.5,1.5,1.75" rot="&getRotate(0,90,0)" scale="2,2,0.1" time="10" wait="false"]

[3d_show name="s5arrow3" pos="-9.5,-1,-1.75" rot="&tf.rots[2]" scale="2.5,2.5,0.1" time="10" wait="false"]
[3d_show name="s5num3" pos="-9.5,1.5,-1.75" rot="&getRotate(0,90,0)" scale="2,2,0.1" time="10" wait="false"]

[3d_show name="s5arrow4" pos="-9.5,-1,-5" rot="&tf.rots[3]" scale="2.5,2.5,0.1" time="10" wait="false"]
[3d_show name="s5num4" pos="-9.5,1.5,-5" rot="&getRotate(0,90,0)" scale="2,2,0.1" time="10" wait="true"]




[iscript]
f.room_system = {
    correct: [],
    dir: [],
    clear: false,
    correct_se: false,
};
f.room_system.correct = tf.correct;
//console.log(f.room_system);
[endscript]




[return]
