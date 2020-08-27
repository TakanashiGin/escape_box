(function(){





    const TG = tyrano.plugin.kag;





    TG.variable.sf.bgm = {

        mode: 'm4a',

        file: [
            'main',
            'game1',
            'game2',
            'game3',
        ],

        storage: {}

    };





    TG.variable.sf.se = {

        mode: 'm4a',

        file: [
            'click',
            'correct',
            'incorrect',
            'walk',
            'push_button',
            'put_block',
            'explosion',
            'take_item',
            'break_box',
            'fall_box',
            'cut'
        ],

        storage: {}

    };





    if ($.getBrowser() == 'unknown') {
        TG.variable.sf.bgm.mode = 'ogg';
        TG.variable.sf.se.mode = 'ogg';
    }





    ['bgm','se'].forEach(sound => {
        TG.variable.sf[sound].file.forEach(file => {
            const s = TG.variable.sf[sound];
            s.storage[file] = `${s.mode}/${file}.${s.mode}`;
        });
    });
    $.log(TG.variable.sf.bgm);
    $.log(TG.variable.sf.se);






}());
