tyrano.plugin.kag.turn_page = {


  ctrlArray: function(pm){
    if (!TYRANO.kag.stat.f.running_turn_page) TYRANO.kag.stat.f.running_turn_page = {};
    if (TYRANO.kag.stat.f.running_turn_page.name) {
      console.error('[error] Only one turn page can be displayed.');
      TYRANO.kag.ftag.nextOrder();
    } else {
      TYRANO.kag.stat.f.running_turn_page = pm;
      console.log(TYRANO.kag.stat.f.running_turn_page);
    }
  },


  showImage: function(pm){
    for (var i=0; i<pm.storage.length; i++) {
      var src = './data/fgimage/' + pm.storage[i];
      $(pm.layer).append('<img class="bookBlockImg' + i + ' ' + pm.name + '" src=' + src + '>');
      $('.bookBlockImg' + i).css({
        position: 'absolute',
        left: pm.left + 'px',
        top: pm.top + 'px',
        width: pm.width + 'px',
        height: pm.height + 'px',
        zIndex: i + 1 + Number(pm.zindex),
        opacity: pm.opacity
      });
    }
  },


  appendDiv: function(pm){
    var className = '.' + pm.name;
    $(className)
      .wrapAll('<div id="bb-bookblock" class="bb-bookblock turn_page_base"></div>')
      .css({left:'0px',top:'0px'});
    $('#bb-bookblock').css({
      left: pm.left + 'px',
      top: pm.top + 'px',
      width: pm.width + 'px',
      height: pm.height + 'px',
      position: 'absolute',
      zIndex: pm.storage.length + Number(pm.zindex),
      backgroundColor: 'rbg(0,0,0)'
    });
    $(className).wrap('<div class="bb-item" style="background-color:rgb(0,0,0);">');
  },


  bookBlock: function(pm){
    $('#bb-bookblock').bookblock({
      orientation: pm.orientation,
  	  direction: pm.direction,
  	  speed: Number(pm.speed),
      easing: pm.easing,
      shadows: pm.shadows,
      shadowSides: Number(pm.shadowSides),
      shadowFlip: Number(pm.shadowFlip),
      circular: pm.circular,
    });
  },


};




tyrano.plugin.kag.tag.turn_page = {


  pm: {
    layer: '0',
    name: "turn_page_img",
    left: "0",
    top: "0",
    width: "0",
    height: "0",
    zindex: "0",
    opacity: "1",
    storage: "",

    orientation: 'vertical',  // vertical, horizontal
	  direction: 'ltr',  // ltr (left to right), rtl (right to left)
	  speed: '800',
    easing: 'ease-in-out',  // animation-timing-function
    shadows: 'true',
    shadowSides: '0.2',
    shadowFlip: '0.1',
    circular: 'false',
  },


  start: function(pm){

    pm.layer = '.' + pm.layer + '_fore'
    if (pm.storage instanceof Array) {
    } else {
      var str = pm.storage;
      if (!pm.storage) console.error('storage属性に正しく値が指定されていません。');
      else pm.storage = str.split(',');
    }
    var storage = pm.storage;
    pm.speed = Number(pm.speed);
    pm.shadowSides = Number(pm.shadowSides);
    pm.shadowFlip = Number(pm.shadowFlip);
    pm.shadows = $.toBoolean(pm.shadows);
    pm.circular = $.toBoolean(pm.circular);

    var that = this.kag.turn_page;
    that.ctrlArray(pm);
    that.showImage(pm);
    that.appendDiv(pm);
    that.bookBlock(pm);

    this.kag.ftag.nextOrder();

  },


};




tyrano.plugin.kag.tag.control_page = {
  vital: ["content"],
  pm: { content: 'next' },
  start: function(pm){
    if (pm.content == 'remove') {
      $('#bb-bookblock').remove();
    } else {
      $('#bb-bookblock').bookblock(pm.content);
    }
    this.kag.ftag.nextOrder();
  }
};




tyrano.plugin.kag.tag.make_turn_page = {
  start: function(pm){
    var mp = this.kag.stat.f.running_turn_page;
    if (mp) this.kag.turn_page.bookBlock(mp);
    this.kag.ftag.nextOrder();
  }
};




tyrano.plugin.kag.tag.clear_turn_page = {
  start: function(pm){
    delete TYRANO.kag.stat.f.running_turn_page;
    this.kag.ftag.nextOrder();
  }
};




(function(tag_names){
  for (var i=0; i<tag_names.length; i++) {
    var tag_name = tag_names[i];
    tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
    tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
  }
}(["turn_page","control_page","make_turn_page","clear_turn_page"]));
