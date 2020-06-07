class Character {

    constructor(name,jname,storage,width,height,reflect,color){
        this.name     = name;
        this.jname    = jname;
        this.storage  = storage;
        this.width    = width;
        this.height   = height;
        this.reflect  = reflect;
        this.color    = color;
        this.map_face = {};
        this.face     = [];
    }
    
    addTyrano(){
        let storage_url = $.isHTTP(this.storage) ? this.storage : "./data/fgimage/" + this.storage;
        this.map_face["default"] = this.storage;
        TYRANO.kag.preload(storage_url);
        TYRANO.kag.stat.charas[this.name] = {
            name: this.name,
            jname: this.jname,
            storage: this.storage,
            width: this.width,
            height: this.height,
            reflect: this.reflect,
            color: this.color,
            map_face: this.map_face
        };
        if (this.jname) TYRANO.kag.stat.jcharas[this.jname] = this.name;
    }

}



class NormalCharacter extends Character {

    constructor(name,jname,storage,width,height,reflect,color){
        super(name,jname,storage,width,height,reflect,color);
    }

    setFace(new_face,face_storage){
        this.face.push({ name: new_face, url: face_storage });
    }

    addFace(face){
        TYRANO.kag.stat.charas[this.name]["map_face"][face.name] = face.url;
    }

}



class PartsCharacter extends Character {

    constructor(name,jname,storage,width,height,reflect,color){
        super(name,jname,storage,width,height,reflect,color);
        this.face_layer = [];
    }

    setLayer(part,id,storage,zindex){
        this.face_layer.push({
            name: this.name,
            part: part || "",
            id: id || "",
            storage: storage || "",
            zindex: zindex || ""
        });
    }

    addLayer(pm){
        let cpm = TYRANO.kag.stat.charas[pm.name];
        if (!cpm) {
            console.error(`[ERROR] The specified character ${pm.name} is not defined. Please define it in [chara_new].`);
            return;
        }
        let chara_layer = {};
        if (cpm["_layer"]) chara_layer = cpm["_layer"];
        else cpm["_layer"] = {};
        let chara_part = {};
        let init_part = false;
        if (chara_layer[pm.part]) {
            chara_part = chara_layer[pm.part];
        } else {
            init_part = true;
            cpm["_layer"][pm.part] = {
                "default_part_id": pm.id,
                "current_part_id": pm.id,
                "zindex": pm.zindex
            };
        }
        let chara_obj = {};
        if (chara_part[pm.id]) {
            chara_obj = chara_part[pm.id];    
        } else {
            chara_obj = { storage: "", zindex: "" };
            chara_obj.visible = init_part ? "true" : "false";
        }
        cpm["_layer"][pm.part][pm.id] = $.extendParam(pm,chara_obj);
    }

}



class CharacterManager {
    constructor(type,data){

        const json_data = data;
    
        if (type == 'parts') {

            this.characters = [];

            Object.keys(json_data).forEach(chara_key => {
            
                const chara = json_data[chara_key];
            
                let param = [chara_key];
                let parts = [];

                Object.keys(chara).forEach(key => {
                    if (key == 'param') {
                        Object.keys(chara.param).forEach(p => param.push(chara.param[p]));
                    } else {
                        Object.keys(chara[key]['face']).forEach(face_key => {
                            let part = [key, face_key, chara[key]['face'][face_key], chara[key]['zindex']];
                            parts.push(part);
                        });
                    }
                });
                
                param = param.map(p => {
                    if (p == 'none') return null;
                    else return p;
                });
                let new_chara = new PartsCharacter(...param);
                parts.forEach(face => new_chara.setLayer(...face));
                this.characters.push(new_chara);
            });
        
            this.characters.forEach(chara => {
                chara.addTyrano();
                chara.face_layer.forEach(face => chara.addLayer(face));
            });
    
        } else {
    
            this.chara_datas = [];
            this.characters = [];
    
            Object.keys(json_data).forEach(chara_key => {
    
                const chara = json_data[chara_key];

                let data = [];
                data.push(chara_key);
                Object.keys(chara.param).forEach(pmp => data.push(chara['param'][pmp]));

                let face = [];
                Object.keys(chara.face).forEach(fmp => face.push([fmp,chara['face'][fmp]]));

                this.chara_datas.push({ data: data, face: face });

            });

            this.chara_datas.forEach(chara => {
                chara.data = chara.data.map(d => {
                    if (d == 'none') return null;
                    else return d;
                });
                let new_chara = new NormalCharacter(...chara.data);
                chara.face.forEach(face_list => new_chara.setFace(...face_list));
                this.characters.push(new_chara);
            });

            this.characters.forEach(chara => {
                chara.addTyrano();
                if (chara.face.length != 0) chara.face.forEach(face => chara.addFace(face));
            });
            
        }
    
    }
}




tyrano.plugin.kag.tag.character_manager = {
    
    vital: ['src'],
    
    pm: { type:'normal', var:'sf.character_manager', time:'10' },
    
    start: function(pm){
        const that = this;
        const time = (parseInt(pm.time) <= 0) ? 10 : parseInt(pm.time);
        const src = `./data/others/${pm.src}`;
        $.getJSON(src, json_data => {
            setTimeout(() => that.kag.tag.character_manager.instanceCharacter(pm,json_data), time);
        });

    },
    instanceCharacter: function(pm,json_data){
        const that = TYRANO;
        const sf = that.kag.variable.sf,
              f = that.kag.stat.f,
              tf = that.kag.variable.tf,
              mp = that.kag.stat.mp;
        let c = new CharacterManager(pm.type,json_data);
        if (pm.var) eval(`${pm.var} = c`);
        that.kag.ftag.nextOrder();
    }
};



(function(){
    const tag_name = 'character_manager';
    tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
    tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
}());