tyrano.plugin.kag.tag.time_out = {
    pm: { name: 'set_timeout', time:'3000' },
    start: function (pm){
        if (!TYRANO.kag.stat.f.time_out_array) TYRANO.kag.stat.f.time_out_array = [];
        pm.time = parseInt(pm.time);
        TYRANO.kag.stat.f.time_out_array.push(new TyranoPluginSetTimeout(pm));
        this.kag.ftag.nextOrder();
    }
};
tyrano.plugin.kag.tag.clear_time_out = {
    pm: { name: 'set_timeout', all: 'false' },
    start: function(pm){
        if (!TYRANO.kag.stat.f.time_out_array) TYRANO.kag.stat.f.time_out_array = [];
        if (pm.all == 'true') {
            TYRANO.kag.stat.f.time_out_array = TYRANO.kag.stat.f.time_out_array.forEach(function(value){
                clearInterval(value.func);
            });
            TYRANO.kag.stat.f.time_out_array = [];
        } else {
            TYRANO.kag.stat.f.time_out_array = TYRANO.kag.stat.f.time_out_array.filter(function(value){
                if (value.name == pm.name) clearInterval(value.func);
                else return value;
            });
        }
        this.kag.ftag.nextOrder();
    }
};
tyrano.plugin.kag.tag.make_time_out = {
    start: function(){
        if (!TYRANO.kag.stat.f.time_out_array) TYRANO.kag.stat.f.time_out_array = [];
        TYRANO.kag.stat.f.time_out_array.forEach(function(value){
            value.interval();
        });
        this.kag.ftag.nextOrder();
    }
};
(function(tag_names){
    tag_names.forEach(function(tag_name){
        tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
        tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
    });
}(['time_out','clear_time_out','make_time_out']));