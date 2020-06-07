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
    //console.log(rotation)
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
    for (pos in tf.rotation) tf.rotation[pos] = Math.floor(180*tf.rotation[pos]/Math.PI/10)*10;
    tf.size = 150;
    tf.dif = 20;
    tf.pos = { x:$('#tyrano_base').width()-tf.size-tf.dif, y:getCenter('y',tf.size) };
    [endscript]
    [button target="control_camera" exp="f.to_direction='right'" graphic="right.png" x="&tf.pos.x" y="&tf.pos.y" width="150" height="150" cond="tf.rotation.x < 90 && tf.rotation.x > -90"]
    [button target="control_camera" exp="f.to_direction='left'" graphic="left.png" x="&tf.dif" y="&tf.pos.y" width="150" height="150" cond="tf.rotation.x < 90 && tf.rotation.x > -90"]
    [iscript]
    tf.pos = { x:getCenter('x',tf.size), y:$('#tyrano_base').height()-tf.size-tf.dif };
    [endscript]
    [button target="control_camera" exp="f.to_direction='up'" graphic="up.png" x="&tf.pos.x" y="&tf.dif" width="150" height="150" cond="tf.rotation.x < 90"]
    [button target="control_camera" exp="f.to_direction='down'" graphic="down.png" x="&tf.pos.x" y="&tf.pos.y" width="150" height="150" cond="tf.rotation.x > -90"]
[endmacro]

[return]
