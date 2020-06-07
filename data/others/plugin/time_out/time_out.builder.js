'use strict';
module.exports = class plugin_setting {
    
    constructor(TB) {
        this.TB = TB;
        this.name= TB.$.s("タイムアウトプラグイン");
        this.plugin_text= TB.$.s("バッググラウンドで動作するタイマーを設定します。指定時間が経過すると指定したKSファイル・ラベルにジャンプします。なおこのプラグインは make.ks の簡単な操作が必要となります。");
        this.plugin_img = "no_image"; 
    }
    
    triggerInstall(){}
    
    defineComponents(){
        

        var cmp = {};
        var TB = this.TB;
        

        cmp["time_out"] = {
            
            "info":{
                
                "default":true,
                "name":TB.$.s("タイマーセット"),
                "help":TB.$.s("タイマーをセット"), 
                "icon":TB.$.s("s-icon-star-full")
            },
            
            "component":{    
                name : TB.$.s("タイマーセット"),
                component_type : "Simple",
                default_view : {
                    base_img_url : "data/bgimage/",
                    icon : "s-icon-star-full",
                    icon_color : "#FFFF99",
                    category : "plugin"
                },
                
                param_view : {},

                param:{/*
                    
                    "time" : {
                        type : "Num",
                        name : "時間",
                        unit : "ﾐﾘ秒",
                        help : TB.$.s("指定時間後にジャンプします"),
                        default_val : 3000,
                        spinner : {
                            min : 0,
                            max : 9999999999,
                            step : 500
                        },
                        validate : {
                            number : true
                        }
        
                    },

                    "name" : {
                        type : "Text",
                        name : TB.$.s("タイマー名"),
                        validate : {
                            required : true,
                        },
                        onChange : function(val, component) {
                            TB.component.changeParam(component, "text", val);
                        }
                    },

                    storage : TB._pm_type["storage"],

                    target : TB._pm_type["target"]

                */}
            
            }
            
        };


        cmp["clear_time_out"] = {
            
            "info":{
                
                "default":true,
                "name":TB.$.s("タイマーリセット"),
                "help":TB.$.s("タイマーをリセット"), 
                "icon":TB.$.s("s-icon-star-full")
            },
            
            "component":{    
                name : TB.$.s("タイマーリセット"),
                component_type : "Simple",
                default_view : {
                    base_img_url : "data/bgimage/",
                    icon : "s-icon-star-full",
                    icon_color : "#FFFF99",
                    category : "plugin"
                },
                
                param_view : {},

                param:{/*
                    "name" : {
                        type : "Text",
                        name : TB.$.s("タイマー名"),
                        validate : {
                            required : true,
                        },
                        onChange : function(val, component) {
                            TB.component.changeParam(component, "text", val);
                        }
                    }
                */}
            
            }
            
        };
            
                
        return cmp;
    
        
    }
    
    test(){
        
        
    }
        
}

