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
        box_0: true,  // 数字4ケタ（チュートリアル）
        box_1: true,  // 箱並び替え（ヒント：あみだくじ）{ヒント用パネル}
        box_2: true,  // 爆弾の銅線カット（ヒント：）{爆弾・銅線・はさみ}
        box_3: true,  // 数字4ケタ（ヒント：箱破壊+ハンマー）{箱・ハンマー}
        box_4: true,  // てんびん（ヒント：なし）{てんびん}
        box_5: false  // 振り向きの順序（ヒント：矢印）{ヒント用パネル}
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
    sf.rooms = [5];

    let timer_minit = 1;
    sf.timer = timer_minit * 60e3;

    sf.stage_data = {};

}());
