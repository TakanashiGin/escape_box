(function(){


    const TG = TYRANO.kag;
    const f = TG.stat.f;
    const sf = TG.variable.sf;
    const tf = TG.variable.tf;


    // image
    tf.three_images = tf.three_images.map(ver => {
        return ver.map((side,i) => {
            if (typeof side == 'string' && side.indexOf('-') >= 1) {
                return side.split('-').join(',');
            } else if (side == 'none') {
                let index = tf.three_images[0];
                if (index[i] == 'width' || index[i] == 'height' || index[i] == 'scale') return '1';
                else if (index[i] == 'pos' || index[i] == 'rot') return '0';
                else if (index[i] == 'color') return "0x00ff00";
                else return "";
            } else {
                return side;
            }
        });
    });
    tf.three_images.forEach((val,i) => {
        if (i > 0) sf.object_data.image.push(new TyranoThreeImage(...val));
    });


    // sprite
    tf.three_sprites = tf.three_sprites.map(ver => {
        return ver.map((side,i) => {
            if (typeof side == 'string' && side.indexOf('-') >= 1) {
                return side.split('-').join(',');
            } else if (side == 'none') {
                let index = tf.three_sprites[0];
                if (index[i] == 'pos' || index[i] == 'rot') return '0';
                else return "";
            } else {
                return side;
            }
        });
    });
    tf.three_sprites.forEach((val,i) => {
        if (i > 0) sf.object_data.sprite.push(new TyranoThreeSprite(...val));
    });


    // model
    tf.three_models = tf.three_models.map(ver => {
        return ver.map((side, i) => {
            if (typeof side == 'string' && side.indexOf('-') >= 1) {
                return side.split('-').join(',');
            } else if (side == 'none') {
                let index = tf.three_models[0];
                if (index[i] == 'pos' || index[i] == 'rot') return '0';
                else if (index[i] == 'scale') return '100';
                else return "";
            } else {
                return side;
            }
        });
    });
    tf.three_models.forEach((val,i) => {
        if (i > 0) sf.object_data.model.push(new TyranoThreeModel(...val));
    });


    // box
    tf.three_boxies = tf.three_boxies.map(ver => {
        return ver.map((side, i) => {
            if (typeof side == 'string' && side.indexOf('-') >= 1) {
                return side.split('-').join(',');
            } else if (side == 'none') {
                let index = tf.three_boxies[0];
                if (index[i] == 'pos' || index[i] == 'rot') return '0';
                else if (index[i] == 'width' || index[i] == 'height' || index[i] == 'depth' || index[i] == 'scale') return '1';
                else if (index[i] == 'color') return '0x00ff00';
                else return "";
            } else {
                return side;
            }
        });
    });
    tf.three_boxies.forEach((val, i) => {
        if (i > 0) sf.object_data.box.push(new TyranoThreeBox(...val));
    });



    let pushObject = (data,data_key,num) => {
        if (!num) num = data.stage;
        let stage = (!Number.isNaN(parseInt(num)))? `box_${num}` : data.stage;
        if (!sf.stage_data[stage]) sf.stage_data[stage] = {};
        if (!sf.stage_data[stage]['objects']) sf.stage_data[stage]['objects'] = {};
        if (!sf.stage_data[stage]['objects'][data_key]) sf.stage_data[stage]['objects'][data_key] = [];
        let tmp = {};
        Object.keys(data).forEach(k => {
            if (k != 'stage') {
                tmp[k] = data[k];
            };
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
