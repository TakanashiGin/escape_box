class TyranoPluginCircleTimer {
    constructor(pm){
        this.name = pm.name;
        this.layer = pm.layer;
        this.fix = $.toBoolean(pm.fix);
        this.time = parseInt(pm.time);
        this.storage = pm.storage;
        this.target = pm.target;
        this.left = parseInt(pm.left);
        this.top = parseInt(pm.top);
        this.rad = parseInt(pm.rad);
        this.front_color = pm.front_color;
        this.back_color = pm.back_color;
        this.stroke_color = pm.stroke_color;
        this.stroke_width = parseInt(pm.stroke_width);
        this.canvas = {
            name: `${this.name}_canvas`,
            left: '0px',
            top: '0px',
            width: `${$('#tyrano_base').width()}px`,
            height: `${$('#tyrano_base').height()}px`,
            zIndex: parseInt(pm.zindex)
        };
        this.clear = $.toBoolean(pm.clear);
        this.arc = -90;
        this.mode = 'set';
        this.interval_time = 0;
        this.loop = null;
        this.timeout = null;
        this.init();
    }
    init(){
        this.setCanvas();
        this.startInterval();
    }
    setCanvas(){
        const self = this;
        if (self.fix) $(`#tyrano_base`).append(`<canvas id='${self.canvas.name}' class='fixlayer'></canvas>`);
        else $(`.${self.layer}_fore`).append(`<canvas id='${self.canvas.name}'></canvas>`);
        $(`#${self.canvas.name}`).css({
            position:'absolute',
            left: self.canvas.left,
            top: self.canvas.top,
            width: self.canvas.width,
            height: self.canvas.height,
            zIndex: self.canvas.zIndex
        });
    }
    startInterval(){
        const self = this;
        const canvas = document.getElementById(this.canvas.name);
        this.drawCircle(canvas);
        this.drawArc(canvas);
        self.loop =()=> {
            const context = canvas.getContext( "2d" );
            context.clearRect(0, 0, $('#tyrano_base').width(), $('#tyrano_base').height());
            self.interval_time += 25;
            self.arc = (360 * (self.interval_time / self.time)) - 90;
            self.drawCircle(canvas);
            self.drawArc(canvas);
            if (self.arc < 270 && self.mode == 'set') self.timeout = setTimeout(self.loop,25);
            else if (self.mode != 'stop') self.endTimer(context);
        }
        self.timeout = setTimeout(self.loop,25);
    }
    drawCircle(canvas){
        const context = canvas.getContext( "2d" );
        context.beginPath();
        context.arc(this.left, this.top, this.rad, 0*Math.PI/180, 360*Math.PI/180, false);
        context.fillStyle = this.front_color;
        context.fill();
        this.stroke(context);
    }
    drawArc(canvas){
        const context = canvas.getContext('2d');
        context.fillStyle = this.back_color;
        context.beginPath();
        context.moveTo(this.left, this.top);
        context.arc(this.left, this.top, this.rad+0.1, (-90)*Math.PI/180, this.arc*Math.PI/180, false);
        context.closePath();
        context.fill();
        this.stroke(context);
    }
    stroke(context){
        if (this.stroke_color != 'none') {
            context.strokeStyle = this.stroke_color;
            context.lineWidth = this.stroke_width;
            context.stroke();
        }
    }
    endTimer(context){
        const self = this;
        if (self.clear) self.deleteTimer();
        if (this.mode == 'set') {
            tyrano.plugin.kag.ftag.startTag('jump',{
                storage: this.storage,
                target: this.target
            });
        }
    }
    deleteTimer(){
        const self = this;
        document.getElementById(this.canvas.name).getContext('2d').clearRect(0, 0, $('#tyrano_base').width(), $('#tyrano_base').height());
        $(`#${self.canvas.name}`).remove();
        TYRANO.kag.stat.f.circle_timer_array = TYRANO.kag.stat.f.circle_timer_array.filter(val => {
            if (val.name != self.name) return val;
        });
        console.log(TYRANO.kag.stat.f.circle_timer_array);
    }
}
tyrano.plugin.kag.tag.set_circle_timer = {
    vital: ['name'],
    pm: {
        layer: '0',
        fix: 'false',
        time: 3000,
        left: 0,
        top: 0,
        rad: 20,
        front_color: 'blue',
        back_color: 'gray',
        stroke_color: 'none',
        stroke_width: 5,
        clear: 'true',
        zindex: 999
    },
    start: function(pm){
        if (!TYRANO.kag.stat.f.circle_timer_array) TYRANO.kag.stat.f.circle_timer_array = [];
        TYRANO.kag.stat.f.circle_timer_array.forEach(val => {
            if (val.name == pm.name) {
                console.error(`[ERROR] ${pm.name} is already registered`);
                TYRANO.kag.ftag.nextOrder();
            }
        });
        TYRANO.kag.stat.f.circle_timer_array.push(new TyranoPluginCircleTimer(pm));
        console.log(TYRANO.kag.stat.f.circle_timer_array);
        this.kag.ftag.nextOrder();
    }
};
tyrano.plugin.kag.tag.ctrl_circle_timer = {
    vital: ['name'],
    pm: { content:'start' },
    start: function(pm){
        const f = TYRANO.kag.stat.f;
        if (!f.circle_timer_array) f.circle_timer_array = [];
        f.circle_timer_array.forEach(val => {
            if (pm.name == val.name) {
                switch(pm.content){
                    case 'stop':
                        val.mode = 'stop';
                        break;
                    case 'start':
                        if (val.mode != 'set') {
                            val.mode = 'set';
                            clearTimeout(val.timeout);
                            val.startInterval();
                        }
                        break;
                    case 'clear':
                        val.mode = 'clear';
                        break;
                    case 'delete':
                        val.deleteTimer();
                        break;
                }
            }
        });
        this.kag.ftag.nextOrder();
    }
};
tyrano.plugin.kag.tag.make_circle_timer = {
    start: function(pm){
        console.log(TYRANO.kag.stat.f.circle_timer_array);
        if (!TYRANO.kag.stat.f.circle_timer_array) TYRANO.kag.stat.f.circle_timer_array = [];
        console.log(TYRANO.kag.stat.f.circle_timer_array);
        for (let i=0; i<TYRANO.kag.stat.f.circle_timer_array; i++) {
            let val = TYRANO.kag.stat.f.circle_timer_array[i];
            console.log(val);
            console.log(val.init);
            document.getElementById(val.canvas.name).remove();
            val.init();
        }
        this.kag.ftag.nextOrder();
    }
};
(function(tag_names){
    tag_names.forEach(tag_name => {
        tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
        tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
    });
}(['set_circle_timer','ctrl_circle_timer','make_circle_timer']));
