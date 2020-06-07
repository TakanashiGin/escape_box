(function(){


  var tmp = TYRANO.kag.stat.mp;


  TYRANO.kag.variable.sf.set_select_button = {

    i: 0,
    num: 0,

    left: tmp.left || 0,
    right: tmp.right || $('#tyrano_base').width(),
    top: tmp.top || 0,
    bottom: tmp.bottom || $('#tyrano_base').height(),

    x: [],
    y: [],
    dx: [],
    dy: [],

    storage: [],
    target: [],
    name: [],
    text: [],

    color: tmp.color,
    font_color: tmp.font_color,
    size: tmp.size,
    face: tmp.face,
    graphic: tmp.graphic,
    enterimg: tmp.enterimg,
    clickse: tmp.clickse,
    leavese: tmp.leavese

  };


  var that = TYRANO.kag.variable.sf.set_select_button;

  that.area_width = that.right-that.left;
  that.area_height = that.bottom-that.top;
  that.width = tmp.width || that.area_width/2;
  that.height = tmp.height || that.area_height/2;

  if (tmp.storage) that.storage = tmp.storage.split(',');
  if (tmp.target) that.target = tmp.target.split(',');
  if (tmp.name) that.name = tmp.name.split(',');
  if (tmp.text) that.text = tmp.text.split(',');
  if (tmp.dx) that.dx = tmp.dx.split(',');
  if (tmp.dy) that.dy = tmp.dy.split(',');

  if (that.text.length != 0) that.num = that.text.length;
  else if (that.name.length != 0) that.num = that.name.length;
  else if (that.target.length != 0) that.num = that.target.length;
  else if (that.storage.length != 0) that.num = that.storage.length;

  var yspace = (that.area_height-(that.height*that.num))/(that.num+1);
  for (var i=0; i<that.num; i++) {
    that.x[i] = (that.area_width - that.width) / 2;
    if (that.dx[i]) that.x[i] += parseInt(that.dx[i]);
    var plus = (parseInt(that.height)+yspace) * i;
    console.log(plus);
    that.y[i] = yspace + plus;
    if (that.dy[i]) that.y[i] += parseInt(hat.dy[i]);
  }

  console.log(that);


}());
