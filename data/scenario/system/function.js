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

function getLoadingText(){
    const lt = TYRANO.kag.variable.sf.loading_text;
    const text = lt[getRand(0, lt.length-1)];
    var val = `[HINT]<br><br>${text}<br><br>Now Loading`;
    var array = [];
    for (let i=0; i<4; i++) {
        array[i] = val;
        for (let j=0; j<i+1; j++) {
            array[i] += '…';
        }
    }
    return array;
}

function getMediaFile(type, name){
    const browser = !($.isTyranoPlayer() || $.isElectron() || $.isNWJS());
    const format = type=='bgm'||type=="se"? browser? 'm4a' : 'ogg' : browser? 'mp4' : 'webm';
    return `${format}/${name}.${format}`;
};
function getSe(name='click'){
    return getMediaFile('se', name);
}

$.showSystemButton = () => {
    $('#tyrano_base').append($(`<img id="back_title_button" src="./data/image/back_title.png">`).css({
        position: 'absolute',
        left: '1125px',
        top: '135px',
        width: 144,
        height: 39,
        zIndex: 99999999
    }).on({
        mouseover: () => $(this).css('src', './data/image/back_title2.png'),
        mouseout: () => $(this).css('src', './data/image/back_title.png'),
        click: () => tyrano.plugin.kag.ftag.startTag('jump', { storage:'main.ks', target:'back_title' })
    }));
}
$.hideSystemButton = () => $('#back_title_button').remove();
