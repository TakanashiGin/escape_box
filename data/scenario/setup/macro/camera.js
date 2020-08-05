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
    return [transverse,longitudinally];
}
