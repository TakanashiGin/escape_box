(function(){

    const sf = TYRANO.kag.variable.sf;

    sf.media_files = {
        bgm: [
            'main',
            'game1',
            'game2',
            'game3',
        ],
        se: [
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
        ]
    };

    sf.bgm = {};
    sf.se = {};
    for (let type in sf.media_files) {
        sf.media_files[type].forEach(name => sf[type][name] = getMediaFile(type, name));
    }
    $.log(sf.bgm);
    $.log(sf.se);

}());
