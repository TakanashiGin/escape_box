tyrano.plugin.kag.tmp.pmask = {
    interval: 'off',
    interval_var: null,
    index: 1,
    changeText: function(text, array){
        if (array) {
            this.index++;
            if (array.length <= this.index) this.index = 0;
        }
        $('.pmask_text').html(text);
    },
    stopInterval: function(){
        clearInterval(this.interval_var);
        this.first = true;
        this.interval_var = null;
        this.interval = 'off';
        this.index = 1;
    }
};



tyrano.plugin.kag.tag.pmask = {

    pm: {
        time: 1000,
        effect:"fadeIn",
        color:"0x000000",
        graphic:"",
        folder:"",

        text_left: 0,
        text_top: 0,
        text_vertical: "false",
        text_value: "",
        text_size: "",
        text_face: "",
        text_color: "",
        text_bold: "",
        text_align: "left",
        text_edge: "",
        text_shadow: "",
        text_width:"",

        auto_change: "false",
        auto_change_interval: 10000,
        auto_change_random: 'true',
    },

    start: function(pm) {

        var that = this;
        that.kag.layer.hideEventLayer();

        var sc_width = parseInt(that.kag.config.scWidth);
        var sc_height = parseInt(that.kag.config.scHeight);

        var j_pmask = $("<div class='layer layer_pmask' data-effect='" + pm.effect + "' style='z-index:100000000;position:absolute;'>").css({
            "animation-duration": parseInt(pm.time)+"ms",
            "width": sc_width,
            "height": sc_height
        });

        var j_mask = $("<div class='layer layer_mask' style='z-index:0;position:absolute;'>").css({
            "width": sc_width,
            "height": sc_height
        });

        if (pm.color == "none") j_mask.css("background-color","");
        else j_mask.css("background-color", $.convertColor(pm.color));

        if(pm.graphic != ""){
            var folder = pm.foler != ""? pm.folder : "image";
            var storage_url = "";
            if(pm.graphic != ""){
                storage_url = "./data/" + folder + "/" + pm.graphic;
                j_pmask.css("background-image","url(" + storage_url + ")");
            }
        }

        if (pm.text_face == "") pm.text_face = that.kag.stat.font.face;

        if (pm.text_color == "") pm.text_color = $.convertColor(that.kag.stat.font.color);
        else pm.text_color = $.convertColor(pm.text_color);

        var font_new_style = {
            "color" : pm.text_color,
            "font-weight" : pm.text_bold,
            "font-style" : pm.text_style,
            "font-size" : pm.text_size + "px",
            "font-family" : pm.text_face,
            "z-index" : pm.text_zindex,
            "text" : ""
        };

        if(pm.text_edge != ""){
            var edge_color = $.convertColor(pm.text_edge);
            font_new_style["text-shadow"] = "1px 1px 0 "+edge_color+", -1px 1px 0 "+edge_color+",1px -1px 0 "+edge_color+",-1px -1px 0 "+edge_color+"";
        }else if(pm.text_shadow != ""){
            font_new_style["text-shadow"] = "2px 2px 2px " + $.convertColor(pm.text_shadow);
        }

        var text_value = pm.text_value instanceof Array? pm.text_value[0] : pm.text_value;

        var j_text = $("<p></p>").css({
            "position": "absolute",
            "top": pm.text_top + "px",
            "left": pm.text_left + "px",
            "width": pm.text_width,
            "textAlign": pm.text_align,
        });
        if (pm.text_vertical == "true") j_text.addClass("vertical_text");
        $.setName(j_text, "pmask_text");
        j_text.html(text_value);
        this.kag.setStyles(j_text, font_new_style);

        $('#tyrano_base').append(j_pmask);
        $('.layer_pmask').append(j_mask).append(j_text);

        var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        j_pmask.addClass('animated ' + pm.effect).one(animationEnd, function(){
            var first = true;
            if (pm.text_value instanceof Array && pm.auto_change == 'true') {
                that.kag.tmp.pmask.interval = 'on';
                that.kag.tmp.pmask.interval_var = setInterval(function(){
                    var text = pm.auto_change_random == 'true'? Math.floor(Math.random() * pm.text_value.length) : pm.text_value[that.kag.tmp.pmask.index];
                    that.kag.tmp.pmask.changeText(text, pm.text_value);
                }, parseInt(pm.auto_change_interval));
            }
            that.kag.ftag.nextOrder();
        });
    }
};



tyrano.plugin.kag.tag.pmask_change_text = {
    pm: {
        text: "",
        left: 0,
        top: 0,
        color: "",
        size: "",
    },
    start: function(pm){
        if ($(".pmask_text").length > 0) {
            $(".pmask_text").html(pm.text);
            if (pm.left != 0) $(".pmask_text").css("left",parseInt(pm.left));
            if (pm.top != 0) $(".pmask_text").css("top",parseInt(pm.top));
            if (pm.color != "") $(".pmask_text").css("color",$.convertColor(pm.color));
            if (pm.size != "") $(".pmask_text").css("font-size",parseInt(pm.size));
        }
        this.kag.ftag.nextOrder();
    }
};



tyrano.plugin.kag.tag.pmask_off = {
    pm: {
        time : 1000,
        effect:"fadeOut"
    },
    start: function(pm) {
        var that = this;
        var j_div = $(".layer_pmask");
        if (j_div.get(0)) {
            var _effect = j_div.attr("data-effect");
            j_div.removeClass('animated '+_effect);
            j_div.css("animation-duration",parseInt(pm.time)+"ms");
            var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
            j_div.addClass('animated ' + pm.effect).one(animationEnd, function() {
                j_div.remove();
                that.kag.layer.showEventLayer();
                that.kag.tmp.pmask.stopInterval();
                that.kag.ftag.nextOrder();
            });
        }else{
            that.kag.layer.showEventLayer();
            that.kag.tmp.pmask.stopInterval();
            that.kag.ftag.nextOrder();
        }
    }
};




['pmask','pmask_change_text','pmask_off'].forEach(function(tag_name){
    tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
    tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
});
