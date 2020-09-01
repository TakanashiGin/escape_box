



[iscript]
f.s5rots = [];
f.s5correct = [];
const dir = ['right','left','up','down'];
var orientation = 'horizon';
for (let i=0; i<4; i++) {
    var d = dir[getRand(0,3)];
    if (orientation != 'horizon') d = orientation == 'up'? 'down' : 'up';
    orientation = orientation == 'horizon' && (d == 'up' || d == 'down')? d : 'horizon';
    f.s5correct[i] = d;
    const per = d == 'up'? 0 : d == 'left'? 1 : d == 'down'? 2 : 3;
    f.s5rots[i] = getRotate(90*per, 90, 0);
}
[endscript]




[3d_show name="s5arrow1" pos="-9.5,-1,-15" rot="&f.s5rots[0]" scale="2.5,2.5,0.1" time="10" wait="false"]
[3d_show name="s5num1" pos="-9.5,1.5,-15" rot="&getRotate(0,90,0)" scale="2,2,0.1" time="10" wait="false"]

[3d_show name="s5arrow2" pos="-9.5,-1,-18.25" rot="&f.s5rots[1]" scale="2.5,2.5,0.1" time="10" wait="false"]
[3d_show name="s5num2" pos="-9.5,1.5,-18.25" rot="&getRotate(0,90,0)" scale="2,2,0.1" time="10" wait="false"]

[3d_show name="s5arrow3" pos="-9.5,-1,-21.75" rot="&f.s5rots[2]" scale="2.5,2.5,0.1" time="10" wait="false"]
[3d_show name="s5num3" pos="-9.5,1.5,-21.75" rot="&getRotate(0,90,0)" scale="2,2,0.1" time="10" wait="false"]

[3d_show name="s5arrow4" pos="-9.5,-1,-25" rot="&f.s5rots[3]" scale="2.5,2.5,0.1" time="10" wait="false"]
[3d_show name="s5num4" pos="-9.5,1.5,-25" rot="&getRotate(0,90,0)" scale="2,2,0.1" time="10" wait="true"]




[iscript]
f.s5room_system = {
    correct: [],
    dir: [],
    clear: false,
    correct_se: false,
};
f.s5room_system.correct = f.s5correct;
$.log(f.s5room_system);
[endscript]




[return]
