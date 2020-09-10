function getOrientation(log){
    const TG = TYRANO.kag;
    const camera = TG.tmp.three.camera;
    const getFigure = (a,b) => {
        if (b > 0) return a;
        else return a * (-1);
    }
    let deg = {
        x: getMeasuringDegrees(camera.rotation.x) % 360,
        y: getMeasuringDegrees(camera.rotation.y) % 360,
        z: getMeasuringDegrees(camera.rotation.z) % 360
    };
    let deg_abs = {};
    for (let key in deg) {
        let d = deg[key];
        let d_abs = Math.abs(d);
        for (let i=0; i<360; i+=45) {
            if (d_abs > i && d_abs < i+45) {
                if (i == 0 || i+45 == 360) {
                    d = 0;
                } else {
                    if (i % 2 == 0) d = getFigure(i+45,d);
                    else d = getFigure(i,d);
                }
                break;
            }
        }
        deg[key] = d;
        deg_abs[key] = Math.abs(d);
    }
    let transverse = (function(){
        if (deg_abs.y == 0) return 'front';
        else if (deg_abs.y == 180) return 'back';
        else if (deg.y == 90 || deg.y == -270) return 'left';
        else return 'right';
    }());
    let longitudinally = (function(){
        if (deg.x > 0) return 'up';
        else if (deg.x < 0) return 'down';
        else return 'horizontal';
    }());
    if (log) {
        $.log(deg);
        $.log(deg_abs);
        $.log([transverse,longitudinally]);
    }
    tyrano.plugin.kag.variable.tf.orientation = [transverse,longitudinally];
    return [transverse,longitudinally];
}

var controlCameraByKey = {
    setEvent: function(dir, obj, exp, ori){
        if ($.userenv() == 'pc') {
            const that = this;
            const orientation = !!ori? ori : getOrientation()[1];
            const storage = !!obj && !!obj.storage? obj.storage : 'main.ks';
            const target = !!obj && !!obj.target? obj.target : 'control_camera';
            switch (dir) {
                case 'right':
                    $(window).on('keydown.camera_right', e_right => {
                        const key_code = e_right.keyCode;
                        if (orientation == 'horizontal' && (key_code == 39 || key_code == 68)) that.jumpCtrlCamera('right', storage, target, exp);
                    });
                    break;
                case 'left':
                    $(window).on('keydown.camera_left', e_left => {
                        const key_code = e_left.keyCode;
                        if (orientation == 'horizontal' && (key_code == 37 || key_code == 65)) that.jumpCtrlCamera('left', storage, target, exp);
                    });
                    break;
                case 'up':
                    $(window).on('keydown.camera_up', e_up => {
                        const key_code = e_up.keyCode;
                        if (orientation != 'up' && (key_code == 38 || key_code == 87)) that.jumpCtrlCamera('up', storage, target, exp);
                    });
                case 'down':
                    $(window).on('keydown.camera_down', e_down => {
                        const key_code = e_down.keyCode;
                        if (orientation != 'down' && (key_code == 40 || key_code == 83)) that.jumpCtrlCamera('down', storage, target, exp);
                    });
            }
        }
    },
    jumpCtrlCamera: function(dir, storage, target, exp){
        $(window).off('keydown');
        const TG = tyrano.plugin.kag;
        TG.stat.f.to_direction = dir;
        if (!!exp) {
            const f = TG.stat.f;
            const tf = TG.variable.tf;
            const sf = TG.variable.sf;
            const mp = TG.stat.mp;
            eval(exp);
        }
        TG.ftag.startTag('jump', {storage, target});
    }
}
