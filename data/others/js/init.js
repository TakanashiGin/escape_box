(function(){

    const sf = TYRANO.kag.variable.sf;

    sf.raf_rot = 0;
    sf.rafContent = function(){
        if (sf.raf_animation) {
            let camera = TYRANO.kag.tmp.three.camera;
            sf.raf_rot += 0.5;
            const radian = (sf.raf_rot * Math.PI) / 180;
            camera.position.x = 100 * Math.sin(radian);
            //camera.position.y = 100 * Math.sin(radian);
            camera.position.z = 100 * Math.cos(radian);
            camera.lookAt(new THREE.Vector3(0, 0, 0));
        }
    }
    sf.rafStop = function(){
        sf.raf_animation = false;
        sf.raf_rot = 0;
    }

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
            TYRANO.kag.variable.sf.rafContent();
        }
    };
    const tag_name = '3d_init';
    tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
    tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
}());
