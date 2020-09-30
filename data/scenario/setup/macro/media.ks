[macro name="pbgm"]
    [eval exp="mp.storage = getMediaFile('bgm', mp.name)"]
    [playbgm *]
[endmacro]

[macro name="fbgm"]
    [eval exp="mp.storage = getMediaFile('bgm', mp.name)"]
    [fadeinbgm *]
[endmacro]

[macro name="pse"]
    [eval exp="mp.storage = getMediaFile('se', !mp.name?'click':mp.name)"]
    [playse *]
[endmacro]

[return]
