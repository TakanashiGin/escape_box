[iscript]
window.plugin_time_out_type = 'builder';
[endscript]
[loadjs storage="plugin/time_out/time_out.js"]
[if exp="plugin_time_out_type = 'builder'"]
  [macro name="time_out"]
    [iscript]
      if (!f.time_out_array) f.time_out_array = [];
      mp.time = parseInt(mp.time);
      f.time_out_array.push(new TyranoPluginSetTimeout(mp));
    [endscript]
  [endmacro]
  [macro name="clear_time_out"]
    [iscript]
      if (!f.time_out_array) f.time_out_array = [];
      if (mp.all == 'true') {
          f.time_out_array = f.time_out_array.forEach(function(value){
              clearInterval(value.func);
          });
          f.time_out_array = [];
      } else {
          f.time_out_array = f.time_out_array.filter(function(value){
              if (value.name == mp.name) clearInterval(value.func);
              else return value;
          });
      }
    [endscript]
  [endmacro]
  [macro name="make_time_out"]
    [iscript]
      if (!f.time_out_array) f.time_out_array = [];
      f.time_out_array.forEach(function(value){
          value.interval();
      });
    [endscript]
  [endmacro]
[else]
  [loadjs storage="plugin/time_out/time_out_script.js"]
[endif]


[return]
