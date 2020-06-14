const StageObjectManager = {

    loadStageObjects: function(s){
        const TG = TYRANO.kag;
        const f = TG.stat.f;
        const sf = TG.variable.sf;
        const tf = TG.variable.tf;
        const stage = (!Number.isNaN(parseInt(s)))? `box_${s}` : s;
        Object.keys(sf.stage_data[stage]['objects']).forEach(key => {
            let objects = sf.stage_data[stage]['objects'][key];
            switch (key) {
                case 'image':
                    objects.forEach(pm => {
                        pm.type = "BoxGeometry";
                        pm.depth = "1";
                        pm.arg1 = pm.width;
    		            pm.arg2 = pm.height;
    		            pm.arg3 = pm.depth;
                        pm.tonemap = (pm.tonemap == true)? "true" : "false";
                        pm.doubleside = (typeof pm.doubleside == true)? "true" : "false";
                        if(pm.height==""){
                	    	var texture_url = "./data/others/3d/texture/" + pm.texture;
                			$("<img />").attr("src",texture_url).on("load",(e)=>{
                             	var width = $(e.currentTarget).get(0).width;
                                var height = $(e.currentTarget).get(0).height;
                				var tmp = height/width ;
                				pm.height = parseInt(parseInt(pm.width)*tmp);
                				pm.arg1 = pm.width;
                		        pm.arg2 = pm.height;
                		        pm.arg3 = 1;
                		        StageObjectManager.loadObj(pm);
                            });
                	    }else{
                	        pm.arg1 = pm.width;
                	        pm.arg2 = pm.height;
                	        pm.arg3 = 1;
                	        StageObjectManager.loadObj(pm);
                        }
                    });
                    break;
                case 'sprite':
                    objects.forEach(pm => {
                        pm.next = "true";
                        pm.tonemap = (pm.tonemap == true)? "true" : "false";
                        StageObjectManager.loadSprite(pm);
                    });
                    break;
                case 'model':
                    objects.forEach(pm => {
                        pm.next = "true";
                        pm.tonemap = (pm.tonemap == true)? "true" : "false";
                        StageObjectManager.loadModel(pm);
                    });
                    break;
                case 'box':
                objects.forEach(pm => {
                    pm.type = "BoxGeometry";
                    pm.arg1 = pm.width;
		            pm.arg2 = pm.height;
		            pm.arg3 = pm.depth;
		            StageObjectManager.loadObj(pm);
                });

                    break;
            }
        });
        console.log(`--> load stage objects (${stage})`);
        //console.log(tyrano.plugin.kag.tmp.three);
    },

    deleteStageObjects: function(s){
        const TG = TYRANO.kag;
        const f = TG.stat.f;
        const sf = TG.variable.sf;
        const tf = TG.variable.tf;
        const stage = (!Number.isNaN(parseInt(s)))? `box_${s}` : s;
        Object.keys(sf.stage_data[stage]['objects']).forEach(key => {
            sf.stage_data[stage]['objects'][key].forEach(v => {
                let name = v.name;
                if($.checkThreeModel(name) == false){
                    return;
                }
                var three = TYRANO.kag.tmp.three;
                var model = TYRANO.kag.tmp.three.models[name];
                three.scene.remove(model.model);
                delete TYRANO.kag.tmp.three.models[name];
            });
        });
        console.log(`--> delete stage objects (${stage})`);
        //console.log(tyrano.plugin.kag.tmp.three);
    },

    loadObj: function(pm){
        var three = TYRANO.kag.tmp.three;
        var scene = three.scene;
        const geometry = new THREE[pm.type](parseFloat(pm.arg1), parseFloat(pm.arg2), parseFloat(pm.arg3));
    	let material;
    	if(pm.texture!=""){
    		if(pm.type=="BoxGeometry" && pm.texture.split(",").length > 1){
    			var arr_texture = pm.texture.split(",");
    			var arr_material = [];
    			const loader = new THREE.TextureLoader();
    			for(let i=0;i<arr_texture.length;i++){
    				var texture_url = "./data/others/3d/texture/" + arr_texture[i];
    				const texture = loader.load(texture_url);
    				arr_material.push(new THREE.MeshStandardMaterial({map:texture}));
    			}
    			material = arr_material;
    		}else{
    			var texture_url = "./data/others/3d/texture/" + pm.texture;
    	        const loader = new THREE.TextureLoader();
    			const texture = loader.load(texture_url);
    			material = new THREE.MeshStandardMaterial({
    			    map: texture ,
    			    alphaTest:0.01 ,
    			    transparent:true
    			});
    		}
    	}else{
    		material = new THREE.MeshStandardMaterial( { color:parseInt(pm.color.toLowerCase())} );
    	}
    	if (pm.doubleside == 'true') material["side"] = THREE.DoubleSide;
    	if (pm.tonemap == 'true') material.toneMapped = true;
    	else material.toneMapped = false;
    	const model = new THREE.Mesh(geometry, material);
    	let pos = $.three_pos(pm.pos);
        let scale = $.three_pos(pm.scale);
        let rot = $.three_pos(pm.rot);
    	model.position.set(pos.x,pos.y,pos.z);
        model.scale.set(scale.x,scale.y,scale.z);
        model.rotation.set(rot.x,rot.y,rot.z);
        TYRANO.kag.tmp.three.models[pm.name] = new ThreeModel({"name":pm.name,"model":model,"pm":pm},three);
    },

    loadSprite: function(pm){
        var folder = "";
        if (pm.folder != "") folder = pm.folder;
        else folder = "others/3d/sprite";
        var storage_url = "./data/" + folder + "/" + pm.storage;
        const material = new THREE.SpriteMaterial({
        	map: new THREE.TextureLoader().load(storage_url),
        	alphaTest:0.01 ,
			transparent:true
        });
		if (pm.tonemap == 'true') material.toneMapped = true;
		else material.toneMapped = false;
        var model = new THREE.Sprite(material);
		$("<img />").attr("src",storage_url).on("load",(e)=>{
         	var width = $(e.currentTarget).get(0).width;
            var height = $(e.currentTarget).get(0).height;
			let pos = $.three_pos(pm.pos);
	        let rot = $.three_pos(pm.rot);
			model.position.set(pos.x,pos.y,pos.z);
	        model.rotation.set(rot.x,rot.y,rot.z);
			if(pm.scale==""){
				model.scale.set((parseInt(width)*1),(parseInt(height)*1),1);
	        }else{
		    	let scale = $.three_pos(pm.scale);
				model.scale.set(scale.x,scale.y,scale.z);
		    }
			var three = TYRANO.kag.tmp.three;
	        var scene = three.scene;
	        TYRANO.kag.tmp.three.models[pm.name] = new ThreeModel({"name":pm.name,"model":model,"pm":pm},three);
        });
    },

    loadModel: function(pm){
        var three = TYRANO.kag.tmp.three;
        var folder = "";
        if (pm.folder != "") folder = pm.folder;
        else folder = "others/3d/model";
        var ext = $.getExt(pm.storage);
        if(ext=="gltf" || ext=="glb"){
        	var storage_url = "./data/" + folder + "/" + pm.storage;
	        var loader = new THREE.GLTFLoader();
	        loader.load(storage_url,(data)=>{
	            var gltf = data;
	            var model = gltf.scene;
	            let pos = $.three_pos(pm.pos);
	            let scale = $.three_pos(pm.scale);
	            let rot = $.three_pos(pm.rot);
	            model.position.set(pos.x,pos.y,pos.z);
	            model.scale.set(scale.x,scale.y,scale.z);
	            model.rotation.set(rot.x,rot.y,rot.z);
	            const animations = gltf.animations;
	            let mixer = new THREE.AnimationMixer(model);
	            if(animations.length > 0){
		            let anim = animations[0];
		            if(pm.motion!=""){
			        	for(var i=0;i<animations.length;i++){
				        	var name = animations[i].name;
							if(name==pm.motion){
								anim = animations[i];
								break;
							}
				        }
			        }
	                const anime = mixer.clipAction(anim);
	                anime.play();
	            }else{
	                mixer=undefined;
	            }
	            TYRANO.kag.tmp.three.models[pm.name] = new ThreeModel({"name":pm.name,"model":model,"mixer":mixer,"gltf":gltf,"pm":pm},three);
	            if (pm.tonemap=="true") TYRANO.kag.tmp.three.models[pm.name].setToneMaped(true);
	            else TYRANO.kag.tmp.three.models[pm.name].setToneMaped(false);
	        });
	    }else if(ext=="obj"){
		   	var obj_url = "./data/" + folder + "/" + pm.storage;
		   	var mtl_file = obj_url.replace(".obj",".mtl");
		   	var mtl_url = mtl_file;
		   	var mtlLoader = new THREE.MTLLoader();
		    mtlLoader.load(mtl_url, ( materials )=> {
		        materials.preload();
		        var objLoader = new THREE.OBJLoader();
		        objLoader.setMaterials( materials );
		        materials.toneMaped = false;
		        objLoader.load(obj_url, (obj)=> {
		            var model = obj;
		            let pos = $.three_pos(pm.pos);
		            let scale = $.three_pos(pm.scale);
		            let rot = $.three_pos(pm.rot);
		            model.position.set(pos.x,pos.y,pos.z);
		            model.scale.set(scale.x,scale.y,scale.z);
		            model.rotation.set(rot.x,rot.y,rot.z);
		            TYRANO.kag.tmp.three.models[pm.name] = new ThreeModel({"name":pm.name,"model":model,"pm":pm },three);
		            if (pm.tonemap=="true") TYRANO.kag.tmp.three.models[pm.name].setToneMaped(true);
		            else TYRANO.kag.tmp.three.models[pm.name].setToneMaped(false);
		        } /*, onProgress, onError */ );
		    });
		}else if(ext=="mmd"){
		}else{
			alert("エラー："+ext+"はサポートしていないファイル形式です");
		}
    }

}
