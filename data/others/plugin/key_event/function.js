/* ============================================================================
ここにはオリジナルの処理を自由に記述しても問題ありません
expに関数を記述すれば実行できます
下にサンプルをのせておきますので、参考にしてください。
関数の宣言は「var」を使うことを推奨します。
「let」「const」は再宣言が出来ないため、first.ksに帰ってきた時にエラーを吐くためです。
============================================================================ */





// 強制終了（サンプル）
var windowClose = function() {
   TYRANO.kag.ftag.startTag("close",{ask:false});
}





// 全画面モード切替え（サンプル）
var screenFull = function() {
  TYRANO.kag.stat.is_stop = true;
  TYRANO.kag.ftag.startTag("screen_full");
  TYRANO.kag.stat.is_stop = false;
}





// 画像クリック（サンプル）
var elem_event = {
  num: 0,
  click: function(){
    this.num++;
    if (this.num >= 10) {
      console.log('画像を 10 回クリックしたのでイベントを削除します');
      $('.elem').off();  // イベントを削除
      $('.elem').remove();  // 画像を削除
    } else {
      console.log('画像を ' + this.num + ' 回 右クリック');
    }
  },
  mouseover: function(){
    $('.elem').attr('src','./data/fgimage/color/col2.png');
  },
  mouseout: function() {
    $('.elem').attr('src','./data/fgimage/color/col1.png');
  }
}
