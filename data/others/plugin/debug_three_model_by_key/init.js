class DebugThreeModelByKey {
    constructor(name,model,d,start){
        this.name = name;
        this.model = model;
        this.d = d;
        if (start != 'false') this.start();
    }
    start(){
        const that = this;
        const model = that.model;
        $(window).on('keydown.' + that.name, de => {
            switch (de.keyCode) {
                case 65:  // a
                    var tmp = model.position.x;
                    model.position.x -= d;
                    console.log(`${tmp} => ${model.position.x}`);
                    break;
                case 68:  // d
                    var tmp = model.position.x;
                    model.position.x += d;
                    console.log(`${tmp} => ${model.position.x}`);
                    break;
                case 87:  // w
                    var tmp = model.position.z;
                    model.position.z -= d;
                    console.log(`${tmp} => ${model.position.z}`);
                    break;
                case 83:  // s
                    var tmp = model.position.z;
                    model.position.z += d;
                    console.log(`${tmp} => ${model.position.z}`);
                    break;
                case 81:  // q
                    var tmp = model.position.y;
                    model.position.y += d;
                    console.log(`${tmp} => ${model.position.y}`);
                    break;
                case 69:  // e
                    var tmp = model.position.y;
                    model.position.y -= d;
                    console.log(`${tmp} => ${model.position.y}`);
                    break;
            }
        });
    }
    stop(){
        const that = this;
        $(window).off('keydown.' + that.name);
    }
    delete(){
        this.stop();
        this.name = null;
        this.model = null;
        this.d = null;
    }
}



tyrano.plugin.kag.tag["set_debug_three_model_by_key"] = {
    pm: {
        name: 'camera',
        d: 0.5,
        start: 'true'
    },
    start: function(pm){
        const three = this.kag.tmp.three;
        const obj = pm.name == 'camera'? three.camera : three.models[pm.name];
        if (!obj) {
            if (!obj.debug_three_model_by_key.name) {
                obj.debug_three_model_by_key = new DebugThreeModelByKey(pm.name, obj, parseInt(pm.d), pm.start);
            } else {
                console.error(`[ERROR] There are already features added to ${pm.name}`);
            }
        } else {
            console.log(`[ERROR] ${pm.name} is not defined`);
        }
        this.kag.ftag.nextOrder();
    }
};



tyrano.plugin.kag.tag["ctrl_debug_three_model_by_key"] = {
    vital: ['name'],
    start: function(pm){
        const three = this.kag.tmp.three;
        const obj = pm.name == 'camera'? three.camera : three.models[pm.name];
        this.kag.ftag.nextOrder();
    }
};



(function(tags){
    tags.forEach(tag => {
        tyrano.plugin.kag.ftag.master_tag[tag] = object(tyrano.plugin.kag.tag[tag]);
        tyrano.plugin.kag.ftag.master_tag[tag].kag = TYRANO.kag;
    });
}(['set_debug_three_model_by_key', 'ctrl_debug_three_model_by_key']));
