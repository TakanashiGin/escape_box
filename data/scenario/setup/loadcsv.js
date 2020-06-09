(function(){

    const TG = TYRANO.kag;
    const f = TG.stat.f;
    const sf = TG.variable.sf;
    const tf = TG.variable.tf;

    let csv_data = {
        image: tf.three_images,
        sprite: tf.three_sprites,
        model: tf.three_models,
        box: tf.three_boxies
    };

    for (let cate in csv_data) {
        let three_data = csv_data[cate];
        three_data = three_data.map(ver => {
            return ver.map((side,i) => {
                if (typeof side === 'string' && side.indexOf('-') !== -1) {
                    return side.split('-').join(',');
                } else if (side == 'none') {
                    let index = three_data[0];
                    switch (cate) {
                        case 'image':
                            if (index[i] == 'width' || index[i] == 'height' || index[i] == 'scale') return '1';
                            else if (index[i] == 'pos' || index[i] == 'rot') return '0';
                            else if (index[i] == 'color') return "0x00ff00";
                            else return "";
                            break;
                        case 'sprite':
                            if (index[i] == 'pos' || index[i] == 'rot') return '0';
                            else return "";
                            break;
                        case 'model':
                            if (index[i] == 'pos' || index[i] == 'rot') return '0';
                            else if (index[i] == 'scale') return '100';
                            else return "";
                            break;
                        case 'box':
                            if (index[i] == 'pos' || index[i] == 'rot') return '0';
                            else if (index[i] == 'width' || index[i] == 'height' || index[i] == 'depth' || index[i] == 'scale') return '1';
                            else if (index[i] == 'color') return '0x00ff00';
                            else return "";
                            break;
                    }
                } else {
                    return side;
                }
            });
        });
        for (let i=1; i<three_data.length; i++) {
            let val = three_data[i];
            switch (cate) {
                case 'image':
                    var new_object = new TyranoThreeImage(...val);
                    break;
                case 'sprite':
                    var new_object = new TyranoThreeSprite(...val);
                    break;
                case 'model':
                    var new_object = new TyranoThreeModel(...val);
                    break;
                case 'box':
                    var new_object = new TyranoThreeBox(...val);
                    break;
            }
            sf.object_data[cate].push(new_object);
        }
    }

    let pushObject = (data,data_key,num) => {
        if (!num) num = data.stage;
        let stage = (!Number.isNaN(parseInt(num)))? `box_${num}` : data.stage;
        if (!sf.stage_data[stage]) sf.stage_data[stage] = {};
        if (!sf.stage_data[stage]['objects']) sf.stage_data[stage]['objects'] = {};
        if (!sf.stage_data[stage]['objects'][data_key]) sf.stage_data[stage]['objects'][data_key] = [];
        let tmp = {};
        Object.keys(data).forEach(k => {
            if (k != 'stage') tmp[k] = data[k];
        });
        sf.stage_data[stage]['objects'][data_key].push(tmp);
    }
    Object.keys(sf.object_data).forEach(data_key => {
        sf.object_data[data_key].forEach(data => {
            if (typeof data.stage == 'string' && data.stage.indexOf(',') >= 1) {
                let stages = data.stage.split(',');
                stages.forEach(num => pushObject(data,data_key,num));
            } else {
                pushObject(data,data_key);
            }
        });
    });

    console.log(sf.stage_data);

}());
