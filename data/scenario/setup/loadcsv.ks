
; image
[loadcsv var="tf.three_images" src="csv/image.csv"]

; sprite
[loadcsv var="tf.three_sprites" src="csv/sprite.csv"]

; model
[loadcsv var="tf.three_models" src="csv/model.csv"]

; box
[loadcsv var="tf.three_boxies" src="csv/box.csv" parse_flort="false"]

; itemはitem.ksで
;[loadcsv var="tf.items" src="csv/item.csv"]

; loading
[loadjs storage="../scenario/setup/loadcsv.js"]

; StageObjectManager
[loadjs storage="../scenario/setup/stage_object_manager.js"]

[return]
