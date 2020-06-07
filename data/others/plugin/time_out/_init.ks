[iscript]
TYRANO.kag.stat.time_out = {};
TYRANO.kag.stat.time_out.func = function(storage,target){
  return function(){
    TYRANO.kag.ftag.startTag("jump",{
      storage: storage,
      target: target
    })
  }
}
TYRANO.kag.stat.time_out.obj = {};
[endscript]
[macro name="time_out"]
  [iscript]
    mp.name = mp.name || 'setTimeout';
    mp.time = mp.time || 3000;
    TYRANO.kag.stat.time_out.obj[mp.name] = setTimeout(TYRANO.kag.stat.time_out.func(mp.storage,mp.target),mp.time);
  [endscript]
[endmacro]
[macro name="clear_time_out"]
  [iscript]
    mp.name = mp.name || 'setTimeout';
    clearTimeout(TYRANO.kag.stat.time_out.obj[mp.name]);
  [endscript]
[endmacro]
[return]
