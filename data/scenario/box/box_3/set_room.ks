




[iscript]
f.boxies = { box:[], map:[], pos:[], correct:[], broke:[] };
['blue','red','black'].forEach((c,i) => {
    for (let n=0; n<3; n++) f.boxies.box[n+(i*3)] = c + Number(n+1);
});
f.boxies.box = shuffleArray(f.boxies.box);
for (let i=0; i<3; i++) {
    f.boxies.map[i] = [];
    f.boxies.pos[i] = [];
    for (let j=0; j<3; j++) {
        f.boxies.map[i][j] = f.boxies.box[j+(i*3)];
        const x = 9;
        const y = i == 0? 2 : i == 1? 0 : -2;
        const z = j == 0? 2 : j == 1? 0 : -2;
        f.boxies.pos[i][j] = [x, y, z].join(',');
    }
}
const correct_color = sf.time_zone == 'day'? 'blue' : sf.time_zone == 'sunset'? 'red' : 'black';
for (let i=0; i<3; i++) f.boxies.correct[i] = correct_color + Number(i + 1);
$.log(f.boxies);
[endscript]





; バグ対策
[3d_model_new name="hammer" storage="hammer.gltf" pos="1,-9.5,-1" scale="0.15" rot="&getRotate(0,60,90)"]





[3d_show name="hammer" time="10" wait="false"]
[3d_show name="s3table1" time="10" wait="false"]
[3d_show name="s3table2" time="10" wait="false"]
[3d_show name="s3table3" time="10" wait="false"]
[for name="tf.i" from="0" len="&f.boxies.map.length"]
    [for name="tf.j" from="0" len="&f.boxies.map[tf.i].length"]
        [iscript]
        tf.obj = {
            name: 's3' + f.boxies.map[tf.i][tf.j],
            pos: f.boxies.pos[tf.i][tf.j]
        };
        [endscript]
        [3d_show name="&tf.obj.name" pos="&tf.obj.pos" time="10" wait="false"]
    [nextfor]
[nextfor]





[return]
