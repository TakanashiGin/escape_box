[plugin name="time_out"]
[time_out name="test1" time="3000" target="test1"]
[time_out name="test2" time="4000" target="test2"]
[time_out name="test3" time="5000" target="test3"]
[s]

*test1
[eval exp="console.log('test1')"]
[s]

*test2
[eval exp="console.log('test2')"]
[clear_time_out name="test3"]
[s]

*test3
[eval exp="console.log('test3')"]
[s]