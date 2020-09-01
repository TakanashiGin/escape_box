[iscript]
f.s1qbox.pos = [ "7.5,-0.6,-2", "7.5,-0.6,0", "7.5,-0.6,2" ];
f.s1qbox.num_pos = [ '9.5,1.2,-2.6', '9.5,1.2,0', '9.5,1.2,2.6' ];
f.s1pbox.color_pos = [ "-9.5,-1,2", "-9.5,-1,0", "-9.5,-1,-2" ];
f.s1pbox.num_pos = [ "-9.5,1,2.1", "-9.5,1,0", "-9.5,1,-2.1" ];
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

[eval exp="tf.pos = getOriginObjectData(f.rooms[f.current]).box.filter(v => v.name == 's1table').pop().pos"]
[3d_show name="s1table" pos="&tf.pos" time="10" wait="true"]

[return]
