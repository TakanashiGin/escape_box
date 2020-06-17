const showPanoramicImage = (name,storage,rad,pos,rot) => {
    let three = TYRANO.kag.tmp.three;
    if (!name) name = 'panoramic_image';
    if (!rad) rad = 100;
    if (!pos) pos = [0,0,0];
    if (!rot) rot = [0,0,0];
    const loader = new THREE.TextureLoader();
    const texture = loader.load(`./data/bgimage/${storage}`);
    const panoramic_image = new THREE.Mesh(
        new THREE.SphereGeometry(rad,32,32),
        new THREE.MeshBasicMaterial({
            map: texture,
            side: THREE.BackSide
        })
    );
    panoramic_image.position.set(...pos);
    panoramic_image.rotation.set(...rot);
    three.scene.add(panoramic_image);
    three.models[name] = panoramic_image;
}

const removePanoramicImage = name => {
    let three = TYRANO.kag.tmp.three;
    if (!name) name = 'panoramic_image';
    if (three.models[name]) {
        three.scene.remove(three.models[name]);
        delete three.models[name];
    } else {
        console.error(`[ERROR] ${name} is not defined.`);
    }
}
