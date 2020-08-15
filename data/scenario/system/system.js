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
            shuffle_array: false,
            timer: 4 * 60e3,
            badge_system: true
        },

        skip: {
            title: true,
            tutorial: true,
            box_0: true,  // 数字4ケタ（チュートリアル）=>完成
            box_1: true,  // 箱並び替え（ヒント：パネル）{2D：ヒント用パネル}=>完成
            box_2: true,  // 爆弾の銅線カット（ヒント：）{3D：爆弾・銅線・はさみ}{2D：はさみ}
            box_3: true,  // 数字4ケタ（ヒント：箱破壊+ハンマー）{箱・ハンマー}{2D：ハンマー}
            box_4: true,  // てんびん（ヒント：なし）=>完成
            box_5: true  // 振り向きの順序（ヒント：矢印）=>完成
        },

        rooms: [1,4,5]

    };

    // 実装予定
    $.setPlayerData = () => {
        return {
            fast_time: null,
            clear_box: new Set(),
            badge: {
                clear_first: false,
                a_min: false,
                two_min: false,
                three_min: false,
                clear_all_box: false
            }
        };
    }
    if (!sf.player_data) sf.player_data = $.setPlayerData();

    sf.object_data = {
        image: [],
        sprite: [],
        model: [],
        box: []
    };

    sf.stage_data = {};




    if (!sf.system.var.debug) {
        const system = sf.system;
        system.var.reset_var = false;
        system.var.on_timer = true;
        system.var.shuffle_array = true;
        for (let key in system.skip) system.skip[key] = false;
    }




    if (sf.system.var.reset_var) {
        const tmp = {
            title: sf.title,
            system: sf.system,
            object_data: sf.object_data,
            stage_data: sf.stage_data,
        };
        TG.stat.f = {};
        TG.variable.sf = {};
        TG.variable.sf.title = tmp.title;
        TG.variable.sf.system = tmp.system;
        TG.variable.sf.object_data = tmp.object_data;
        TG.variable.sf.stage_data = tmp.stage_data;
        TG.variable.sf.player_data = $.setPlayerData();
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
            case 46:
                if (sf.in_the_title) {
                    TYRANO.kag.ftag.startTag('jump',{
                        storage: 'title.ks',
                        target: 'delete'
                    });
                }
        }
    });

    $.ctrlTimer = num => {
        if (tyrano.plugin.kag.variable.sf.system.var.debug) {
            let tmp = tyrano.plugin.kag.variable.sf.system.var.timer;
            tyrano.plugin.kag.variable.sf.system.var.timer = parseInt(num) * 60e3;
            console.log(`before: ${tmp / 60e3} [min], to: ${tyrano.plugin.kag.variable.sf.system.var.timer / 60e3} [min]`);
            return 0;
        } else {
            return 'not debug mode.'
        }
    };

    $.setDebugCtrlTimer = () => {
        if (sf.system.var.debug) {
            const j_time_text = $(`<p id="timer_debug_text" class="fixlayer,timer_debug">time: ${sf.system.var.timer / 60e3}</p>`).css({
                position: 'absolute',
                left: 25,
                top: 110,
                fontSize: 50,
                zIndex: 999999999999
            });
            const j_button_up = $(`<img id="timer_debug_up" class="fixlayer,timer_debug" src="./data/image/up.png" />`).css({
                position: 'absolute',
                left: 25,
                top: 0,
                width: 100,
                height: 100,
                zIndex: 999999999999
            }).on('click', () => {
                let to = (sf.system.var.timer / 60e3) + 1;
                $.ctrlTimer(to);
                $('#timer_debug_text').text(`time: ${sf.system.var.timer / 60e3}`);
            });
            const j_button_down = $(`<img id="timer_debug_down" class="fixlayer,timer_debug" src="./data/image/down.png" />`).css({
                position: 'absolute',
                left: 25,
                top: 200,
                width: 100,
                height: 100,
                zIndex: 999999999999
            }).on('click', () => {
                let to = (sf.system.var.timer / 60e3) - 1;
                if (to <= 1) to = 1;
                $.ctrlTimer(to);
                $('#timer_debug_text').text(`time: ${sf.system.var.timer / 60e3}`);
            });
            $('#tyrano_base').append(j_time_text);
            $('#tyrano_base').append(j_button_up);
            $('#tyrano_base').append(j_button_down);
        }
    }
    $.clearDebugCtrlTimer = () => {
        if (sf.system.var.debug) {
            $('#timer_debug_up').off().remove();
            $('#timer_debug_down').off().remove();
            $('#timer_debug_text').remove();
        }
    }

}());
