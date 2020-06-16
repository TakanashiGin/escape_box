class ItemManager {

    constructor(csv_data){
        this.current;
        this.get_item = null;
        this.hold = [];
        this.option = {
            size: 100,
            diff: 20,
            size_per: 0.75,
            item_bar_color: 'white',
            on_item_color: 'gray'
        };
        this.csv_data = csv_data;
        this.setCsvData();
    }

    setCsvData(){
        const items = this.csv_data;
        const sf = TYRANO.kag.variable.sf;
        for (let i=1; i<items.length; i++) {
            let ver = items[i];
            let s = ver[0];
            let name = ver[1];
            let stage = (!Number.isNaN(parseInt(s)))? `box_${s}` : s;
            if (!sf.stage_data[stage]['item']) sf.stage_data[stage]['item'] = {};
            if (!sf.stage_data[stage]['item'][name]) sf.stage_data[stage]['item'][name] = {};
            ver.forEach((v,j) => sf.stage_data[stage]['item'][name][items[0][j]] = v);
        }
        //console.log(sf.stage_data);
    }

    initItem(){
        const self = this;
        const j_item_bar = $(`<div id="item_bar"></div>`).css({
            position: 'absolute',
            display: 'block',
            left: `${self.option.diff}px`,
            top: `${self.option.diff}px`,
            width: `${TYRANO.kag.config.scWidth - (self.option.diff*2)}px`,
            height: `${self.option.size}px`,
            zindex: 999999,
            overflow: 'hidden'
        });
        $('.1_fore').append(j_item_bar);
        const j_items = $(`<div id="items"></div>`).css({
            width: '1px',
            height: `${self.option.size}px`,
            float: 'right',
            overflow: 'hidden'
        });
        $('#item_bar').append(j_items);
        const j_ptext = $(`<p id="item_subject">ITEM</p>`).css({
            color: 'black',
            backgroundColor: self.option.item_bar_color,
            fontSize: `${self.option.size/2}px`,
            top: `${self.option.diff}px`,
            height: `${self.option.size}px`,
            verticalAlign: 'middle',
            lineHeight: `${self.option.size}px`,
            textAlign: 'right',
            float: 'right',
            display: 'block',
            //textShadow:"2px 2px 0 black,-2px 2px 0 black,2px -2px 0 black,-2px -2px 0 black"
            //textShadow:"2px 2px 0 white,-2px 2px 0 white,2px -2px 0 white,-2px -2px 0 white"
        });
        $('#item_bar').append(j_ptext);
    }

    closeItem(){
        $('#item_bar').remove();
    }

    updateItem(){
        const self = this;
        const f = TYRANO.kag.stat.f;

        //console.log(this);

        $('#items').empty();

        if (self.hold.length > 0) {
            self.hold.forEach((item,i) => {

                const sc_width = TYRANO.kag.config.scWidth;
                const sc_height = TYRANO.kag.config.scHeight;

                const div_size = self.option.size;
                const diff = self.option.diff;
                const div = {
                    class_name: `item_${i} ${item.name}`,
                    left: sc_width - ((div_size) * (i + 1)),
                };
                const j_div_item = $(`<div class='${div.class_name}'></div>`).css({
                    left: `${div.left}px`,
                    width: `${div_size}px`,
                    height: `${div_size}px`,
                    float: 'right',
                    display: 'flex',
                    justifyContent: "center",
                    alignItems: "center",
                    backgroundColor: self.option.item_bar_color
                });
                $('#items').css("width",`${(div_size) * (i + 1)}px`).append(j_div_item);

                if (self.get_item) {
                    item.line = true;
                    self.current = item.name;
                } else {
                    if (i == 0) self.current = item.name;
                }
                self.get_item = null;
                //console.log(self.current)

                item.src = `./data/image/${item.storage}`;
                if (item.width >= item.height) {
                    item.dwidth = item.width * self.option.size_per;
                    item.dheight = item.height * (item.width/div_size) * self.option.size_per;
                } else {
                    item.dheight = item.height * self.option.size_per;
                    item.dwidth = item.width * (item.height/div_size) * self.option.size_per;
                }
                const j_item = $(`<img src='${item.src}'></img>`).css({
                    width: `${item.dwidth}px`,
                    height: `${item.dheight}px`
                });
                $(`.${item.name}`).append(j_item);

            });
            this.hold.forEach(v => {
                if (self.current == v.name) {
                    self.showLine(v);
                }
            });
        } else {
            $('#items').css("width","1px");
        }
    }

    getItem(stage,item){
        this.get_item = item.name;
        this.hold.push(item);
    }

    useCurrentItem(){
        let tmp = this.current;
        this.current = null;
        return tmp;
    }

    showLine(b){
        var self = this;
        this.hold.forEach((v,i) => {
            if (v.line == true) {
                self.hold[i].line = false;
                $(`.${v.name}`).css('backgroundColor',self.option.item_bar_color);
            }
            if (v.line != true && b.name == v.name) {
                self.hold[i].line = true;
                self.current = v.name;
                $(`.${v.name}`).css('backgroundColor',self.option.on_item_color);
            }
        });
    }

    checkGotItem(name){
        var self = this;
        var be = false;
        for (let index of self.hold) {
            let v = self.hold[index];
            if (v.name == name) be = true;
        }
        return be;
    }

};





const _ItemManager = {


    opt: {
        size: 100,
        diff: 20,
        size_per: 0.75,
        item_bar_color: 'white',
        on_item_color: 'gray'
    },


    setCsvData: function(items){
        const sf = TYRANO.kag.variable.sf;
        for (let i=1; i<items.length; i++) {
            let ver = items[i];
            let s = ver[0];
            let name = ver[1];
            let stage = (!Number.isNaN(parseInt(s)))? `box_${s}` : s;
            if (!sf.stage_data[stage]['item']) sf.stage_data[stage]['item'] = {};
            if (!sf.stage_data[stage]['item'][name]) sf.stage_data[stage]['item'][name] = {};
            ver.forEach((v,j) => sf.stage_data[stage]['item'][name][items[0][j]] = v);
        }
    },


    initItem: function(){

        //TYRANO.kag.stat.f.hold_items = [];

        const self = this;

        const j_item_bar = $(`<div id="item_bar"></div>`).css({
            position: 'absolute',
            display: 'block',
            left: `${self.opt.diff}px`,
            top: `${self.opt.diff}px`,
            width: `${TYRANO.kag.config.scWidth - (self.opt.diff*2)}px`,
            height: `${self.opt.size}px`,
            zindex: 999999,
            overflow: 'hidden'
        });
        $('.1_fore').append(j_item_bar);

        const j_items = $(`<div id="items"></div>`).css({
            width: '1px',
            height: `${self.opt.size}px`,
            float: 'right',
            overflow: 'hidden'
        });
        $('#item_bar').append(j_items);

        const j_ptext = $(`<p id="item_subject">ITEM</p>`).css({
            color: 'black',
            backgroundColor: self.opt.item_bar_color,
            fontSize: `${self.opt.size/2}px`,
            top: `${self.opt.diff}px`,
            height: `${self.opt.size}px`,
            verticalAlign: 'middle',
            lineHeight: `${self.opt.size}px`,
            textAlign: 'right',
            float: 'right',
            display: 'block',
            //textShadow:"2px 2px 0 black,-2px 2px 0 black,2px -2px 0 black,-2px -2px 0 black"
            //textShadow:"2px 2px 0 white,-2px 2px 0 white,2px -2px 0 white,-2px -2px 0 white"
        });
        $('#item_bar').append(j_ptext);

    },


    closeItem: function(){
        //TYRANO.kag.stat.f.hold_items = [];
        $('#item_bar').remove();
    },


    updateItem: function(){

        const self = this;
        const f = TYRANO.kag.stat.f;
        const items = TYRANO.kag.stat.f.hold_items;
        //console.log(items);

        $('#items').empty();

        if (items.length > 0) {
            items.forEach((item,i) => {

                const sc_width = TYRANO.kag.config.scWidth;
                const sc_height = TYRANO.kag.config.scHeight;

                const div_size = self.opt.size;
                const diff = self.opt.diff;
                const div = {
                    class_name: `item_${i} ${item.name}`,
                    left: sc_width - ((div_size) * (i + 1)),
                };
                const j_div_item = $(`<div class='${div.class_name}'></div>`).css({
                    left: `${div.left}px`,
                    width: `${div_size}px`,
                    height: `${div_size}px`,
                    float: 'right',
                    display: 'flex',
                    justifyContent: "center",
                    alignItems: "center",
                    backgroundColor: self.opt.item_bar_color
                });
                $('#items').css("width",`${(div_size) * (i + 1)}px`).append(j_div_item);

                /*
                if (i == 0) {
                    var bool = true;
                    for (let index=0; index<f.hold_items.length; index++) {
                        if (index != 0 && f.hold_items[index]['line'] == true) {
                            bool = false;
                        }
                    }
                    if (bool == true) self.showLine(item);
                }
                */

                item.src = `./data/image/${item.storage}`;
                if (item.width >= item.height) {
                    item.dwidth = item.width * self.opt.size_per;
                    item.dheight = item.height * (item.width/div_size) * self.opt.size_per;
                } else {
                    item.dheight = item.height * self.opt.size_per;
                    item.dwidth = item.width * (item.height/div_size) * self.opt.size_per;
                }
                const j_item = $(`<img src='${item.src}'></img>`).css({
                    width: `${item.dwidth}px`,
                    height: `${item.dheight}px`
                });
                $(`.${item.name}`).append(j_item);

            });
        } else {
            $('#items').css("width","1px");
        }
    },


    showLine: function(b){
        var self = this;
        TYRANO.kag.stat.f.hold_items.forEach((v,i) => {
            if (v.line == true) {
                TYRANO.kag.stat.f.hold_items[i].line = false;
                $(`.${v.name}`).css('backgroundColor',self.opt.item_bar_color);
            }
            if (v.line != true && b.name == v.name) {
                TYRANO.kag.stat.f.hold_items[i].line = true;
                TYRANO.kag.stat.f.current_hold_item = v.name;
                $(`.${v.name}`).css('backgroundColor',self.opt.on_item_color);
                //console.log(v.name);
            }
        });
    },


    checkGot: function(name){
        var be = false;
        for (let index of TYRANO.kag.stat.f.hold_items) {
            let v = TYRANO.kag.stat.f.hold_items[index];
            if (v.name == name) be = true;
        }
        return be;
    }


};
