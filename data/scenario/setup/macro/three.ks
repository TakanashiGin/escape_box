[macro name="load_stage_objects"]
    [iscript]
        StageObjectManager.loadStageObjects(mp.stage);
    [endscript]
[endmacro]

[macro name="delete_stage_objects"]
    [iscript]
        StageObjectManager.deleteStageObjects(mp.stage);
    [endscript]
[endmacro]

[macro name="mod_sprite"]
    [3d_hide name="&mp.hide_name" time="&mp.time" wait="false"]
    [3d_show *]
[endmacro]

[loadjs storage="../scenario/setup/macro/show_sky_box.js"]
[macro name="show_sky_box"]
    [iscript]
    show_sky_box(mp.storage,parseInt(mp.r),$.three_pos(mp.rot));
    [endscript]
[endmacro]

[return]
