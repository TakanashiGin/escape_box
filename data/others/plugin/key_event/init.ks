[loadjs storage="plugin/key_event/system.js"]
[loadjs storage="plugin/key_event/function.js"]



[macro name="key_event"]
  [iscript]
    var that = TYRANO.kag.plugin_key_event;
    var key_event_obj = {
      name: mp.name || 'event',
      clear: mp.clear || true,
      method: mp.method || 'keydown',
      key_code: Number(mp.key_code) || 13,
      element: mp.element || window,
      storage: mp.storage || null,
      target: mp.target || null,
      exp: mp.exp || null,
      mouseover_exp: mp.mouseover_exp || null,
      mouseout_exp: mp.mouseout_exp || null,
      preexp: mp.preexp || null,
      sleepgame: mp.sleepgame || false
    };
    key_event_obj.clear = that.methods.boolean(key_event_obj.clear);
    key_event_obj.sleepgame = that.methods.boolean(key_event_obj.sleepgame);
    that.methods.pushEvent(key_event_obj);
    delete key_event_obj;
  [endscript]
[endmacro]

[macro name="clear_key_event"]
  [iscript]
    var that = TYRANO.kag.plugin_key_event;
    var clear_obj = {
      name:  mp.name || null,
      element: mp.element || window,
      all: mp.all = mp.all || true,
      reset: mp.reset || false
    }
    clear_obj.all = that.methods.boolean(clear_obj.all);
    clear_obj.reset = that.methods.boolean(clear_obj.reset);
    that.methods.clearEvent(clear_obj);
    delete clear_obj;
  [endscript]
[endmacro]

[macro name="make_key_event"]
  [iscript]
  var that = TYRANO.kag.plugin_key_event;
  that.methods.allResetEvent();
  that.methods.allStartEvent();
  [endscript]
[endmacro]

[return]
