[macro name="load_stage_objects"]
    [iscript]
        StageObjectManager.loadStageObjects(mp.stage);
    [endscript]
[endmacro]

[macro name="delete_stage_objects"]
    [iscript]
        const d = !!mp.delete? false : true;
        StageObjectManager.deleteStageObjects(mp.stage, d);
    [endscript]
[endmacro]

[macro name="mod_sprite"]
    [eval exp="tf.akane_face = mp.name"]
    [3d_hide name="&mp.hide_name" time="&mp.time" wait="false"]
    [3d_show name="&mp.name" time="&mp.time" wait="&mp.wait" pos="&mp.pos" rot="&mp.rot" scale="&mp.scale"]
[endmacro]

[loadjs storage="../scenario/setup/macro/show_panoramic_image.js"]
[macro name="show_panoramic_image"]
    [iscript]
    let pos = mp.pos || "0,0,0";
    let rot = mp.rot || "0,0,0";
    let tmp = [
        mp.name || 'panoramic_image',
        mp.storage,
        mp.rad || 100,
        pos.split(',').map(Number),
        rot.split(',').map(Number)
    ];
    showPanoramicImage(...tmp);
    [endscript]
[endmacro]
[macro name="remove_panoramic_image"]
    [iscript]
    removePanoramicImage(mp.name);
    [endscript]
[endmacro]

[return]
