[iscript]
sf.title = 'Escape Box';
[endscript]
[title name="&sf.title"]

[stop_keyconfig]
[hidemenubutton]
[layopt layer="message0" visible="false"]
[layopt layer="message1" visible="false"]
[layopt layer="0" visible="true"]
[layopt layer="1" visible="true"]
[layopt layer="2" visible="false"]
[layopt layer="fix" visible="true"]

@loadjs storage="js/init.js"
@loadjs storage="../scenario/system/system.js"
@loadjs storage="../scenario/system/function.js"
@loadjs storage="../scenario/system/classies.js"

@plugin name="for"
@plugin name="switch"
@plugin name="loadcsv"
@plugin name="circle_timer"

@call storage="setup/loadcsv.ks"
@call storage="setup/macro/macro_main.ks"

@jump storage="title.ks"
*return_title

@jump storage="main.ks"










; テスト用
[iscript]
$(window).on('keydown',ec => {
    switch (ec.keyCode) {
        case 65:  // a
            TYRANO.kag.tmp.three.camera.position.x -= 10;
            break;
        case 68:  // d
            TYRANO.kag.tmp.three.camera.position.x += 10;
            break;
        case 87:  // w
            TYRANO.kag.tmp.three.camera.position.z -= 10;
            break;
        case 83:  // s
            TYRANO.kag.tmp.three.camera.position.z += 10;
            break;
        case 81:  // q
            TYRANO.kag.tmp.three.camera.position.y += 10;
            break;
        case 69:  // e
            TYRANO.kag.tmp.three.camera.position.y -= 10;
            break;
    }
});
[endscript]
