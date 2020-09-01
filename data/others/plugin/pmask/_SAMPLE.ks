[plugin name="pmask"]
[bg storage="room.jpg"]
[iscript]
f.array = [
    { text:'test1<br>mask中にmaskの上にtextを表示するプラグイン', left:0, top:0 },
    { text:'test2<br>テキストはptextと同じ要領で設定', left:100, top:100 },
    { text:'test3<br>テキストはHTMLタグを使うことが出来るので<br>brタグで改行も可', left:200, top:200 },
    { text:'test4<br>テキストは文字列の代わりに配列を指定することも出来る', left:300, top:300 },
    { text:'test5<br>配列とオブジェクトを組み合わせて<br>テキストだけでなく位置や大きさを変えるなど<br>凝ったことも出来る', left:400, top:400 },
];
[endscript]
[pmask text="&f.array" size="30" align="left" width="1280" auto_change="true" auto_change_interval="5000" auto_change_random="false"]
[wait time="&5000*5"]
[pmask_off]
[s]
