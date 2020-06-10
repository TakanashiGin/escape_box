function getOrientation(log){
    const TG = TYRANO.kag;
    const camera = TG.tmp.three.camera;
    let deg = {
        x: getMeasuringDegrees(camera.rotation.x) % 360,
        y: getMeasuringDegrees(camera.rotation.y) % 360,
        z: getMeasuringDegrees(camera.rotation.z) % 360
    };
    let deg_abs = {};
    for (let key in deg) deg_abs[key] = Math.abs(deg[key]);
    let transverse = (function(){
        if (deg_abs.y == 0) return 'front';
        else if (deg_abs.y == 180) return 'back';
        else if (deg.y == 90 || deg.y == -270) return 'right';
        else return 'left';
    }());
    let longitudinally = (function(){
        if (deg.x > 0) return 'up';
        else if (deg.x < 0) return 'down';
        else return 'horizontal';
    }());
    if (log) {
        console.log(deg);
        console.log(deg_abs);
        console.log([transverse,longitudinally]);
    }
    return [transverse,longitudinally];
}
