========== ========== ========== ==========
     ページめくりプラグイン
========== ========== ========== ==========

【最終更新日】2020/05/16
【  名  称  】ページめくりプラグイン
【  種  別  】ティラノスクリプト用の外部プラグイン
【 製 作 者 】小鳥遊銀（たかなし ぎん）
【 開発環境 】64bit版Windows10, ティラノスクリプトv502a, ティラノスタジオv101
【 動作環境 】上記開発環境にて確認
【 連 絡 先 】Twitterまでどうぞ（@diyin_near_j）
【ライセンス】MIT

---------- ----------



◇ 概要 ◇

複数の画像を用意し、本のページをめくるように表示画像を変更するプラグインです。
BookBlockというjQueryプラグインを使用しており、導入方法が通常のプラグインとは異なるので注意してください。

このプラグインを導入すると、
・[turn_page]
・[control_page]
これらタグを使えるようになります。



◇ ファイル構成 ◇

turn_page
 ├ lib
 ├ _README.txt
 ├ _SAMPLE.ks
 ├ init.ks
 └ turn_page.js



◇ 導入方法 ◇

・index.htmlでBookBlock読み込み

  <head></head>内に以下のコードをコピーしてください。

    <link rel="stylesheet" type="text/css" href="./data/others/plugin/turn_page/lib/css/bookblock.css">
    <script src="./data/others/plugin/turn_page/lib/js/modernizr.custom.js"></script>
    <script src="./data/others/plugin/turn_page/lib/js/jquerypp.custom.js"></script>
    <script src="./data/others/plugin/turn_page/lib/js/jquery.bookblock.min.js"></script>

  </head>のすぐ上に記述すれば確実です。

・プラグイン読み込み

  解凍して出てきた「turn_page」フォルダを、
  「data/others/plugin/」下にコピーしてください。
  その後、first.ksに以下のタグを記述してください。

    [plugin name='turn_page']



◇ pluginタグに指定できるパラメータ ◇

-



◇ タグリファレンス ◇

◆ [turn_page] ページめくり画像表示・演出開始

    || 概要

    ページめくり演出を行う画像の表示と演出を開始します。
    ページ制御する時は[control_page]を実行してください。
    ※ [turn_page]は画面上に１つしか表示できません。
       別の[turn_page]を表示する場合は一度[turn_page]を削除してください。

    || 指定できるパラメータ

    layer: 画像を表示するレイヤーを指定してください。デフォルトでは0レイヤー。

    name: 表示される画像全てに共通するname属性を指定してください。デフォルトではturn_page_img。（ぶっちゃけ意味はない）

    storage: 表示する画像を指定してください（fgimageフォルダ内）。画像の指定はカンマ区切りで複数指定する方法と、配列で指定する方法があります。

    left: 表示される画像の横位置

    top: 表示される画像の上位置

    width: 表示される画像の幅

    height: 表示される画像の高さ

    zindex: レイヤー内での表示される画像のzindexをまとめて指定できます。

    opacity: 表示される画像の透明度を指定できます,

    orientation: 「vertical」で水平方向にめくる。「horizontal」で縦方向にめくる。

    direction: 「ltr」で左から右にめくる(left to right)。「rtl」で右から左にめくる (right to left)。

    speed: めくるスピード。デフォルトで800,

    easing: イージングを指定出来ます。(animation-timing-function)

    shadows: trueでページをめくるときも前の画像が残映として残ります。デフォルトでtrue

    shadowSides: めくる時のめくっているページが上にあるときの両側のopacityを「0.1~1」で設定できます。デフォルトで0.2

    shadowFlip: めくっている時のめくっているページの影のopacityを「0.1~1」で設定できます。デフォルトで0.1

    circular: true/falseでページが最後に来ても、次ボタンで最初につながるようにするか(ループするか)どうかを指定できます。

◆ [control_page] ページめくり制御

    || 概要

    ページをめくったり最初のページに戻ったり一番後ろのページにいったり画像を削除したりできます。
    画像を削除する場合、content属性にremoveを指定すると削除することが出来ますが、
    [free]と[freeimage]で削除することも出来ます。（その場合は必ず[clear_turn_page]を実行してください）
    その時のname属性にはturn_page_baseと指定してください。
    またアニメーションをさせる時のname属性もturn_page_baseと指定してください。

    || 指定できるパラメータ

    content: 以下を指定することでページを制御することが出来ます

              next: 次のページにすすむ
              prev: 前のページに戻る
              first: はじめのページに戻る
              last: 最後のページまでめくる
              remove: 画像を削除する

◆ [clear_turn_page] make.ks用

    || 概要

    [turn_page]は[free]で削除することが出来ますが、その場合必ず[clear_turn_page]をするか、
    ゲーム変数 f.running_turn_page を削除してください。

◆ [make_turn_page] make.ks用

    || 概要

    [turn_page]を実行した後でセーブ・ロードをした場合、
    ロード時に[turn_page]の実行は復元されません。
    そのため、その対策として make.ks に[make_turn_page]を実行してください。



◇◇◇ BookBlock License ◇◇◇

Created by Codrops

http://www.codrops.com

Please read about our license: http://tympanus.net/codrops/licensing/



◇ FAQ・既知のバグ等 ◇

-



◇ 履歴 ◇

2020/05/16 とりあえず完成
2020/05/21 [make_turn_page]と[clear_turn_page]を追加
