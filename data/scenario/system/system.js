(function(){

    const TG = TYRANO.kag;
    const f = TG.stat.f;
    const sf = TG.variable.sf;

    $(window).on('keydown.system',(es) => {
        if (es.keyCode == 27) TG.ftag.startTag('close',{ask:'false'});
    });

    sf.skip = {
        tutorial: true,
        box_0: true,
        box_1: true
    };

    sf.userenv = $.userenv();

    sf.object_data = {
        image: [],
        sprite: [],
        model: [],
        box: []
    }

    let timer_minit = 1;
    sf.timer = timer_minit * 60 * 1000;

    sf.stage_data = {};

    let tag_name = 'dummy'
    tyrano.plugin.kag.tag[tag_name] = {start:function(pm){console.log(tag_name)}};
    tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
    tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;

}());
