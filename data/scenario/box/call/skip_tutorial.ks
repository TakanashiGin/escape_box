[glink text="アカネの話を聞く"        color="btn_07_white" size="30" target="no"  x="390" y="100" width="500" height="70" clickse="&getSe()"]
[glink text="アカネの話をスキップする" color="btn_07_white" size="30" target="yes" x="390" y="250" width="500" height="70" clickse="&getSe()"]
[s]

*no
[return]

*yes
[eval exp="sf.system.skip.tutorial = true"]
[return]
