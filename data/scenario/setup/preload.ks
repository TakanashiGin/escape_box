[cm][clearstack]

[loadjs storage="../scenario/setup/preload.js"]
[layopt layer="0" visible="true"]
[iscript]
f.poreload_text = `Loading ${0}%…`;
[endscript]
[ptext name="preload_text" layer="0" text="&f.poreload_text" x="0" y="330" width="1280" align="center" color="white" size="50"]

[for name="tf.i" from="1" len="&sf.preload.length" deep="1"]
    [preload storage="&sf.preload[tf.i]"]
    [iscript]
    $('.preload_text').text(`Loading ${parseInt((tf.i / sf.preload.length) * 100) + 1}%…`);
    [endscript]
    [breakfor cond="tf.i >= sf.preload.length - 1"]
[nextfor]

[wait time="500"]
[free name="preload_text" layer="0" time="500"]

[jump storage="first.ks" target="return_preload"]



/*
C:\Users\Kai Suzuki\Google ドライブ\tyrano\Tyranoscript_files\escape_box\escape_box>dir /s /b *.jpg *.png
*/
