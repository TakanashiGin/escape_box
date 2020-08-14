class TyranoThreeObject {
    constructor(stage,name,storage,folder,pos,rot,scale,tonemap){
        this.stage = stage;
        this.name = name;
        this.storage = storage;
        this.folder = folder;
        this.pos = pos;
        this.rot = rot;
        if (this.rot != 0 && this.rot != false) this.rot = this.rot.split(',').map(v => getRadian(v)).join(',');
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
        super(stage,name,storage,folder,pos,rot,scale,tonemap);
    }
}

class TyranoThreeModel extends TyranoThreeObject {
    constructor(stage,name,storage,folder,pos,rot,scale,tonemap,motion){
        super(stage,name,storage,folder,pos,rot,scale,tonemap);
        this.motion = motion;
    }
}

class TyranoThreeBox extends TyranoThreeObject {
    constructor(stage,name,texture,color,width,height,depth,pos,rot,scale,tonemap){
        super(stage,name,pos,rot,scale,tonemap);
        this.texture = texture;
        this.color = color;
        this.width = width;
        this.height = height;
        this.depth = depth;
        this.pos = pos;
        this.rot = rot;
        this.scale = scale;
        this.tonemap = tonemap;
    }
}
