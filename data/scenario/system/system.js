(function(){

    const TG = TYRANO.kag;
    const f = TG.stat.f;
    const sf = TG.variable.sf;



    sf.system = {

        var: {
            debug: false,
            reset_var: true,
            userenv: $.userenv(),
            browser: $.getBrowser(),
            on_timer: true,
            shuffle_array: true,
            timer: 1 * 60e3
        },

        skip: {
            title: false,
            tutorial: true,
            box_0: false,  // 数字4ケタ（チュートリアル）
            box_1: false,  // 箱並び替え（ヒント：あみだくじ）{2D：ヒント用パネル}
            box_2: false,  // 爆弾の銅線カット（ヒント：）{3：爆弾・銅線・はさみ}{2D：はさみ}
            box_3: false,  // 数字4ケタ（ヒント：箱破壊+ハンマー）{箱・ハンマー}{2D：ハンマー}
            box_4: false,  // てんびん（ヒント：なし）{てんびん}
            box_5: false  // 振り向きの順序（ヒント：矢印）{ヒント用パネル}
        },

        rooms: [1,5]

    };

    sf.object_data = {
        image: [],
        sprite: [],
        model: [],
        box: []
    };

    sf.stage_data = {};




    if (sf.system.var.reset_var) {
        const tmp = [
            sf.system,
            sf.object_data,
            sf.stage_data
        ];
        TG.stat.f = {};
        TG.variable.sf = {};
        TG.variable.sf.system = tmp[0];
        TG.variable.sf.object_data = tmp[1];
        TG.variable.sf.stage_data = tmp[2];
    }

    $.log = val => {
        if (sf.system.var.debug) console.log(val);
    }

    $(window).on('keydown', system => {
        switch (system.keyCode) {
            case 27:
                if (sf.system.var.debug) TG.ftag.startTag('close',{ask:'false'});
                break;
            case 122:
                if (sf.system.var.browser == 'unknown' || sf.system.var.debug) TG.ftag.startTag('screen_full');
                break;
        }
    });

}());
