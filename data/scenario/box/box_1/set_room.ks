
[3d_show name="s1table"]
[iscript]
f.qbox = {
    pos: [ "7.5,-0.6,-2", "7.5,-0.6,0", "7.5,-0.6,2" ],
    box: [ 'box1', 'box2', 'box3' ],
    correct: [ 'box3', 'box1', 'box2' ]
};
[endscript]
[for name="tf.i" from="0" len="3"]
    [iscript]
    tf.n = `s1${f.qbox.box[tf.i]}`;
    tf.p = f.qbox.pos[tf.i];
    [endscript]
    [3d_show name="&tf.n" pos="&tf.p" time="10" wait="false"]
[nextfor]

[return]
