var TyranoPluginSetTimeout = function(pm){
    var self = this;
    this.name = pm.name;
    this.time = pm.time / 100;
    this.storage = pm.storage;
    this.target = pm.target;
    this.interval_time = 0;
    this.func;
    this.interval = function(){
        self.func = setInterval(function(){
            self.interval_time++;
            if (self.interval_time >= self.time) {
                TYRANO.kag.stat.f.time_out_array = TYRANO.kag.stat.f.time_out_array.filter(function(value){
                    if (value.name == self.name) clearInterval(value.func);
                    else return value;
                });
                tyrano.plugin.kag.ftag.startTag('jump', {
                    storage: self.storage,
                    target: self.target
                });
            }
        },100);
    }
    this.interval();
}