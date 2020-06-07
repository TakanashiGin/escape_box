class ScrollLayer {
    constructor(pm){
        this.name = pm.name || 'scroll';
        this.layer = pm.layer || 0;
        this.x = pm.x || 0;
        this.y = pm.y || 0;
        this.width = pm.width;
        this.height = pm.height;
        this.dir = pm.dir || 'vertical';
        this.graphic = pm.graphic || void(0);
        this.frame_loop = false;
        this.mouse = { x:0, y:0 };
    }
    show(){
        $('#tyrano_base').append(`<div class="${this.name} fixlayer"></div>`);
        $(`.${this.name}`).css({
            position: 'absolute',
            left: `${this.x}px`,
            top: `${this.x}px`,
            width: `${this.width}px`,
            height: `${this.height}px`,
            backgroundImage: `./data/image/${this.graphic}`,
            zIndex: 9999999999
        });
        this.event();
    }
    event(){
        const requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
        window.requestAnimationFrame = requestAnimationFrame;
        let loop =()=> {
            let tmp = {
                x: event.clientX,
                y: event.clientY
            };
            console.log(this.mouse);
            console.log(tmp);
            if (this.frame_loop) window.requestAnimationFrame(loop);
        }
        $(`.${this.name}`).on('mousedown', e => {
            this.frame_loop = true;
            this.mouse.x = e.clientX;
            this.mouse.y = e.clientY;
            $(`.${this.name}`).on('mouseup',()=>{
                this.frame_loop = false;
                $(`.${this.name}`).off('mouseup');
            });
            loop();
        });
    }
}
tyrano.plugin.kag.stat.f.scroll_layer = [];
tyrano.plugin.kag.tag.scroll_layer = {
    vital: [],
    pm: {},
    start: function(pm){
        let tgf = tyrano.plugin.kag.stat.f;
        tgf.scroll_layer.push(new ScrollLayer(pm));
        let index = tgf.scroll_layer.length - 1;
        tgf.scroll_layer[index].show();
    }
};
(function(tag_names){
    let tag_name = 'scroll_layer';
    tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
    tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
}());