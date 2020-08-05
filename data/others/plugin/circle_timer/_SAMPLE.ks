*start

[plugin name="circle_timer"]

[layopt layer="message0" visible="false"]
[layopt layer="0" visible="true"]
[bg storage="room.jpg"]

[set_circle_timer name="test" time="10000" start_time="1000" start="false" clear="false" target="end" fade_in="true" front_color="skyblue" front_graphic="../bgimage/title.jpg" stroke_color="black" stroke_width="0.5" end_color="red" end_p="80%"]

*timer
[l]
[ctrl_circle_timer name="test" content="start"]
[l]
[ctrl_circle_timer name="test" content="stop"]
[jump target="timer"]

*end
[eval exp="console.log('end')"]
[l]
[ctrl_circle_timer name="test" content="delete"]
[jump target="start"]
[s]
