function show_sky_box(storage,r,rot){
    const three = TYRANO.kag.tmp.three;
    const geometry = new THREE.SphereGeometry(r,32,32);
    const loader = new THREE.TextureLoader();
    const texture = loader.load(`./data/bgimage/${storage}`);
    const material = new THREE.MeshBasicMaterial({
        map: texture,
        side: THREE.BackSide
    });
    const sky_box = new THREE.Mesh(geometry, material);
    sky_box.rotation.x = rot.x;
    sky_box.rotation.y = rot.y;
    sky_box.rotation.z = rot.z;
    three.scene.add(sky_box);
    three.models.sky_box = sky_box;
}
