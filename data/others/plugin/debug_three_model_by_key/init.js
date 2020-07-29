tyrano.plugin.kag.tag["debug_three_model_by_key"] = {


    pm: {
        target: 'camera',
        d: 0.5,
    },


    start: function(pm){
        const that = this;
        const three = TYRANO.kag.tmp.three;
        const target = pm.target == 'camera'? three.camera : three.models[pm.target]['model'];
        console.log(target);
        const d = parseFloat(pm.d);
        console.log(three);
        this.kag.tmp.debug_three_model_by_key = !this.kag.tmp.debug_three_model_by_key? false : true;
        if (this.kag.tmp.debug_three_model_by_key) {
            console.warn('[WARN] This debugging system is already activated.');
            this.kag.ftag.nextOrder();
        }
        $(window).on('keydown.debug_three_model_by_key', de => {
            //console.log(de.keyCode);
            switch (de.keyCode) {
                case 65:  // a
                    target.position.x -= d;
                    break;
                case 68:  // d
                    target.position.x += d;
                    break;
                case 87:  // w
                    target.position.z -= d;
                    break;
                case 83:  // s
                    target.position.z += d;
                    break;
                case 81:  // q
                    target.position.y += d;
                    break;
                case 69:  // e
                    target.position.y -= d;
                    break;
            }
        });
        this.kag.ftag.nextOrder();
    }


};



(function(tags){
    tags.forEach(tag => {
        tyrano.plugin.kag.ftag.master_tag[tag] = object(tyrano.plugin.kag.tag[tag]);
        tyrano.plugin.kag.ftag.master_tag[tag].kag = TYRANO.kag;
    });
}(['debug_three_model_by_key']));
