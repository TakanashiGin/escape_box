




[iscript]
f.s3boxies = { box:[], map:[], pos:[], correct:[] };
f.s3number = { nums:[], map:[], pos:[], correct:[] };
f.s3panel = { pushed_num:[], pushed_obj:[] };

const boxies = f.s3boxies;
const number = f.s3number;

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

$.log(f.s3boxies);
$.log(f.s3number);
[endscript]





; バグ対策
[3d_model_new name="hammer" storage="hammer.gltf" pos="1,-9.5,-1" scale="0.15" rot="&getRotate(0,60,90)"]





[3d_show name="hammer" pos="&getObjecttPos('hammer', true)" time="10" wait="false"]
[3d_show name="s3table1" pos="&getObjecttPos('s3table1', true)" time="10" wait="false"]
[3d_show name="s3table2" pos="&getObjecttPos('s3table2', true)" time="10" wait="false"]
[3d_show name="s3table3" pos="&getObjecttPos('s3table3', true)" time="10" wait="false"]
[for name="tf.i" from="0" len="&f.s3boxies.map.length"]
    [for name="tf.j" from="0" len="&f.s3boxies.map[tf.i].length"]
        [iscript]
        const box_pos = f.s3boxies.pos[tf.i][tf.j].split(',').map(Number);
        const num_pos = f.s3number.pos[tf.i][tf.j].split(',').map(Number);
        box_pos[2] -= 20;
        num_pos[2] -= 20;
        tf.box = {
            name: 's3' + f.s3boxies.map[tf.i][tf.j],
            pos: box_pos.join(',')
        };
        tf.num = {
            name: 's3hint' + f.s3number.map[tf.i][tf.j],
            pos: num_pos.join(',')
        };
        [endscript]
        [3d_show name="&tf.box.name" pos="&tf.box.pos" time="10" wait="false"]
        [3d_show name="&tf.num.name" pos="&tf.num.pos" rot="&getRotate(0,-90,0)" scale="1,1,0.01" time="10" wait="false"]
    [nextfor]
[nextfor]



[3d_show name="s3num_box" pos="-9.5,0.1,-20" rot="&getRotate(0,90,0)" scale="0.35" time="10" wait="false"]
[3d_show name="s3b1" pos="-9.3,1,-19" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b2" pos="-9.3,1,-20" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b3" pos="-9.3,1,-21" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b4" pos="-9.3,0,-19" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b5" pos="-9.3,0,-20" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b6" pos="-9.3,0,-21" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b7" pos="-9.3,-1,-19" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b8" pos="-9.3,-1,-20" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3b9" pos="-9.3,-1,-21" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3ok" pos="-9.3,-2,-19.5" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3back" pos="-9.3,-2,-20.5" rot="&getRotate(0,90,0)" scale="1,1,0.01" time="10" wait="false"]
[3d_show name="s3num_monitor" pos="-9.3.4,2.2,-20" rot="&getRotate(0,90,0)" scale="0.35" time="10" wait="false"]





[return]






[return]
