[macro name="destroy"]
  [iscript]
  window.pdestroy = {
      hidemenubutton: mp.hidemenubutton || "true",
                  cm: mp.cm || "true",
            clearfix: mp.clearfix || "true",
      free_layermode: mp.free_layermode || "true",
         free_filter: mp.free_filter || "true",
        reset_camera: mp.reset_camera || "true",
           freeimage: mp.freeimage || "true",
              layopt: mp.layopt || "true",
               layer: mp.layer || "",
               avoid: mp.avoid || "",
  };
  if (!pdestroy.avoid) pdestroy.avoid = pdestroy.avoid.split(',');
  if (!pdestroy.layer) {
    pdestroy.layer = (function(TG){
      var layers = [
        {layer: 'base', page: 'fore'},
        {layer: 'base', page: 'back'},
      ];
      for (var i=0; i<TG.config.numCharacterLayers; i++) {
        var l = String(i);
        if (!pdestroy.avoid.includes(l)) {
          layers.push({layer: l, page: 'fore'});
          layers.push({layer: l, page: 'back'});
        }
      }
      for (var i=0; i<TG.config.numMessageLayers; i++) {
        var l = 'message' + i;
        if (!pdestroy.avoid.includes(l)) {
          layers.push({layer: l, page: 'fore'});
          layers.push({layer: l, page: 'back'});
        }
      }
      if (!pdestroy.avoid.includes('fix')) layers.push({layer: 'fix',  page: void(0)});
      return layers;
    }(tyrano.plugin.kag));
  } else {
    var ls = pdestroy.layer.split(',');
    pdestroy.layer = [];
    ls.forEach(function(v){
      if (v=='fix') pdestroy.layer.push({layer:v,page:void(0)});
      else {
        pdestroy.layer.push({layer:v,page:'fore'});
        pdestroy.layer.push({layer:v,page:'back'});
      }
    });
  }
  [endscript]
  [hidemenubutton cond="pdestroy.hidemenubutton == 'true'"]
  [cm cond="pdestroy.cm == 'true'"]
  [clearfix cond="pdestroy.clearfix == 'true'"]
  [free_layermode time="1" cond="pdestroy.free_layermode == 'true'"]
  [free_filter cond="pdestroy.free_filter == 'true'"]
  [reset_camera time="1" cond="pdestroy.reset_camera == 'true'"]
  [eval exp="pdestroy.i = 0"]
*freeimage
  [iscript]
  pdestroy.l = pdestroy.layer[pdestroy.i].layer;
  pdestroy.bool = pdestroy.freeimage == 'true' && pdestroy.l != 'fix' && String(pdestroy.l).indexOf('message') < 0;
  [endscript]
  [freeimage layer="&pdestroy.l" time="1" cond="pdestroy.bool"]
  [eval exp="pdestroy.i++"]
  [jump target="freeimage" cond="pdestroy.i < pdestroy.layer.length"]
  [eval exp="pdestroy.i = 0"]
*layopt
  [iscript]
  pdestroy.l = pdestroy.layer[pdestroy.i].layer;
  pdestroy.bool = pdestroy.layopt == 'true' && String(pdestroy.l).indexOf('base') < 0;
  [endscript]
  [layopt layer="&pdestroy.l" visible="false" cond="pdestroy.bool"]
  [eval exp="pdestroy.i++"]
  [jump target="layopt" cond="pdestroy.i < pdestroy.layer.length"]
  [iscript]
  delete window.pdestroy;
  [endscript]
[endmacro]
[return]
