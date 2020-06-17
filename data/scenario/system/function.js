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

function getRadian(c){ return c * Math.PI / 180; }

function getMeasuringDegrees(rad){return Math.round(rad*180/Math.PI/10)*10}

function getRotate(x,y,z){
    let rad = [
        getRadian(parseInt(x)),
        getRadian(parseInt(y)),
        getRadian(parseInt(z))
    ];
    return rad.join(',');
}

const getModel = name => TYRANO.kag.tmp.three.models[name];

function getStage(s){
    return (!Number.isNaN(parseInt(s)))? `box_${s}` : s;
}
