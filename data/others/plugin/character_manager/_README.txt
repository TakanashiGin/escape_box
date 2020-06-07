========== ========== ========== ==========
     キャラクター一括登録プラグイン
========== ========== ========== ==========

【最終更新日】2020/06/03
【  名  称  】キャラクター一括登録プラグイン
【  種  別  】ティラノスクリプト用の外部プラグイン
【 製 作 者 】小鳥遊銀（たかなし ぎん）
【 開発環境 】64bit版Windows10, ティラノスクリプトv502, ティラノスタジオv101
【 動作環境 】上記開発環境にて確認
【 連 絡 先 】Twitterまでどうぞ（@diyin_near_j）
【ライセンス】MIT

---------- ----------



◇ 概要 ◇

ティラノスクリプトで大量のキャラクターデータを扱う時、
いちいち[chara_new]や[chara_face]、[chara_layer]を記述するのが面倒なので、
それをjsonデータを使って一括で実行するプラグインを作りました。

このプラグインを導入すると [character_manager] のタグを使えるようになります。

なおこのプラグインはティラノスクリプトV4以前のバージョンでは実行出来ないので注意してください。


◇ ファイル構成 ◇

for
 ├ _NORMAL.json
 ├ _PARTS.json
 ├ _README.txt
 ├ _SAMPLE.ks
 ├ character_manager.js
 └ init.ks



◇ 導入方法 ◇

解凍して出てきた character_manager フォルダを、
data/others/plugin/ 下にコピーしてください。
その後、first.ks に以下のタグを記述してください。

    [plugin name='character_manager']

またこのプラグインでは形式に沿ったjsonデータを扱います。

このプラグインの詳しい説明はQiitaの記事でご覧ください
【URL】https://qiita.com/diyin_near_j/items/4707bac9230e93f4d27d


※ このプラグインではクラス構文を使っています。first.ksに帰る処理がある場合は

    [eval exp="if (!tf.loaded_character_manager) tf.loaded_character_manager = false"]
    [plugin name='character_manager' cond="tf.loaded_character_manager"]
    [eval exp="tf.loaded_character_manager = true"]

のように重複して読み込まないようにしてください。


◇ pluginタグに指定できるパラメータ ◇

-



◇ タグリファレンス ◇

◆ [character_manager] キャラクター一括登録

    || 概要

    jsonデータを使ってキャラクターの一括登録を行います。

    || 指定できるパラメータ

    src  【必須】読み込むjsonファイルを指定してください。jsonファイルは others フォルダ以下に配置してください。

    type  普通のキャラクターを登録する場合は normal、表情差分パーツキャラクターを登録する場合は parts を指定してください。デフォルトは normal

    var  上級者向けのパラメーターです。このプラグインではクラス構文を使用しており、インスタンスする際のティラノ変数を独自で指定することが出来ます。デフォルトは sf.character_manager

    time  jsonファイルを読み込む時間をﾐﾘ秒で指定します。秒数が短すぎると、jsonファイルが読み込まれない場合があるのでご注意ください。デフォルトは 10 [ﾐﾘ秒]


◇ FAQ・既知のバグ等 ◇

-



◇ 履歴 ◇

2020/06/03 実験版リリース
