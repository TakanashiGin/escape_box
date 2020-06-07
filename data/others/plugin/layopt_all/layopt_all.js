tyrano.plugin.kag.tag.layopt_all = {


  vital: [],


  pm: {
    visible: "false",
    avoid: "",
    base: "false",
    fix: "true",
    all: "false",
    console: ""
  },


  start: function(pm){

    var avoid_layers = [];
    if (pm.avoid != "") avoid_layers = pm.avoid.split(',');

    var ref_layers = (function(TG){
      var layers = [];
      for (var i=0; i<TG.config.numCharacterLayers; i++) {
        var l = String(i);
        if (!avoid_layers.includes(l) || pm.all == "true") {
          layers.push({layer: l, page: 'fore'});
          layers.push({layer: l, page: 'back'});
        }
      }
      for (var i=0; i<TG.config.numMessageLayers; i++) {
        var l = 'message' + i;
        if (!avoid_layers.includes(l) || pm.all == "true") {
          layers.push({layer: l, page: 'fore'});
          layers.push({layer: l, page: 'back'});
        }
      }
      if (pm.fix == "true" || pm.all == "true") layers.push({ layer:'fix', page:void(0) });
      if (pm.base == "true" || pm.all == "true") {
        layers.push({layer:'base',page:"fore"});
        layers.push({layer:'base',page:"back"});
      }
      return layers;
    }(this.kag));

    if (pm.console == "true") {
      console.log('[reflection layers]');
      console.log(ref_layers);
      console.log('[refuse reflection layers]');
      console.log(avoid_layers);
    }

    ref_layers.forEach(function(v){
      if (v.layer == "fix") var j_layer = $("#tyrano_base").find(".fixlayer");
      else var j_layer = tyrano.plugin.kag.layer.getLayer(v.layer, v.page);
      if (pm.visible == "true") {
        if (v.page == "fore") j_layer.css("display", "");
        j_layer.attr("l_visible", "true");
      } else if (pm.visible == "false") {
        j_layer.css("display", "none");
        j_layer.attr("l_visible", "false");
      }
    });

    this.kag.ftag.nextOrder();

  }


};





(function(){
  var tag_name = "layopt_all";
  tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
  tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
}());
