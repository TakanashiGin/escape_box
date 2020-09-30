(function(){
    const sf = tyrano.plugin.kag.variable.sf;
    sf.preload = [
        "./data/bgimage/room.jpg",
        "./data/bgimage/rouka.jpg",
        "./data/bgimage/sky_day.jpg",
        "./data/bgimage/sky_night.jpg",
        "./data/bgimage/sky_sunset.jpg",
        "./data/bgimage/title.png",
        "./data/fgimage/builder.png",
        "./data/fgimage/chara/akane/angry.png",
        "./data/fgimage/chara/akane/angry_full.png",
        "./data/fgimage/chara/akane/doki.png",
        "./data/fgimage/chara/akane/doki_full.png",
        "./data/fgimage/chara/akane/happy.png",
        "./data/fgimage/chara/akane/happy_full.png",
        "./data/fgimage/chara/akane/normal.png",
        "./data/fgimage/chara/akane/normal_full.png",
        "./data/fgimage/chara/akane/sad.png",
        "./data/fgimage/chara/akane/sad_full.png",
        "./data/fgimage/chara/yamato/angry.png",
        "./data/fgimage/chara/yamato/happy.png",
        "./data/fgimage/chara/yamato/normal.png",
        "./data/fgimage/chara/yamato/sad.png",
        "./data/fgimage/chara/yamato/tohoho.png",
        "./data/fgimage/color/akane.png",
        "./data/fgimage/color/black.png",
        "./data/fgimage/color/black2.png",
        "./data/fgimage/color/black3.png",
        "./data/fgimage/color/clear.PNG",
        "./data/fgimage/color/col1.png",
        "./data/fgimage/color/col2.png",
        "./data/fgimage/color/col3.png",
        "./data/fgimage/color/col4.png",
        "./data/fgimage/color/col5.png",
        "./data/fgimage/color/col6.png",
        "./data/fgimage/color/dark_black.png",
        "./data/fgimage/color/empty.png",
        "./data/fgimage/color/gray.png",
        "./data/fgimage/color/pink.png",
        "./data/fgimage/color/red.png",
        "./data/fgimage/color/red2.png",
        "./data/fgimage/color/white.png",
        "./data/fgimage/color/white2.png",
        "./data/fgimage/color/yamato.png",
        "./data/fgimage/color/yellow.png",
        "./data/fgimage/color/yellow2.png",
        "./data/fgimage/parts/body_back.png",
        "./data/fgimage/parts/body_front.png",
        "./data/fgimage/parts/eye_close.png",
        "./data/fgimage/parts/eye_normal.png",
        "./data/fgimage/parts/face_back.png",
        "./data/fgimage/parts/face_front.png",
        "./data/fgimage/parts/hair_back.png",
        "./data/fgimage/parts/hair_front.png",
        "./data/fgimage/parts/head.png",
        "./data/image/back_title.png",
        "./data/image/back_title2.png",
        "./data/image/down.png",
        "./data/image/down_sub.png",
        "./data/image/ExQuestion.png",
        "./data/image/frame.png",
        "./data/image/left.png",
        "./data/image/left_sub.png",
        "./data/image/right.png",
        "./data/image/right_sub.png",
        "./data/image/up.png",
        "./data/image/up_sub.png",
        "./data/image/config/bg_config.jpg",
        "./data/image/config/arrow_next.png",
        "./data/image/config/arrow_prev.png",
        "./data/image/config/bg_config.png",
        "./data/image/config/button_unread_off.png",
        "./data/image/config/button_unread_on.png",
        "./data/image/config/c_btn.png",
        "./data/image/config/c_btn_back.png",
        "./data/image/config/c_btn_back2.png",
        "./data/image/config/c_set.png",
        "./data/image/config/c_skipoff.png",
        "./data/image/config/c_skipon.png",
        "./data/image/config/c_uts_off.png",
        "./data/image/config/c_uts_on.png",
        "./data/image/config/label_cg.png",
        "./data/image/config/label_config.png",
        "./data/image/config/label_recollection.png",
        "./data/image/config/menu_button_close.png",
        "./data/image/config/menu_button_close2.png",
        "./data/image/config/message_box.png",
        "./data/others/3d/sprite/akane.png",
        "./data/others/3d/sprite/_akane.png",
        "./data/others/3d/texture/door.jpg",
        "./data/others/3d/texture/park.jpg",
        "./data/others/3d/texture/room.jpg",
        "./data/others/3d/texture/_base.jpg",
        "./data/others/3d/texture/base_day.png",
        "./data/others/3d/texture/base_night.png",
        "./data/others/3d/texture/base_sunset.png",
        "./data/others/3d/texture/hint.png",
        "./data/others/3d/texture/kabe.PNG",
        "./data/others/3d/texture/kabe2.PNG",
        "./data/others/3d/texture/tenjo.PNG",
        "./data/others/3d/texture/box_0/hint.png",
        "./data/others/3d/texture/box_1/box_1.jpg",
        "./data/others/3d/texture/box_1/box_2.jpg",
        "./data/others/3d/texture/box_1/box_3.jpg",
        "./data/others/3d/texture/box_1/table.jpg",
        "./data/others/3d/texture/box_1/black.png",
        "./data/others/3d/texture/box_2/bar.jpg",
        "./data/others/3d/texture/box_2/table.jpg",
        "./data/others/3d/texture/box_2/bar.png",
        "./data/others/3d/texture/box_2/hint_b.png",
        "./data/others/3d/texture/box_2/hint_r.png",
        "./data/others/3d/texture/box_2/hint_y.png",
        "./data/others/3d/texture/box_2/scissors.png",
        "./data/others/3d/texture/box_3/black.jpg",
        "./data/others/3d/texture/box_3/blue.jpg",
        "./data/others/3d/texture/box_3/red.jpg",
        "./data/others/3d/texture/box_3/table.jpg",
        "./data/others/3d/texture/box_3/hammer_item.png",
        "./data/others/3d/texture/box_4/balance_1.jpg",
        "./data/others/3d/texture/box_4/balance_2.jpg",
        "./data/others/3d/texture/box_4/box_.jpg",
        "./data/others/3d/texture/box_4/box_1.jpg",
        "./data/others/3d/texture/box_4/box_2.jpg",
        "./data/others/3d/texture/box_4/box_3.jpg",
        "./data/others/3d/texture/box_4/box_4.jpg",
        "./data/others/3d/texture/box_4/box_5.jpg",
        "./data/others/3d/texture/box_4/table.jpg",
        "./data/others/3d/texture/box_4/hint_1.png",
        "./data/others/3d/texture/box_4/hint_2.png",
        "./data/others/3d/texture/box_4/hint_3.png",
        "./data/others/3d/texture/box_4/hint_4.png",
        "./data/others/3d/texture/box_5/arrow.png",
        "./data/others/3d/texture/num/0.png",
        "./data/others/3d/texture/num/1.png",
        "./data/others/3d/texture/num/2.png",
        "./data/others/3d/texture/num/3.png",
        "./data/others/3d/texture/num/4.png",
        "./data/others/3d/texture/num/5.png",
        "./data/others/3d/texture/num/6.png",
        "./data/others/3d/texture/num/7.png",
        "./data/others/3d/texture/num/8.png",
        "./data/others/3d/texture/num/9.png",
        "./data/others/3d/texture/num/back.png",
        "./data/others/3d/texture/num/num.png",
        "./data/others/3d/texture/num/num0.png",
        "./data/others/3d/texture/num/num1.png",
        "./data/others/3d/texture/num/num2.png",
        "./data/others/3d/texture/num/num3.png",
        "./data/others/3d/texture/num/num4.png",
        "./data/others/3d/texture/num/num5.png",
        "./data/others/3d/texture/num/num6.png",
        "./data/others/3d/texture/num/num7.png",
        "./data/others/3d/texture/num/num8.png",
        "./data/others/3d/texture/num/num9.png",
        "./data/others/3d/texture/num/ok.png",
        "./tyrano/images/system/bg_config.jpg",
        "./tyrano/images/system/arrow_down.png",
        "./tyrano/images/system/arrow_next.png",
        "./tyrano/images/system/arrow_prev.png",
        "./tyrano/images/system/arrow_up.png",
        "./tyrano/images/system/bg_base.png",
        "./tyrano/images/system/button_menu.png",
        "./tyrano/images/system/label_backlog.png",
        "./tyrano/images/system/label_cg.png",
        "./tyrano/images/system/label_cgmode.png",
        "./tyrano/images/system/label_config.png",
        "./tyrano/images/system/label_load.png",
        "./tyrano/images/system/label_menu.png",
        "./tyrano/images/system/label_recollection.png",
        "./tyrano/images/system/label_save.png",
        "./tyrano/images/system/menu_button_close.png",
        "./tyrano/images/system/menu_button_close2.png",
        "./tyrano/images/system/menu_button_load.png",
        "./tyrano/images/system/menu_button_load2.png",
        "./tyrano/images/system/menu_button_save.png",
        "./tyrano/images/system/menu_button_save2.png",
        "./tyrano/images/system/menu_button_skip.png",
        "./tyrano/images/system/menu_button_skip2.png",
        "./tyrano/images/system/menu_button_title.png",
        "./tyrano/images/system/menu_button_title2.png",
        "./tyrano/images/system/menu_message_close.png",
        "./tyrano/images/system/menu_message_close2.png",
        "./tyrano/images/system/noimage.png",
        "./tyrano/images/system/saveslot.png",
        "./tyrano/images/system/saveslot1.png",
        "./tyrano/images/system/saveslot2.png",
        "./tyrano/images/system/thumbnail.png",
        "./tyrano/images/system/thumbnail_save.png",
        "./tyrano/images/system/transparent.png",
    ];
    for (let type in sf.media_files) {
        const folder = type=='se'? 'sound' : type=="movie"? 'video' : 'bgm';
        sf.media_files[type].forEach(name => sf.preload.push(`./data/${folder}/${getMediaFile(type, name)}`));
    }
    //$.log(sf.preload);
}());
