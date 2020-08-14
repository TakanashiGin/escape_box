[iscript]
/* -----
box1: 赤
box2: 青
box3: 緑
 ----- */
f.qbox = {
    pos: [ "7.5,-0.6,-2", "7.5,-0.6,0", "7.5,-0.6,2" ],
    box: [ 'box1', 'box2', 'box3' ],
    correct: [],
    num_pos: [ '9.5,1.2,-2.6', '9.5,1.2,0', '9.5,1.2,2.6' ]
};
while(f.qbox.correct.length == 0 || f.qbox.correct.filter((v,i) => v == f.qbox.box[i]).length == f.qbox.box.length){
    f.qbox.correct = shuffleArray(f.qbox.box);
}
f.pbox = {
    index: [1,2,3],
    color_pos: [ "-9.5,-1,2", "-9.5,-1,0", "-9.5,-1,-2" ],
    num_pos: [ "-9.5,1,2.1", "-9.5,1,0", "-9.5,1,-2.1" ]
};
f.pbox.color = f.qbox.correct.map(c => [...c].pop()).map(num => `s1color${num}`);
f.pbox.num = f.pbox.index.map(num => `s1num${num}_left`);
f.pbox.index = shuffleArray(f.pbox.index);
f.pbox.index.map(num => {
    const that = f.pbox;
    const i = num - 1;
    return {
        color: that.color[i],
        num: that.num[i],
    }
}).forEach((value,i) => {
    const that = f.pbox;
    that.color[i] = value.color;
    that.num[i] = value.num;
});
[endscript]

[for name="tf.i" from="0" len="3"]
    [iscript]
    tf.qn = `s1${f.qbox.box[tf.i]}`;
    tf.qp = f.qbox.pos[tf.i];
    tf.qnn = `s1num${tf.i+1}_right`;
    tf.qnp = f.qbox.num_pos[tf.i];
    tf.pn = f.pbox.color[tf.i];
    tf.pp = f.pbox.color_pos[tf.i];
    tf.nn = f.pbox.num[tf.i];
    tf.np = f.pbox.num_pos[tf.i];
    [endscript]
    [3d_show name="&tf.qn" pos="&tf.qp" time="10" wait="false"]
    [3d_show name="&tf.qnn" pos="&tf.qnp" rot="&getRotate(0,90,0)" scale="1.5,1.5,0.1" time="10" wait="false"]
    [3d_show name="&tf.pn" pos="&tf.pp" time="10" wait="false"]
    [3d_show name="&tf.nn" pos="&tf.np" rot="&getRotate(0,90,0)" scale="1.5,1.5,0.1" time="10" wait="false"]
[nextfor]

[3d_show name="s1table" time="10" wait="true"]

[return]
