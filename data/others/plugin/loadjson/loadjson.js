tyrano.plugin.kag.tag.loadjson = {

  pm: { var: '', log: 'false', time: '10', wait: 'true' },

  start: function(pm){

    var that = this;

    var sf = this.kag.variable.sf;
        f = this.kag.stat.f;
        tf = this.kag.variable.tf;
        mp = this.kag.stat.mp;

    var src = './data/others/' + pm.src;

    $.getJSON(src, function(json_data) {
      if (pm.log != 'false') console.log(json_data);
      if (pm.var != '') eval(pm.var + '= json_data');
    });

    if (pm.wait != 'true') this.kag.ftag.nextOrder();
    setTimeout(function(){that.kag.ftag.nextOrder();}, parseInt(pm.time));

  }
};

(function(tag_names){
  var tag_name = 'loadjson';
  tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
  tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
}());
