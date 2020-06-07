




tyrano.plugin.kag.tag["fall_mask"] = {




      vital: [],



      pm : {
          layer: "",
          canvas_width: $('#tyrano_base').width(),
          canvas_height: $('#tyrano_base').height(),
          color: "",
          zindex: "99999999"
      },




      start : function(pm) {



          console.log(pm);



          // 定数を定義（varを使っているのはV4対策）
          var WIDTH  = parseInt(pm.canvas_width);
          var HEIGHT = parseInt(pm.canvas_height);
          var SYSTEM = tyrano.plugin.kag.fall_mask;



          // colorを整理
          var colors = [];
          if (pm.color != "" && pm.color.indexOf('random') < 0) {
              colors = pm.color.split(',');
          }



          // canvasを追加
          if (pm.layer != "") $('.'+pm.layer+'_fore').append('<canvas id="fall_mask_canvas" style="position:absolute;"></canvas>');
          else $('#tyrano_base').append('<canvas id="fall_mask_canvas" style="position:absolute;"></canvas>');
          $('#fall_mask_canvas').attr({
              width: WIDTH,
              height: HEIGHT
          }).css({
              margin: "0 auto",
              display: "block",
              zIndex: pm.zindex
          });



          var cx = WIDTH / 2;
          var cy = HEIGHT / 2;
          var opt = { fillColor: pm.color };
          SYSTEM.addStar(cx, cy, 200, 5, 0, 120, opt, true);



          //window.requestAnimationFrame();



          this.kag.ftag.nextOrder();



      }




};





tyrano.plugin.kag.tag["fall_mask_off"] = {




    vital: [],



    pm : {
    },




    start : function(pm) {
    }




};





(function(tag_names){
    for (var tag_name, i = 0; i < tag_names.length; i++) {
        tag_name = tag_names[i];
        tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
        tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
    }
}(["fall_mask","fall_mask_off"]));
