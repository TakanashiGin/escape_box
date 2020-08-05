[loadjs storage="../scenario/setup/macro/item.js"]

[loadcsv var="tf.items" src="csv/item.csv"]

[iscript]
f.item = new ItemManager(tf.items);
[endscript]

[macro name="show_item"]
    [iscript]
    f.item.initItem();
    [endscript]
[endmacro]

[macro name="close_item"]
    [iscript]
    f.item.closeItem();
    [endscript]
[endmacro]

[macro name="reset_item"]
    [iscript]
    f.item.hold = [];
    f.item.current = null;
    f.item.updateItem();
    [endscript]
[endmacro]

[macro name="get_item"]
    [iscript]
    let stage = (mp.num_box == 'false')? mp.stage : `box_${f.rooms[f.current]}`;
    let item = sf.stage_data[stage]['item'][mp.name];
    f.item.getItem(stage,item);
    f.item.updateItem();
    [endscript]
[endmacro]

[macro name="delete_item"]
    [iscript]
    f.item.hold = f.item.hold.filter(v => {
        if (v.name != mp.name && mp.all != 'true') return v;
    });
    //$.log(f.item.hold);
    f.item.updateItem();
    [endscript]
[endmacro]

; アイテムを使う場合はdelete_itemよりも先に、というか最初に実行
[macro name="use_current_item"]
    [iscript]
    let tmp = f.item.useCurrentItem();
    eval(mp.var + '= tmp');
    [endscript]
[endmacro]

; ※ 使う前に必ず[clearfix]を実行
[macro name="show_item_button"]
    [iscript]
    tf.be = false;
    var index, name;
    f.item.hold.forEach((v,i) => {
        if (v.name == mp.name) {
            tf.be = true;
            index = i;
            name = v.name;
        }
    });
    if (tf.be) {
        let opt = f.item.option;
        let sc_width = TYRANO.kag.config.scWidth;
        tf.b = {};
        tf.b.height = opt.size;
        tf.b.width = opt.size;
        tf.b.y = opt.diff;
        tf.b.x = sc_width - opt.diff - (opt.size * (index+1));
        tf.b.index = index;
        tf.b.name = name;
        //$.log(tf.b);
    }
    [endscript]
    [button fix="true" exp="f.item.showLine(preexp)" preexp="&tf.b" storage="%storage" target="%target" hint="%hint" graphic="../fgimage/color/empty.png" x="&tf.b.x" y="&tf.b.y" width="&tf.b.width" height="&tf.b.height" cond="tf.be"]
[endmacro]

[macro name="no_hold_item_text"]
    [show_message]
    [nowait]
    #あなた
    [if exp="f.hold_items.length > 0"]
        どのアイテムを使おうか……。[r]
        [font color="0xfa8c8c"]
        （画面右上のアイテムをクリックすると使用できるアイテムを選択できます）
        [resetfont]
    [else]
        今は何も持っていない。
    [endif]
    [p]
    #
    [endnowait]
    [hide_message]
[endmacro]


[return]
