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
    //$.log(rotation);
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
    tf.get_orientation = getOrientation()[1];
    [endscript]
    [button name="right" target="control_camera" exp="f.to_direction='right'" graphic="right.png" x="&sf.button.right.x" y="&sf.button.right.y" width="&sf.button_size" height="&sf.button_size" fix="true" cond="tf.get_orientation == 'horizontal'" clickse="&sf.se.storage.click"]
    [button name="left"  target="control_camera" exp="f.to_direction='left'"  graphic="left.png"  x="&sf.button.left.x"  y="&sf.button.left.y"  width="&sf.button_size" height="&sf.button_size" fix="true" cond="tf.get_orientation == 'horizontal'" clickse="&sf.se.storage.click"]
    [button name="up"    target="control_camera" exp="f.to_direction='up'"    graphic="up.png"    x="&sf.button.top.x"   y="&sf.button.top.y"   width="&sf.button_size" height="&sf.button_size" fix="true" cond="tf.get_orientation != 'up'" clickse="&sf.se.storage.click"]
    [button name="down"  target="control_camera" exp="f.to_direction='down'"  graphic="down.png"  x="&sf.button.down.x"  y="&sf.button.down.y"  width="&sf.button_size" height="&sf.button_size" fix="true" cond="tf.get_orientation != 'down'" clickse="&sf.se.storage.click"]
    [cbk all="true"]
[endmacro]

[macro name="to_front"]
    [eval exp="tf.loop = true"]
*nextwhile
    [iscript]
    const orientation = getOrientation();
    if (orientation[1] == 'up') {
        f.to_direction = 'down';
    } else if (orientation[1] == 'down') {
        f.to_direction = 'up';
    } else {
        switch (orientation[0]) {
            case 'right': f.to_direction = 'left'; break;
            case 'left': f.to_direction = 'right'; break;
            case 'back': f.to_direction = 'right'; break;
            default: tf.loop = false; break;
        }
    }
    [endscript]
    [direction_manager cond="tf.loop"]
    [wait time="500" cond="tf.loop"]
    [jump storage="setup/macro/camera.ks" target="nextwhile" cond="tf.loop"]
    [eval exp="tf.loop = null"]
[endmacro]

[macro name="clear_button"]
    [clearfix]
    [eval exp="$(window).off('keydown')"]
[endmacro]

[macro name="cbk"]
    [iscript]
    mp.obj = !!mp.storage || !!mp.target? {storage:mp.storage,target:mp.target} : null;
    if (mp.all == 'true') ['right','left','up','down'].forEach(dir => controlCameraByKey.setEvent(dir));
    else controlCameraByKey.setEvent(mp.dir, mp.obj, mp.exp, mp.view);
    [endscript]
[endmacro]

[return]
