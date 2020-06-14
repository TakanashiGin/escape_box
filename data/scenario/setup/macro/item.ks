[loadjs storage="../scenario/setup/macro/item.js"]

[loadcsv var="tf.items" src="csv/item.csv"]
[eval exp="ItemManager.setCsvData(tf.items)"]

[macro name="show_item"]
    [iscript]
    ItemManager.initItem();
    [endscript]
[endmacro]

[macro name="close_item"]
    [iscript]
    ItemManager.closeItem();
    [endscript]
[endmacro]

[macro name="reset_item"]
    [iscript]
    f.hold_items = [];
    f.current_hold_item = null;
    ItemManager.updateItem();
    [endscript]
[endmacro]

[macro name="get_item"]
    [iscript]
    let stage = (mp.num_box == 'false')? mp.stage : `box_${f.rooms[f.current]}`;
    let item = sf.stage_data[stage]['item'][mp.name];
    f.hold_items.push(item);
    ItemManager.updateItem();
    [endscript]
[endmacro]

[macro name="delete_item"]
    [iscript]
    f.hold_items = f.hold_items.filter(v => {
        if (v.name != mp.name && mp.all != 'true') return v;
    });
    ItemManager.updateItem();
    [endscript]
[endmacro]

; ※ 使う前に必ず[clearfix]を実行
[macro name="show_item_button"]
    [iscript]
    tf.be = false;
    var index, name;
    f.hold_items.forEach((v,i) => {
        if (v.name == mp.name) {
            tf.be = true;
            index = i;
            name = v.name;
        }
    });
    if (tf.be) {
        let opt = ItemManager.opt;
        let sc_width = TYRANO.kag.config.scWidth;
        tf.b = {};
        tf.b.height = opt.size;
        tf.b.width = opt.size;
        tf.b.y = opt.diff;
        tf.b.x = sc_width - opt.diff - (opt.size * (index+1));
        tf.b.index = index;
        tf.b.name = name;
        //console.log(tf.b);
    }
    [endscript]
    [button fix="true" exp="ItemManager.showLine(preexp)" preexp="&tf.b" storage="%storage" target="%target" hint="%hint" graphic="../fgimage/color/empty.png" x="&tf.b.x" y="&tf.b.y" width="&tf.b.width" height="&tf.b.height" cond="tf.be"]
[endmacro]

[macro name="no_hold_item_text"]
    [show_message]
    [nowait]
    #あなた
    [if exp="f.hold_items.length > 0"]
        どのアイテムを使おうか……。
    [else]
        今は何も持っていない。
    [endif]
    [p]
    #
    [endnowait]
    [hide_message]
[endmacro]

[return]
