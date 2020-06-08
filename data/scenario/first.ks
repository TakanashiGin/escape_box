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

@loadjs storage="../scenario/system/system.js"
@loadjs storage="../scenario/system/function.js"
@loadjs storage="../scenario/system/classies.js"

@plugin name="for"
@plugin name="switch"
@plugin name="loadcsv"
@plugin name="circle_timer"

@3d_init layer="0"
@3d_anim name="camera" pos="0,0,0" time="10"

@call storage="setup/tyrano.ks"
@call storage="setup/loadcsv.ks"
@call storage="setup/macro/macro_main.ks"

@jump storage="main.ks"










; テスト用
[iscript]
sf.orifunc = () => {};
tyrano.plugin.kag.tag["3d_init"] = {
    vital : [],
    pm : {
        layer:"0",
        page:"fore",
        camera:"Perspective",
        near:"1",
        far:"5000",
        next:"true",
    },
    clock:{},
    start : function(pm) {
        var that = this;
        var target_layer = this.kag.layer.getLayer(pm.layer, pm.page);
        this.clock = new THREE.Clock();
        var j_canvas = $("<canvas id='three'></canvas>");
        var sc_width = parseInt(this.kag.config.scWidth);
        var sc_height = parseInt(this.kag.config.scHeight);
        j_canvas.css({
            "position":"absolute",
            "width":sc_width,
            "height":sc_height,
        });
        target_layer.append(j_canvas);
        const renderer = new THREE.WebGLRenderer({
            canvas: document.querySelector('#three'),
            alpha:true,
            antialias: true,
            preserveDrawingBuffer:true
        });
        renderer.setPixelRatio(window.devicePixelRatio);
        renderer.setSize(sc_width, sc_height);
        const scene = new THREE.Scene();
		const camera_mode = pm.camera+"Camera";
        const camera = new THREE[camera_mode](45, sc_width / sc_height, parseFloat(pm.near), parseFloat(pm.far) );
        camera.rotation.order = 'YXZ';
        camera.position.set(0, 0, +1000);
        this.kag.tmp.three.models["camera"] = new ThreeModel({"name":"camera","model":camera,"mixer":null,"gltf":null,"pm":pm},three);
        target_layer.show();
        const light_amb = new THREE.AmbientLight(0xffffff, 1);
        scene.add(light_amb);
        const light = new THREE.DirectionalLight(0xffffff, 1);
		scene.add(light);
        this.kag.tmp.three.stat.is_load = true;
        this.kag.tmp.three.stat.canvas_show = true;
        this.kag.tmp.three.stat.init_pm = pm;
        this.kag.tmp.three.camera = camera;
        this.kag.tmp.three.scene = scene;
        this.kag.tmp.three.renderer = renderer;
        this.kag.tmp.three.light_amb = light_amb;
        this.kag.tmp.three.light = light;
        this.kag.tmp.three.target_layer = target_layer;
        this.kag.tmp.three.j_canvas = j_canvas;
        var three = this.kag.tmp.three;
        tick();
        var t = Math.random() ;
        function tick() {
            if(three.orbit_controls){
            	three.orbit_controls.update();
            }
            that.updateFrame();
            renderer.render(scene, camera);
            var req_id = requestAnimationFrame(tick);
            if(three.stat.is_load == false){
	        	window.cancelAnimationFrame(req_id);
            }
        }
        this.initEvent(this.kag.tmp.three);
        if(pm.next=="true"){
        	this.kag.ftag.nextOrder();
        }
    },
    initEvent:function(three){
		var that = this;
		var renderer = three.renderer;
        var target_layer = three.target_layer;
        var j_canvas = three.j_canvas;
        var camera = three.camera;
        var scene = three.scene;
		j_canvas.on("click", function (event){
	        var x = event.clientX;
			var y = event.clientY;
			var mouse = new THREE.Vector2();
			mouse.x =  ( x / window.innerWidth ) * 2 - 1;
			mouse.y = -( y / window.innerHeight ) * 2 + 1;
			var raycaster = new THREE.Raycaster();
			raycaster.setFromCamera( mouse, camera );
			var intersects = raycaster.intersectObjects( scene.children ,true);
			if(intersects.length>0){
				var name = intersects[0].object.userData["name"];
				if(that.kag.stat.is_strong_stop == true){
					if(three.evt[name]){
						that.kag.layer.showEventLayer();
                		that.kag.ftag.startTag("jump", three.evt[name]);
						return;
					}
				}else{
				}
			}
		});
	},
    updateFrame:function(){
        var three = this.kag.tmp.three;
        var camera = three.camera;
        var models = three.models;
        var delta = this.clock.getDelta();
        for(key in models){
            if(models[key].mixer){
                models[key].update(delta);
            }
        }
        if(three.stat.gyro.mode == 1){
	    	camera.rotation.x = three.stat.gyro.x;
	    	camera.rotation.y = three.stat.gyro.y;
	    }else if(three.stat.gyro.mode == 2){
	    	camera.position.x = three.stat.gyro.x;
	    	camera.position.y = three.stat.gyro.y;
	    }
        sf.orifunc();
    }
};
const tag_name = '3d_init';
tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
[endscript]





[bg storage="../fgimage/color/gray.png"]
[load_stage_objects stage="0"]
[l]
[3d_show name="num_box" pos="-10,0,-20" scale="10"]
[iscript]
let three = TYRANO.kag.tmp.three;
const test_mesh = new THREE.Mesh( new THREE.BoxGeometry(10, 10, 10), new THREE.MeshNormalMaterial());
test_mesh.position.z = -20;
test_mesh.position.x = 10;
three.models.test_mesh = test_mesh;
three.scene.add(three.models.test_mesh);

sf.orifunc = () => {
    TYRANO.kag.tmp.three.models.test_mesh.rotation.y += 0.01;
    TYRANO.kag.tmp.three.models.num_box.model.rotation.y -= 0.01;
}

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
;[3d_debug_camera]
