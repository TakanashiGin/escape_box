*start

[plugin name="circle_timer"]

[layopt layer="message0" visible="false"]
[layopt layer="0" visible="true"]
[bg storage="room.jpg"]

[set_circle_timer name="test" time="50000" clear="false" target="end" left="100" top="50" rad="20" front_color="skyblue" stroke_color="black" stroke_width="0.5"]
*timer
[l]
[ctrl_circle_timer name="test" content="stop"]
[eval exp="console.log(f.circle_timer_array)"]
[l]
[ctrl_circle_timer name="test" content="start"]
[jump target="timer"]
[s]

*end
[eval exp="console.log('end')"]
[l]
[ctrl_circle_timer name="test" content="delete"]
[jump target="start"]
[s]
