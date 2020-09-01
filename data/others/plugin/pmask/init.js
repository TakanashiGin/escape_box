tyrano.plugin.kag.stat.pmask = {
    interval: 'off',
    interval_var: null,
    index: 1,
    changeText: function(text="", array="none", left="none", top="none", color="none", size="none"){
        if (!!array && array != "none") {
            this.index++;
            if (array.length <= this.index) this.index = 0;
        }
        if ($(".pmask_text").length > 0) {
            $(".pmask_text").html(text);
            if (left != "none") $(".pmask_text").css("left",parseInt(left));
            if (top != "none") $(".pmask_text").css("top",parseInt(top));
            if (color != "none") $(".pmask_text").css("color",$.convertColor(color));
            if (size != "none") $(".pmask_text").css("font-size",parseInt(size));
        } else {
            return false;
        }
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
        mask_time: 1000,
        mask_effect:"fadeIn",
        mask_color:"0x000000",
        mask_graphic:"",
        mask_folder:"",

        left: 0,
        top: 0,
        vertical: "false",
        text: "",
        size: "",
        face: "",
        color: "",
        bold: "",
        align: "left",
        edge: "",
        shadow: "",
        width:"",

        auto_change: "false",
        auto_change_interval: 10000,
        auto_change_random: 'true',
    },

    start: function(pm) {

        var that = this;
        that.kag.layer.hideEventLayer();

        var sc_width = parseInt(that.kag.config.scWidth);
        var sc_height = parseInt(that.kag.config.scHeight);

        var j_pmask = $("<div class='layer layer_pmask' data-effect='" + pm.mask_effect + "' style='z-index:100000000;position:absolute;'>").css({
            "animation-duration": parseInt(pm.mask_time)+"ms",
            "width": sc_width,
            "height": sc_height
        });

        var j_mask = $("<div class='layer layer_mask' style='z-index:0;position:absolute;'>").css({
            "width": sc_width,
            "height": sc_height
        });

        if (pm.mask_color == "none") j_mask.css("background-color","");
        else j_mask.css("background-color", $.convertColor(pm.mask_color));

        if(pm.mask_graphic != ""){
            var folder = pm.mask_foler != ""? pm.mask_folder : "image";
            var storage_url = "";
            if(pm.mask_graphic != ""){
                storage_url = "./data/" + folder + "/" + pm.mask_graphic;
                j_pmask.css("background-image","url(" + storage_url + ")");
            }
        }

        var text = typeof pm.text == 'object'? typeof pm.text[0] == 'string'? pm.text[0] : pm.text[0].text : pm.text;
        if (typeof pm.text == 'object' && !pm.text instanceof Array) {
            for (param in pm.text[0]) {
                if (param != 'text' && !!pm.text[0][param]) pm[param] = pm.text[0][param];
            }
        }

        if (pm.face == "") pm.face = that.kag.stat.font.face;

        if (pm.color == "") pm.color = $.convertColor(that.kag.stat.font.color);
        else pm.color = $.convertColor(pm.color);

        var font_new_style = {
            "color" : pm.color,
            "font-weight" : pm.bold,
            "font-style" : pm.style,
            "font-size" : pm.size + "px",
            "font-family" : pm.face,
            "z-index" : pm.zindex,
            "text" : ""
        };

        if(pm.edge != ""){
            var color = $.convertColor(pm.edge);
            font_new_style["text-shadow"] = "1px 1px 0 "+color+", -1px 1px 0 "+color+",1px -1px 0 "+color+",-1px -1px 0 "+color+"";
        }else if(pm.shadow != ""){
            font_new_style["text-shadow"] = "2px 2px 2px " + $.convertColor(pm.shadow);
        }

        var j_text = $("<p></p>").css({
            "position": "absolute",
            "top": pm.top + "px",
            "left": pm.left + "px",
            "width": pm.width,
            "textAlign": pm.align,
        });
        if (pm.vertical == "true") j_text.addClass("vertical_text");
        $.setName(j_text, "pmask_text");
        j_text.html(text);
        that.kag.setStyles(j_text, font_new_style);

        $('#tyrano_base').append(j_pmask);
        $('.layer_pmask').append(j_mask).append(j_text);

        var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        j_pmask.addClass('animated ' + pm.mask_effect).one(animationEnd, function(){
            if (typeof pm.text == 'object' && pm.auto_change == 'true') {
                that.kag.stat.pmask.interval = 'on';
                that.kag.stat.pmask.interval_var = setInterval(function(){
                    var value = pm.auto_change_random == 'true'? Math.floor(Math.random() * pm.text.length) : pm.text[that.kag.stat.pmask.index];
                    if (typeof value == 'string') that.kag.stat.pmask.changeText(value, pm.text);
                    else if (typeof value == 'object') that.kag.stat.pmask.changeText(value.text, pm.text, value.left, value.top, value.color, value.size);
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
        this.kag.stat.pmask.changeText(pm.text, 'none', pm.left, pm.top, pm.color, pm.size);
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
                that.kag.stat.pmask.stopInterval();
                that.kag.ftag.nextOrder();
            });
        }else{
            that.kag.layer.showEventLayer();
            that.kag.stat.pmask.stopInterval();
            that.kag.ftag.nextOrder();
        }
    }
};




['pmask','pmask_change_text','pmask_off'].forEach(function(tag_name){
    tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
    tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
});
