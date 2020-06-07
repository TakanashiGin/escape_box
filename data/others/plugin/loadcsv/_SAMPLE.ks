
; プラグイン読み込み
[plugin name="loadcsv"]

; csv読み込み
[loadcsv]
;src="plugin/loadcsv/_SAMPLE.csv" log="true"]

[nowait]
読み込んだCSVデータ[r][r]
[emb exp="tf.loaded_csv[0]"][r]
[emb exp="tf.loaded_csv[1]"][r]
[emb exp="tf.loaded_csv[2]"][r]
[emb exp="tf.loaded_csv[3]"]
[endnowait]
[s]




; ---------------------------------------------------------------------------------------
;
; [loadcsv_xmlhttp]
;
  [loadcsv_xmlhttp src="plugin/loadcsv/_SAMPLE.csv" log="true"]
;
; 指定できるパラメーターは[loadcsv]と同じです
; XMLHttpRequestが近いうちに廃止らしいので、このタグは非推奨（でもしばらくはこれでもいける）
;
; [Deprecation] Synchronous XMLHttpRequest on the main thread is deprecated because of its detrimental effects to the end user's experience. For more help, check https://xhr.spec.whatwg.org/.
; →[非推奨]メインスレッドでの同期XMLHttpRequestは、エンドユーザーのエクスペリエンスに悪影響を与えるため非推奨です。さらにヘルプが必要な場合は、https：//xhr.spec.whatwg.org/を確認してください。
;
; ↑ コンソールにこれが出ても無視でOK
;
; --------------------------------------------------------------------------------------
