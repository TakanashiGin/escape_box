class TyranoPluginCircleTimerImage {
    constructor(pass,width,height){
        this.width = width;
        this.height = height;
        this.pass = pass;
        this.image = new Image();
    }
    drawImage(context){
        const self = this;
        self.image.onload = function(){
            context.beginPath();
            context.drawImage(this, 0, 0, self.width*4, self.height*4, 0, 0, self.width, self.height);
        }
        self.image.src = self.pass;
    }
}





class TyranoPluginCircleTimer {




    constructor(pm){

        $.convertColorByCO = c => c.replace(/^0x([\da-f]{6})$/i, "#$1");

        const per = (function(){
            let sw = parseInt(tyrano.plugin.kag.config.scWidth), sh = parseInt(tyrano.plugin.kag.config.scHeight);
            if (sh >= sw) return sw / 1280;
            else return sh / 720;
        }());

        this.canvas_width = 1280 * per * parseFloat(pm.scale);
        this.canvas_height = 720 * per * parseFloat(pm.scale);
        this.scale = parseInt(pm.scale) || 1;
        this.name = pm.name;
        this.layer = pm.layer;
        this.fix = $.toBoolean(pm.fix);
        this.time = parseInt(pm.time);
        this.storage = pm.storage;
        this.target = pm.target;
        this.left = 150;
        this.top = 75;
        this.front_color = $.convertColorByCO(pm.front_color);
        this.back_color = $.convertColorByCO(pm.back_color);

        if (!!pm.front_graphic && pm.front_graphic !== 'none') {
            this.front_graphic = {
                pass: './data/image/' + pm.front_graphic,
            };
            this.front_graphic.obj = new TyranoPluginCircleTimerImage(this.front_graphic.pass,canvas_width,canvas_height);
        } else this.front_graphic = null;
        if (!!pm.back_graphic && pm.back_graphic !== 'none') {
            this.back_graphic = {
                pass: './data/image/' + pm.back_graphic,
            };
            this.back_graphic.obj = new TyranoPluginCircleTimerImage(this.back_graphic.pass,canvas_width,canvas_height);
        } else this.back_graphic = null;
        if (!!pm.end_graphic && pm.end_graphic !== 'none') {
            this.end_graphic = {
                pass: './data/image/' + pm.end_graphic,
            };
            this.end_graphic.obj = new TyranoPluginCircleTimerImage(this.end_graphic.pass,canvas_width,canvas_height);
        } else this.end_graphic = null;

        this.stroke_color = pm.stroke_color!='none'? $.convertColorByCO(pm.stroke_color) : null;
        this.stroke_width = this.stroke_color? parseInt(pm.stroke_width) : null;
        this.rad = this.stroke_color? this.top - parseFloat(pm.stroke_width) * 2 : this.top;
        this.end_color = $.convertColorByCO(pm.end_color);
        this.end_p = [...pm.end_p].pop() == '%'? parseInt(pm.end_p.split('').filter(v => v != '%').join('')) : parseInt(pm.end_p);

        this.canvas = {
            name: `${this.name}_canvas`,
            left: `${parseInt(pm.left) - (this.canvas_width / 2)}px`,
            top: `${parseInt(pm.top) - (this.canvas_height / 2)}px`,
            width: `${this.canvas_width}px`,
            height: `${this.canvas_height}px`,
            zIndex: parseInt(pm.zindex)
        };

        this.start = $.toBoolean(pm.start);
        this.clear = $.toBoolean(pm.clear);
        this.arc = -90;
        this.mode = 'set';
        this.interval_time = parseInt(pm.start_time);
        this.loop = null;
        this.timeout = null;

        this.init = function(){
            this.setCanvas();
            if (!this.start) this.mode = 'stop';
            this.startInterval();
            TYRANO.kag.stat.circle_timer_array.forEach(val => {
                if (val.timer.name == this.name) val.tmp = this;
            });
            //console.log(this);
            //console.log(TYRANO.kag.stat.circle_timer_array);
        }

        //console.log(this)

        //this.init();

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


        this.draw(canvas);


        self.loop =()=> {

            const context = canvas.getContext( "2d" );

            context.clearRect(0, 0, this.canvas_width, this.canvas_height);

            self.interval_time += 25;
            self.arc = (360 * (self.interval_time / self.time)) - 90;

            TYRANO.kag.stat.circle_timer_array.forEach(val => {
                if (val.timer.name == self.name) val.tmp = self;
            });

            self.draw(canvas);

            if (self.arc < 270 && self.mode == 'set') self.timeout = setTimeout(self.loop,25);
            else if (self.mode != 'stop') self.endTimer();

        }


        self.timeout = setTimeout(self.loop,25);


    }




    getTime(){
        return this.interval_time;
    }




    draw(canvas){

        if (this.front_graphic) this.drawCircleImage(canvas);
        else this.drawCircle(canvas);

        if (this.back_graphic) this.drawArcImage(canvas);
        else this.drawArc(canvas);

    }




    drawCircle(canvas){

        const context = canvas.getContext( "2d" );

        context.beginPath();
        context.arc(this.left, this.top, this.rad, 0*Math.PI/180, 360*Math.PI/180, false);

        if (this.interval_time / this.time >= this.end_p / 100) {
            if (this.end_graphic) {
                context.clip();
                this.end_graphic.obj.drawImage(context);
            } else {
                context.fillStyle = this.end_color && this.end_color !== 'none'? this.end_color : this.front_color;
                context.fill();
            }
        } else {
            context.fillStyle = this.front_color;
            context.fill();
        }

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




    drawCircleImage(canvas){
        /* 実装予定 */
        const context = canvas.getContext( "2d" );
        context.beginPath();
        context.arc(this.left, this.top, this.rad, 0*Math.PI/180, 360*Math.PI/180, false);
        context.clip();
        this.front_graphic.obj.drawImage(context);
        this.stroke(context);
    }




    drawArcImage(canvas){
        /* 実装予定 */
        const context = canvas.getContext('2d');
        context.beginPath();
        context.moveTo(this.left, this.top);
        context.arc(this.left, this.top, this.rad+0.1, (-90)*Math.PI/180, this.arc*Math.PI/180, false);
        //context.closePath();
        context.clip();
        this.drawImage(context,'./data/bgimage/title.jpg');
        this.stroke(context);
    }




    drawImage(context,pass){
        /* 実装予定 */
        const canvas_width = this.canvas_width;
        const canvas_height = this.canvas_height;
        const url = pass;
        const image = new Image();
        image.onload = function(){
            context.beginPath();
            context.drawImage(this, 0, 0, canvas_width*4, canvas_height*4, 0, 0, canvas_width, canvas_height);
        }
        image.src = url;
    }




    stroke(context){
        if (this.stroke_color != 'none') {
            context.strokeStyle = this.stroke_color;
            context.lineWidth = this.stroke_width;
            context.stroke();
        }
    }




    endTimer(){
        if (this.clear) this.deleteTimer();
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
        TYRANO.kag.stat.circle_timer_array = TYRANO.kag.stat.circle_timer_array.filter(val => val.timer.name != self.name);
    }




}





tyrano.plugin.kag.tag.set_circle_timer = {
    vital: ['name'],
    pm: {
        layer: '0',
        fix: 'false',
        time: 3000,
        start_time: 0,
        left: parseInt(tyrano.plugin.kag.config.scWidth) / 2,
        top: parseInt(tyrano.plugin.kag.config.scHeight) / 2,
        scale: 1,
        front_color: 'blue',
        back_color: 'gray',
        front_graphic: 'none',
        back_graphic: 'none',
        stroke_color: 'none',
        stroke_width: 5,
        end_color: 'none',
        end_graphic: 'none',
        end_p: '80%',
        start: 'true',
        clear: 'true',
        zindex: 999,
    },
    start: function(pm){
        var TG = this.kag;
        if (!TG.stat.circle_timer_array) TG.stat.circle_timer_array = [];
        if (parseInt(pm.time) < parseInt(pm.start_time)) {
            console.error('[ERROR] start_time is cannot be greater than time.');
            return false;
        }
        TG.stat.circle_timer_array.forEach(val => {
            if (val.timer.name == pm.name) {
                console.error(`[ERROR] ${pm.name} is already registered`);
                return false;
            }
        });
        TG.stat.circle_timer_array.push({
            tmp: null,
            timer: new TyranoPluginCircleTimer(pm)
        });
        TG.stat.circle_timer_array.forEach(val => {
            if (val.timer.name == pm.name) val.timer.init();
        });
        //console.log(TYRANO.kag.stat.circle_timer_array);
        this.kag.ftag.nextOrder();
    }
};





tyrano.plugin.kag.tag.ctrl_circle_timer = {
    vital: ['name'],
    pm: { content:'start' },
    start: function(pm){
        const stat = this.kag.stat;
        if (!stat.circle_timer_array) stat.circle_timer_array = [];
        stat.circle_timer_array.forEach(val => {
            if (pm.name == val.timer.name) {
                switch(pm.content){
                    case 'time':
                        if (pm.interval_time) val.timer.interval_time = val.timer.time <= parseInt(pm.interval_time)? val.timer.time : parseInt(pm.interval_time);
                        if (pm.max_time) val.timer.time = parseInt(pm.max_time);
                        break;
                    case 'stop':
                        val.timer.mode = 'stop';
                        break;
                    case 'start':
                        if (val.timer.mode != 'set') {
                            val.timer.mode = 'set';
                            clearTimeout(val.timer.timeout);
                            val.timer.startInterval();
                        }
                        break;
                    case 'clear':
                        val.timer.mode = 'clear';
                        break;
                    case 'delete':
                        val.timer.deleteTimer();
                        break;
                }
                val.tmp = val.timer;
            }
        });
        this.kag.ftag.nextOrder();
    }
};






tyrano.plugin.kag.tag.make_circle_timer = {
    start: function(pm){
        var stat = this.kag.stat;
        if (!stat.circle_timer_array) {
            stat.circle_timer_array = [];
            this.kag.ftag.nextOrder();
        }
        let array = stat.circle_timer_array;
        stat.circle_timer_array = [];
        array.forEach(val => {
            let keys = Object.keys(val.tmp), pm = {};
            keys.forEach(key => pm[key] = val['timer'][key]);
            stat.circle_timer_array.push({
                tmp: null,
                timer: new TyranoPluginCircleTimer(pm)
            });
            stat.circle_timer_array.forEach(val => {
                if (val.timer.name == pm.name) {
                    val.timer.interval_time = pm.interval_time;
                    val.timer.init();
                }
            });
        });
        this.kag.ftag.nextOrder();
    }
};





(function(tag_names){
    tag_names.forEach(tag_name => {
        tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
        tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
    });
}(['set_circle_timer','ctrl_circle_timer','make_circle_timer']));
