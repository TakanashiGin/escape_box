




[iscript]
f.boxies = { box:[], map:[], pos:[], correct:[] };
f.number = { nums:[], map:[], pos:[], correct:[] };
f.panel = { pushed_num:[], pushed_obj:[] };

const boxies = f.boxies;
const number = f.number;

['blue','red','black'].forEach((c,i) => {
    for (let n=0; n<3; n++) boxies.box[n+(i*3)] = c + Number(n+1);
});
boxies.box = shuffleArray(boxies.box);

for (let i=1; i<=9; i++) number.nums[i] = i;
number.nums = shuffleArray(number.nums);

for (let i=0; i<3; i++) {
    boxies.map[i] = [];
    boxies.pos[i] = [];
    number.map[i] = [];
    number.pos[i] = [];
    for (let j=0; j<3; j++) {
        boxies.map[i][j] = boxies.box[j+(i*3)];
        number.map[i][j] = number.nums[j+(i*3)];
        const x = 9;
        const y = i == 0? 2 : i == 1? 0 : -2;
        const z = j == 0? 2 : j == 1? 0 : -2;
        boxies.pos[i][j] = [x, y, z].join(',');
        number.pos[i][j] = [x, y, z].join(',');
    }
}

const correct_color = sf.time_zone == 'day'? 'blue' : sf.time_zone == 'sunset'? 'red' : 'black';
for (let i=0; i<3; i++) boxies.correct[i] = correct_color + Number(i + 1);

boxies.map.forEach((sid,i) => {
    sid.forEach((ver,j) => {
        if (boxies.correct.indexOf(ver) != -1) number.correct.push(number.map[i][j]);
    });
});

$.log(f.boxies);
$.log(f.number);
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
        tf.box = {
            name: 's3' + f.boxies.map[tf.i][tf.j],
            pos: f.boxies.pos[tf.i][tf.j]
        };
        tf.num = {
            name: 's3hint' + f.number.map[tf.i][tf.j],
            pos: f.number.pos[tf.i][tf.j]
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
