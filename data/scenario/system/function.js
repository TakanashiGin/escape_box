function getTimeZone(n){
    switch (n) {
        case 0: return 'day'; break;
        case 1: return 'sunset'; break;
        case 2: return 'night'; break;
        default:
            const hour = new Date().getHours();
            if (hour >= 21 || hour < 6) return 'night';
            else if (hour >= 18 && hour < 21) return 'sunset';
            else return 'day';
            break;
    }
}

function getCenter(coordinate, val){
  if (coordinate == 'x') {
    var t_width = $('#tyrano_base').width();
    return (t_width - val) / 2;
  } else if (coordinate == 'y') {
    var t_height = $('#tyrano_base').height();
    return (t_height - val) / 2;
  }
}

function getRand(min,max){
    max = Number(max)
    min = Number(min)
    var rand = min + Math.floor(Math.random() * (max - min + 1))
    //console.log("randNum: " + rand);
    return rand;
}

function shuffleArray(arr){
    return arr.map(a=>{
        return {w:Math.random(),v:a};
    }).sort((a,b)=>a.w-b.w).map(a=>a.v);
}

function getRadian(c){return c*Math.PI/180}

function getMeasuringDegrees(rad){return Math.round(rad*180/Math.PI/10)*10}

function getRotate(x=0,y,z){
    const rads = [x,y,z];
    return (rads.every(d=>!!d||parseInt(d)===0)?rads.map(d=>getRadian(parseInt(d))):rads.map(d=>getRadian(parseInt(x)))).join(',');
}

const getModel = name => TYRANO.kag.tmp.three.models[name];

function getStage(s){
    return (!Number.isNaN(parseInt(s)))? `box_${s}` : s;
}

function getOriginObjectData(s){
    const TG = TYRANO.kag;
    const f = TG.stat.f;
    const sf = TG.variable.sf;
    return sf.stage_data['box_' + s].objects;
}

function getObjecttPos(name, next=false){
    const pos = tyrano.plugin.kag.tmp.three.models[name].pm.pos.split(',').map(Number);
    if (next) pos[2] -= 20;
    return pos.join(',');
}
