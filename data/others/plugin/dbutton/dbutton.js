/*
#[dbutton]
:group
ラベル・ジャンプ操作
:title
クリック可能な領域を設定
:exp
透明なエベント可能領域を設定することができます。
イベントエリアの表示中は強制的にシナリオ進行が停止しますので、必ずジャンプ先を指定して下さい
また、イベントボタンの表示位置は直前のlocateタグによる指定位置を参照します
ここから、移動した場合はコールスタックに残りません。つまり、リターンできないのでご注意ください
☆重要：[s]タグに到達していない間は、イベントは有効になりません。かならず、[s]タグでゲームを停止してください。
:sample
[locate x=20 y=100]
[dbutton width=200 height=300 target=*oda]
[locate x=300 y=100]
[dbutton width=100 height=100 border="solid:1px:gray" target=*oda]
[s]
:param
width=領域の横幅を指定します,
height=領域に高さを指定します,
x=領域の左端位置のX座標を指定します,
y=領域の左端位置のY座標を指定します。,
borderstyle=領域に線を表示することができます。「線の太さ:線の種類（CSS準拠）:線の色」のフォーマットで記述して下さい。線の種類はsolid double groove dashed dotted などが指定できます,　
color=表示色を 0xRRGGBB 形式で指定 します。 ,
opacity=領域の不透明度を 0 ～ 255 の数値で指定します0で完全 に透明です。,
mouseopacity=領域にマウスが乗った時透明度を変更することができます。領域の不透明度を 0 ～ 255 の数値で指定します0で完全 に透明です,
storage=クリックされた際のジャンプ先のシナリオファイルを指定します。省略すると、現在 のシナリオファイル内であると見なされます。,
target=クリックされた際のジャンプ先のラベルを指定します。省略すると、ファイルの先頭から実行されます。
name:
event:
#[end]
*/

//指定した位置にグラフィックボタンを配置する
tyrano.plugin.kag.tag.dbutton = {

    vital : ["width", "height"],

    pm : {
        width : "0",
        height : "0",
        x : "",
        y : "",
        border : "none",
        color : "",
        mouseopacity : "",
        opacity : "140",
        storage : null,
        target : null,
        name : "",
        event: "click"
    },

    //イメージ表示レイヤ。メッセージレイヤのように扱われますね。。
    //cmで抹消しよう
    start : function(pm) {

        var that = this;

        //this.kag.stat.locate.x
        var layer_free = this.kag.layer.getFreeLayer();

        layer_free.css("z-index", 9999999);

        var j_button = $("<div />");
        j_button.css("position", "absolute");
        j_button.css("cursor", "pointer");
        j_button.css("top", this.kag.stat.locate.y + "px");
        j_button.css("left", this.kag.stat.locate.x + "px");
        j_button.css("width", pm.width + "px");
        j_button.css("height", pm.height + "px");
        j_button.css("opacity", $.convertOpacity(pm.opacity));
        j_button.css("background-color", $.convertColor(pm.color));
        j_button.css("border", $.replaceAll(pm.border, ":", " "));

        //alert($.replaceAll(pm.border,":"," "));

        //x,y 座標が指定されている場合は、そっちを採用
        if (pm.x != "") {
            j_button.css("left", parseInt(pm.x));
        }

        if (pm.y != "") {
            j_button.css("top", parseInt(pm.y));
        }

        //クラスとイベントを登録する
        that.kag.event.addEventElement({
            "tag":"clickable",
            "j_target":j_button, //イベント登録先の
            "pm":pm
        });

        that.setEvent(j_button,pm);

        layer_free.append(j_button);
        layer_free.show();

        this.kag.ftag.nextOrder();

    },

    setEvent:function(j_button,pm){

        var that = TYRANO;

        (function() {

            var _target = pm.target;
            var _storage = pm.storage;
            var _pm = pm;

            if (_pm.mouseopacity != "") {

                j_button.bind("mouseover", function() {
                    j_button.css("opacity", $.convertOpacity(_pm.mouseopacity));

                });

                j_button.bind("mouseout", function() {
                    j_button.css("opacity", $.convertOpacity(_pm.opacity));
                });

            }

            j_button.click(function() {

                //Sタグに到達していないとクリッカブルが有効にならない

                var is_s = (function(obj) {
                    if (obj.kag.stat.is_strong_stop != true) {
                        return false;
                    }

                    return true;

                })(that);

                if (is_s == false) {
                    return false;
                }

                that.kag.ftag.startTag("cm", {});
                //コールを実行する
                that.kag.layer.showEventLayer();
                that.kag.ftag.startTag("jump", _pm);


            });

        })();


    }

};























/*
TYRANO.kag.stat.f.plugin_dbutton = [];

tyrano.plugin.kag.dbutton = {

  set: function(mp){
    mp.name = mp.name || 'element';
    var tmp = {
      name: 'dbutton_' + mp.name,
      left: Number(mp.left) || 0,
      top: Number(mp.top) || 0,
      width: Number(mp.width) || $('#tyrano_base').width(),
      height: Number(mp.height) || $('#tyrano_base').height(),
      opacity: Number(mp.opacity)/100 || 0.5,
      color: mp.color || 'black',
      evt: mp.event || 'click',
      storage: mp.storage,
      target: mp.target
    };
    $('#root_layer_system').append('<div class=' + tmp.name + '></div>');
    $('.' + tmp.name).css({
      left: tmp.left + 'px',
      top: tmp.top + 'px',
      width: tmp.width + 'px',
      height: tmp.height + 'px',
      opacity: tmp.opacity,
      backgroundColor: tmp.color,
      position: 'absolute',
      display: 'block'
    }).on(tmp.evt,function(){
      TYRANO.kag.ftag.startTag('jump',{storage:tmp.storage,target:tmp.target});
    });
    TYRANO.kag.stat.f.plugin_dbutton.push(tmp);
  },

  clear: function(mp){
    var f = TYRANO.kag.stat.f;
    if (mp.all == 'true') {
      f.plugin_dbutton.forEach(function(val){
        $('.' + val.name).off();
        $('.' + val.name).remove();
      });
      f.plugin_dbutton = [];
    } else {
      mp.name = mp.name || 'element';
      mp.name = 'dbutton_' + mp.name;
      $('.' + mp.name).off();
      $('.' + mp.name).remove();
      f.plugin_dbutton = f.plugin_dbutton.filter(function(val){
        if (val.name != mp.name) return val;
      });
    }
  },

  make: function(mp){
    var f = TYRANO.kag.stat.f,
        that = tyrano.plugin.kag.dbutton;
    f.plugin_dbutton.forEach(function(val){
      console.log(val);
      that.set(val);
    });
  }

};
*/
