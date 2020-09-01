[iscript]
f.s1qbox = {
    pos: [ "7.5,-0.6,-22", "7.5,-0.6,-20", "7.5,-0.6,-18" ],
    box: [ 'box1', 'box2', 'box3' ],
    correct: [],
    num_pos: [ '9.5,1.2,-22.6', '9.5,1.2,-20', '9.5,1.2,-17.4' ]
};
while(f.s1qbox.correct.length == 0 || f.s1qbox.correct.filter((v,i) => v == f.s1qbox.box[i]).length == f.s1qbox.box.length){
    f.s1qbox.correct = shuffleArray(f.s1qbox.box);
}
f.s1pbox = {
    index: [1,2,3],
    color_pos: [ "-9.5,-1,-18", "-9.5,-1,-20", "-9.5,-1,-22" ],
    num_pos: [ "-9.5,1,-17.9", "-9.5,1,-20", "-9.5,1,-22.1" ]
};
f.s1pbox.color = f.s1qbox.correct.map(c => [...c].pop()).map(num => `s1color${num}`);
f.s1pbox.num = f.s1pbox.index.map(num => `s1num${num}_left`);
f.s1pbox.index = shuffleArray(f.s1pbox.index);
f.s1pbox.index.map(num => {
    const that = f.s1pbox;
    const i = num - 1;
    return {
        color: that.color[i],
        num: that.num[i],
    }
}).forEach((value,i) => {
    const that = f.s1pbox;
    that.color[i] = value.color;
    that.num[i] = value.num;
});
[endscript]

[for name="tf.i" from="0" len="3"]
    [iscript]
    tf.qn = `s1${f.s1qbox.box[tf.i]}`;
    tf.qp = f.s1qbox.pos[tf.i];
    tf.qnn = `s1num${tf.i+1}_right`;
    tf.qnp = f.s1qbox.num_pos[tf.i];
    tf.pn = f.s1pbox.color[tf.i];
    tf.pp = f.s1pbox.color_pos[tf.i];
    tf.nn = f.s1pbox.num[tf.i];
    tf.np = f.s1pbox.num_pos[tf.i];
    [endscript]
    [3d_show name="&tf.qn" pos="&tf.qp" time="10" wait="false"]
    [3d_show name="&tf.qnn" pos="&tf.qnp" rot="&getRotate(0,90,0)" scale="1.5,1.5,0.1" time="10" wait="false"]
    [3d_show name="&tf.pn" pos="&tf.pp" time="10" wait="false"]
    [3d_show name="&tf.nn" pos="&tf.np" rot="&getRotate(0,90,0)" scale="1.5,1.5,0.1" time="10" wait="false"]
[nextfor]

[iscript]
const object = f.next_room_object.box.filter(v => v.name == 's1table').pop();
tf.pos = object.pos.split(',').map(Number);
tf.pos[2] -= 20;
tf.pos = tf.pos.join(',');
[endscript]
[3d_show name="s1table" pos="&tf.pos" time="10" wait="true"]

[return]
