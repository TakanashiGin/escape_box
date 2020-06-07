[macro name="noskip"]
  [iscript]
    TYRANO.kag.stat.no_skip = true;
    Object.defineProperty(TYRANO.kag.stat,'is_skip',{
      get: function(){return this._is_skip && !this.no_skip},
      set: function(flag){this._is_skip = flag}
    })
  [endscript]
[endmacro]

[macro name="endnoskip"]
  [iscript]
  TYRANO.kag.stat.no_skip = false;
  [endscript]
[endmacro]


[return]
