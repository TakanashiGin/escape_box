var _vchat_log_count=0;tyrano.plugin.kag.tag.vchat_in={vital:[],pm:{},start:function(a){this.kag.layer.hideEventLayer();var t=this.kag.stat.current_layer,r=this.kag.stat.current_page,e=this.kag.layer.getLayer(t,r);e.css("display","none"),e.css("left",-1e5),(n=$("#vchat_base")).find(".current_vchat").addClass("talked_vchat").removeClass("current_vchat");var c=$('        <div style="right: 0px; margin-right: 5px;" class="vchat current_vchat ">            <div class="v_chat_text vchat-text" style="margin-top: 0px; margin-right: 5px; margin-left: 20px; background-color: rgb(255, 255, 255);">                <h3 class="ribbon20 vchat_chara_name"></h3>                <p class="vchat-text-inner" ></p>            </div>        </div>        ');c.hide();var n,s=c.find(".vchat-text-inner");return s.css({color:"black","font-weight":"normal","font-size":"2em",margin:"1em","line-height":"1.5em"}),s.css("margin-top",30),c.find(".vchat_chara_name").css({"font-size":"1.8em"}),(n=$("#vchat_base")).prepend(c),n.scrollTop(0),++_vchat_log_count>this.kag.stat.vchat.max_log_count&&$("#vchat_base").find(".vchat:eq(-1)").remove(),this.kag.layer.showEventLayer(),!1}},tyrano.plugin.kag.tag.vchat_config={vital:[],pm:{chara_name_color:""},start:function(a){""!=a.chara_name_color&&(this.kag.stat.vchat.chara_name_color=a.chara_name_color),this.kag.ftag.nextOrder()}},tyrano.plugin.kag.tag.vchat_chara={vital:["name"],pm:{name:"",color:""},start:function(a){if(this.kag.stat.vchat.is_active){var t=this.kag.stat.vchat.charas;t[a.name]||(t[a.name]={color:""}),""!=a.color&&(t[a.name].color=a.color),this.kag.ftag.nextOrder()}else this.kag.ftag.nextOrder()}};
