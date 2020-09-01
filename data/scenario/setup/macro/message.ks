[macro name="show_message"]
    [layopt layer="message0" visible="true"]
    [position layer="message0" page="fore" left="20" top="400" width="840" height="300"]
    [position layer="message0" page="fore" marginl="10" margint="60" marginr="10" marginb="10"]
    [position layer="message0" page="fore" frame="none" opacity="200"]
    [ptext name="chara_name_area" layer="message0" color="white" size=28 bold=true x="40" y="420"]
    [chara_config ptext="chara_name_area"]
[endmacro]
[macro name="hide_message"]
    [layopt layer="message0" visible="false"]
[endmacro]

[macro name="show_system_button"]
    [eval exp="$.showSystemButton()"]
[endmacro]
[macro name="hide_system_button"]
    [eval exp="$.hideSystemButton()"]
[endmacro]

[return]
