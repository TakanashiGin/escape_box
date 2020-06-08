[macro name="direction_manager"]
    [iscript]
    let camera = tyrano.plugin.kag.tmp.three.camera;
    let rotation = {
        x: camera.rotation.x,
        y: camera.rotation.y,
        z: camera.rotation.z
    };
    for (pos in rotation) rotation[pos] = Math.floor(180*rotation[pos]/Math.PI/10)*10;
    switch (f.to_direction) {
        case 'right': rotation.y -= 90; break;
        case 'left': rotation.y += 90; break;
        case 'up': rotation.x += 90; break;
        case 'down': rotation.x -= 90; break;
    }
    //console.log(rotation);
    tf.rot = [];
    for (pos in rotation) tf.rot.push(rotation[pos]);
    [endscript]
    [3d_anim name="camera" rot="&getRotate(...tf.rot)"]
[endmacro]

[macro name="camera_button"]
    [iscript]
    let camera = tyrano.plugin.kag.tmp.three.camera;
    tf.rotation = {
        x: camera.rotation.x,
        y: camera.rotation.y,
        z: camera.rotation.z
    };
    for (let pos in tf.rotation) tf.rotation[pos] = Math.floor(180*tf.rotation[pos]/Math.PI/10)*10;
    tf.size = 125;
    let dif = 20;
    let sx = 840 + 20;
    tf.button = {
        right: {
            x: 1280 - tf.size - dif,
            y: 400 + ((300-tf.size)/2) + dif/2
        },
        left: {
            x: sx + dif,
            y: 400 + ((300-tf.size)/2) + dif/2
        },
        top: {
            x: sx + dif + ((1280-sx-(dif*2)-tf.size)/2),
            y: 400 + dif
        },
        down: {
            x: sx + dif + ((1280-sx-(dif*2)-tf.size)/2),
            y: 720 - tf.size - dif
        }
    }
    for (let key in tf.button) tf.button[key]['y'] -= dif/2;
    [endscript]
    [button name="right" target="control_camera" exp="f.to_direction='right'" graphic="right.png" x="&tf.button.right.x" y="&tf.button.right.y" width="&tf.size" height="&tf.size" fix="true" cond="tf.rotation.x < 90 && tf.rotation.x > -90"]
    [button name="left"  target="control_camera" exp="f.to_direction='left'"  graphic="left.png"  x="&tf.button.left.x"  y="&tf.button.left.y"  width="&tf.size" height="&tf.size" fix="true" cond="tf.rotation.x < 90 && tf.rotation.x > -90"]
    [button name="up"    target="control_camera" exp="f.to_direction='up'"    graphic="up.png"    x="&tf.button.top.x"   y="&tf.button.top.y"   width="&tf.size" height="&tf.size" fix="true" cond="tf.rotation.x < 90"]
    [button name="down"  target="control_camera" exp="f.to_direction='down'"  graphic="down.png"  x="&tf.button.down.x"  y="&tf.button.down.y"  width="&tf.size" height="&tf.size" fix="true" cond="tf.rotation.x > -90"]
[endmacro]

[return]
