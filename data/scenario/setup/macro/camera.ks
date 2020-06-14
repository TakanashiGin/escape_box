[loadjs storage="../scenario/setup/macro/camera.js"]

[macro name="direction_manager"]
    #
    [iscript]
    let camera = tyrano.plugin.kag.tmp.three.camera;
    let rotation = {
        x: camera.rotation.x,
        y: camera.rotation.y,
        z: camera.rotation.z
    };
    for (pos in rotation) rotation[pos] = getMeasuringDegrees(rotation[pos]);
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
    [3d_anim name="camera" rot="&getRotate(...tf.rot)" time="500"]
[endmacro]

[macro name="camera_button"]
    [iscript]
    sf.button_size = 125;
    let dif = 20;
    let sx = 840 + 20;
    sf.button = {
        right: {
            x: 1280 - sf.button_size - dif,
            y: 400 + ((300-sf.button_size)/2) + dif/2
        },
        left: {
            x: sx + dif,
            y: 400 + ((300-sf.button_size)/2) + dif/2
        },
        top: {
            x: sx + dif + ((1280-sx-(dif*2)-sf.button_size)/2),
            y: 400 + dif
        },
        down: {
            x: sx + dif + ((1280-sx-(dif*2)-sf.button_size)/2),
            y: 720 - sf.button_size - dif
        }
    }
    for (let key in sf.button) sf.button[key]['y'] -= dif/2;
    [endscript]
    [button name="right" target="control_camera" exp="f.to_direction='right'" graphic="right.png" x="&sf.button.right.x" y="&sf.button.right.y" width="&sf.button_size" height="&sf.button_size" fix="true" cond="getOrientation()[1] == 'horizontal'"]
    [button name="left"  target="control_camera" exp="f.to_direction='left'"  graphic="left.png"  x="&sf.button.left.x"  y="&sf.button.left.y"  width="&sf.button_size" height="&sf.button_size" fix="true" cond="getOrientation()[1] == 'horizontal'"]
    [button name="up"    target="control_camera" exp="f.to_direction='up'"    graphic="up.png"    x="&sf.button.top.x"   y="&sf.button.top.y"   width="&sf.button_size" height="&sf.button_size" fix="true" cond="getOrientation()[1] != 'up'"]
    [button name="down"  target="control_camera" exp="f.to_direction='down'"  graphic="down.png"  x="&sf.button.down.x"  y="&sf.button.down.y"  width="&sf.button_size" height="&sf.button_size" fix="true" cond="getOrientation()[1] != 'down'"]
[endmacro]

[return]
