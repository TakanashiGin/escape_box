tyrano.plugin.kag.destroy = {


  getLayersArray: function(TG){
    var layers = [
      {layer: 'base', page: 'fore'},
      {layer: 'base', page: 'back'},
    ];
    for (var i=0; i<TG.config.numCharacterLayers; i++) {
      var l = i;
      layers.push({layer: l, page: 'fore'});  // 前景レイヤ（表）
      layers.push({layer: l, page: 'back'});  // 前景レイヤ（裏）
    }
    for (var i=0; i<TG.config.numMessageLayers; i++) {
      var l = 'message' + i;
      layers.push({layer: l, page: 'fore'});  // メッセージレイヤ（表）
      layers.push({layer: l, page: 'back'});  // メッセージレイヤ（裏）
    }
    return layers;
  },


  hideMenuButton: function(TG){
    $(".button_menu").hide();
    TG.stat.visible_menu_button = false;
    TG.config.configVisible = "false";
  },


  cm: function(TG){
    TG.ftag.hideNextImg();
    if(TG.stat.vchat.is_active){
      TG.ftag.startTag("vchat_in",{});
    }else{
      TG.layer.clearMessageInnerLayerAll();
    }
    TG.stat.log_clear = true;
    TG.layer.getFreeLayer().html("").hide();
    TG.ftag.startTag("resetfont");
  },


  clearFix: function(TG){
    $(".fixlayer").remove();
  },


  freeLayerMode: function(TG){
    TG.ftag.hideNextImg();
    var blend_layer = {};
    blend_layer = $(".blendlayer");
    var cnt = blend_layer.length;
    var n = 0;
    if (cnt==0) return;  // フリーにするレイヤがない場合
    blend_layer.each(function(){
      var blend_obj = $(this);
      blend_obj.fadeOut(parseInt(0.1),function(){
        blend_obj.remove();
        n++;
        if (cnt==n) return
      });
    });
  },


  freeFilter: function(TG){
    //var filter_str ="";
    $(".tyrano_filter_effect").css({
      "-webkit-filter" : "",
      "-ms-filter" : "",
      "-moz-filter" : ""
    }).removeClass("tyrano_filter_effect");
  },


  freeImage: function(TG){
    var ptime = 10;  // pm.timeの代わり
    var layers = TG.destroy.getLayersArray(TG);
    layers.forEach(function(v){
      if (v.layer != "base") {
        var j_obj = TG.layer.getLayer(v.layer, v.page).children();  // 前景レイヤの場合、全部削除・非表示にした後、削除する
        if (!j_obj.get(0)) return;  //存在しない場合は即return
        var cnt = 0;
        var s_cnt = j_obj.length;
        j_obj.animate(
          {"opacity":0},
          ptime,
          function(){
            TG.layer.getLayer(v.layer, v.page).empty();
            cnt++;
            if(s_cnt == cnt)return;
          }
        );
      } else {
        TG.layer.getLayer(v.layer, v.page).css("background-image", "");
        return;
      }
    });
  },


  layerOption: function(TG){
    var layers = TG.destroy.getLayersArray(TG).filter(function(v){
      if (String(v.layer).indexOf('base') <= -1) {
        return v.layer;  // baseレイヤーは除去
      }
    });
    layers.push({layer:'fix',page:void(0)});  // fixレイヤーを追加
    layers.forEach(function(v){
      if (v.layer == "fix") var j_layer = $("#tyrano_base").find(".fixlayer");
      else var j_layer = TG.layer.getLayer(v.layer, v.page);
      j_layer.css("display", "none");
      j_layer.attr("l_visible", "false");
    });
  },


  startDestroy: function(TG,pm){
    if (pm.hidemenubutton == "true") {
      TG.destroy.hideMenuButton(TG);  // [hidemenubutton]
    }
    if (pm.cm == "true") {
      TG.destroy.cm(TG);              // [cm]
    }
    if (pm.clearfix == "true") {
      TG.destroy.clearFix(TG);        // [clearfix]
    }
    if (pm.free_layermode == "true") {
      TG.destroy.freeLayerMode(TG);   // [free_layermode time="10"]
    }
    if (pm.free_filter == "true") {
      TG.destroy.freeFilter(TG);      // [free_filter]
    }
    if (pm.freeimage == "true") {
      TG.destroy.freeImage(TG);       // [freeimage] - all layer
    }
    if (pm.layopt == "true") {
      TG.destroy.layerOption(TG);     // [layopt] - all layer
    }
  },


};





tyrano.plugin.kag.stat.stack["destroy"] = [];
tyrano.plugin.kag.tag["destroy"] = {


  vital: [],


  pm: {
    hidemenubutton: "true",
    cm: "true",
    clearfix: "true",
    free_layermode: "true",
    free_filter: "true",
    freeimage: "true",
    layopt: "true"
  },


  start: function(pm){

    this.kag.destroy.startDestroy(this.kag,pm);

    this.kag.ftag.nextOrder();

  }


};





(function(tag_names){
  for (var tag_name, i=0; i<tag_names.length; i++) {
    tag_name = tag_names[i];
    tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
    tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
  }
}(["destroy"]));

TYRANO.kag.ftag.master_tag.clearstack.start = function (pm) {
  if (pm.stack == "") {
    for (var key in this.kag.stat.stack) {
      this.kag.stat.stack[key] = [];
    }
  } else {
    this.kag.stat.stack[pm.stack] = [];
  }
  this.kag.ftag.nextOrder();
};
