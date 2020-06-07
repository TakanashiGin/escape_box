class TyranoThreeObject {
    constructor(stage,name,storage,folder,pos,rot,scale,tonemap){
        this.stage = stage;
        this.name = name;
        this.storage = storage;
        this.folder = folder;
        this.pos = pos;
        this.rot = rot;
        this.scale = scale;
        this.tonemap = tonemap;
    }
}

class TyranoThreeImage extends TyranoThreeObject {
    constructor(stage,name,storage,folder,pos,rot,scale,tonemap,width,height,texture,doubleside){
        super(stage,name,storage,folder,pos,rot,scale,tonemap);
        this.width = width;
        this.height = height;
        this.texture = texture;
        this.doubleside = doubleside;
    }
}

class TyranoThreeSprite extends TyranoThreeObject {
    constructor(stage,name,storage,folder,pos,rot,scale,tonemap){
        super(name,storage,folder,pos,rot,scale,tonemap);
    }
}

class TyranoThreeModel extends TyranoThreeObject {
    constructor(stage,name,storage,folder,pos,rot,scale,tonemap,motion){
        super(stage,name,storage,folder,pos,rot,scale,tonemap);
        this.motion = motion;
    }
}
