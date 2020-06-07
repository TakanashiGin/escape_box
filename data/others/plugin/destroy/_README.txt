========== ========== ========== ==========
     destroyプラグイン
========== ========== ========== ==========

【最終更新日】2018/01/27 04:51
【  名  称  】destroyプラグイン
【  種  別  】ティラノスクリプト用の外部プラグイン
【 製 作 者 】小鳥遊銀
【 開発環境 】64bit版Windows10, ティラノスクリプトv501c, ティラノスタジオv100
【 動作環境 】上記開発環境にて確認
【 連 絡 先 】Twitterまでどうぞ（@diyin_near_j）
【ライセンス】MIT

---------- ----------



◇ 概要 ◇

ティラノスクリプト公式のテクニックサンプル集の中でマクロ定義されている
==> [destroy]
を登録します。
テクニックサンプル集の[destroy]との違いは、
config.tjsで前景レイヤやメッセージレイヤの数を操作しても自動でそれに対応してくれる点と、
引数を渡して実行するタグを管理できる点。
つまりいちいちレイヤー数を操作するごとにマクロを書き換える手間が省けるということ。
逆に言えばそれだけ。

たぶんバグはあると思うので、バグを発見したら報告をお願いします。



◇ ファイル構成 ◇

destroy
 ├ _README.txt
 ├ _SAMPLE.ks
 ├ destroy.js（廃止）
 └ init.ks



◇ 導入方法 ◇

解凍して出てきた「destroy」フォルダを、
「data/others/plugin/」下にコピーしてください。
その後、first.ksに以下のタグを記述してください。

    [plugin name="destroy"]



◇ pluginタグに指定できるパラメータ ◇

-



◇ タグリファレンス ◇

◆ [destroy]

    || 概要

    [destroy]の仕様はテクニックサンプル集のものとほぼ同じです。

    以下と同じ動作をします。

    == [KSファイル] =========================================
    [macro name="destroy"]
      [hidemenubutton]
      [cm]
      [clearfix]
      [free_layermode time="1"]
      [free_filter]
      [reset_camera time="1"]
      [freeimage layer="XXX" time="1"]  ==> config.tjsで登録されている全てのレイヤーに対して[freeimage]を実行します。
      [layopt layer="XXX" visible="false"]  ==> config.tjsで登録されている全てのレイヤーに対して[layopt]を実行します。
    [endmacro]
    ========================================================

    また引数に「タグ名="false"」を指定することで任意のタグの実行を阻止することが出来ます。

    || 指定できるパラメータ

    hidemenubutton:  true/false, タグの実行を指定。デフォルトは"true"
                cm:  上に同じ
          clearfix:  上に同じ（layer・avoidでfixを指定しても実行されます）
    free_layermode:  上に同じ
       free_filter:  上に同じ
      reset_camera:  上に同じ
         freeimage:  上に同じ
            layopt:  上に同じ
             layer:  レイヤーを指定します。指定するとそのレイヤーのみを対象として[freeimage][layopt]を実行します。「,」で区切ることで複数選択することができます。
             avoid:  レイヤーを指定します。指定するとそのレイヤーは[freeimage][layopt]の対象になりません。「,」で区切ることで複数選択することができます。



◇ FAQ・既知のバグ等 ◇

-



◇ 履歴 ◇

2020/05/02 とりあえず作ってみた
