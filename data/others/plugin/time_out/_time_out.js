tyrano.plugin.kag.time_out = {
  start: function(){
    return function(storage,target){
      tyrano.plugin.kag.ftag.startTag("jump",{
        storage: storage,
        target: target
      });
    }
  },
  running: {}
};
tyrano.plugin.kag.tag['time_out'] = {
  vitle: [],
  pm: {
    name: 'setTimeout',
    time: "3000",
    storage: "",
    target: ""
  },
  init: function(pm){
    var name = pm.name, time = parseInt(pm.time);
    this.kag.time_out.running[name] = setTimeout(this.kag.time_out.start(pm.storage,pm.target),time);
  }
}
tyrano.plugin.kag.tag['clear_time_out'] = {
  vitle: [],
  pm: {
    name: 'setTimeout',
    all: 'false'
  },
  init: function(pm){
    if (pm.all == 'true') {
      for (var key in this.kag.time_out.running) {
        clearTimeout(this.kag.time_out.running[key]);
      }
    } else {
      clearTimeout(this.kag.time_out.running[pm.name]);
    }
  }
}
(function(tag_names){
  for (var tag_name, i = 0; i < tag_names.length; i++) {
    tag_name = tag_names[i];
    tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
    tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
  }
}(["time_out","clear_time_out"]));
