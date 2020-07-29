(function(){

    const TG = TYRANO.kag;
    const f = TG.stat.f;
    const sf = TG.variable.sf;

    $(window).on('keydown.system', es => {
        if (es.keyCode == 27) TG.ftag.startTag('close',{ask:'false'});
    });

    sf.skip = {
        title: true,
        tutorial: true,
        box_0: true,
        box_1: false,
        box_2: false,
        box_3: true,
        box_4: true,
        box_5: true
    };

    sf.on_timer = false;
    sf.shuffle_array = false;

    sf.userenv = $.userenv();

    sf.object_data = {
        image: [],
        sprite: [],
        model: [],
        box: []
    };

    //sf.rooms = [1,2,3,4,5];
    sf.rooms = [1,2]

    let timer_minit = 1;
    sf.timer = timer_minit * 60e3;

    sf.stage_data = {};

}());
