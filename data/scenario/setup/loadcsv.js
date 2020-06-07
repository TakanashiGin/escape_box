(function(){

    const TG = TYRANO.kag;
    const f = TG.stat.f;
    const sf = TG.variable.sf;
    const tf = TG.variable.tf;

    // image
    tf.three_images = tf.three_images.map(ver => {
        return ver.map((side,i) => {
            if (typeof side == 'string' && side.indexOf('-') >= 1) return side.split('-').join(',');
            else if (side == 'none') {
                let index = tf.three_images[0];
                if (index[i] == 'width' || index[i] == 'height' || index[i] == 'scale') return '1';
                else if (index[i] == 'pos' || index[i] == 'rot') return '0';
                else if (index[i] == 'color') return "0x00ff00";
                else return "";
            }
            else return side;
        });
    });
    tf.three_images.forEach((val,i) => {
        if (i > 0) sf.object_data.image.push(new TyranoThreeImage(...val));
    });

    let pushObject = (data,data_key,num) => {
        if (!num) num = data.stage;
        let stage = (data.stage != 'global')? `box_${num}` : 'global';
        if (!sf.stage_data[stage]) sf.stage_data[stage] = {};
        if (!sf.stage_data[stage]['objects']) sf.stage_data[stage]['objects'] = {};
        if (!sf.stage_data[stage]['objects'][data_key]) sf.stage_data[stage]['objects'][data_key] = [];
        let tmp = {};
        Object.keys(data).forEach(k => {
            if (k != 'stage') tmp[k] = data[k];
        });
        sf.stage_data[stage]['objects'][data_key].push(tmp);
    }
    Object.keys(sf.object_data).forEach(data_key => {
        sf.object_data[data_key].forEach(data => {
            if (data.stage == 'global') {
                pushObject(data,data_key);
            } else if (typeof data.stage == 'string' && data.stage.indexOf(',') >= 1) {
                let stages = data.stage.split(',');
                stages.forEach(num => pushObject(data,data_key,num));
            } else {
                pushObject(data,data_key);
            }
        });
    });

    console.log(sf.stage_data);

}());





var StageObjectManager = {

    loadStageObjects: function(s){
        const TG = TYRANO.kag;
        const f = TG.stat.f;
        const sf = TG.variable.sf;
        const tf = TG.variable.tf;
        const stage = (s != 'global')? `box_${s}` : 'global';
        Object.keys(sf.stage_data[stage]['objects']).forEach(key => {
            let objects = sf.stage_data[stage]['objects'][key];
            switch (key) {
                case 'image':
                    objects.forEach(v => {
                        let pm = v;
                        pm.arg1 = pm.width;
    		            pm.arg2 = pm.height;
    		            pm.arg3 = pm.depth;
                        pm.type = "BoxGeometry";
                        pm.depth = "1";
                        StageObjectManager.loadObj(pm);
                    });
                    break;
                case 'sprite':
                    break;
                case 'model':
                    break;
            }
        });
        console.log(tyrano.plugin.kag.tmp.three);
    },

    deleteStageObjects: function(s){
        const TG = TYRANO.kag;
        const f = TG.stat.f;
        const sf = TG.variable.sf;
        const tf = TG.variable.tf;
        const stage = (s != 'global')? `box_${s}` : 'global';
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
        console.log(tyrano.plugin.kag.tmp.three);
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
    	if(pm.doubleside=="true"){
    		material["side"] = THREE.DoubleSide;
    	}
    	if(pm.tonemap=="true"){
    		material.toneMapped = true;
    	}else{
    		material.toneMapped = false;
    	}
    	const model = new THREE.Mesh(geometry, material);
    	let pos = $.three_pos(pm.pos);
        let scale = $.three_pos(pm.scale);
        let rot = $.three_pos(pm.rot);
    	model.position.set(pos.x,pos.y,pos.z);
        model.scale.set(scale.x,scale.y,scale.z);
        model.rotation.set(rot.x,rot.y,rot.z);
        TYRANO.kag.tmp.three.models[pm.name] = new ThreeModel({"name":pm.name,"model":model,"pm":pm},three);
    }

}
