extends Node2D

@export var base_delay := 1.0 
var timer := 0.0
var timer_duration := 0 
var triggered_times = {}

var hold_times = [
	4, 11, 16, 21, 26, 71, 75, 81, 87,
	92, 97, 100, 103, 106, 108, 114, 119,
	130, 133, 136, 139, 141, 144, 147, 150,
	154, 158, 164, 166, 169, 174, 177, 180,
	191, 196, 206, 215, 234, 250, 255, 261,
	286
]
var release_times = [
	15, 20, 73, 78, 84, 95, 110, 116,
	122, 193, 218, 252, 257
]
var single_times = [
	27, 29, 32, 35, 38, 40, 44, 48, 51,
	54, 56, 59, 62, 64, 68,
	130, 133, 136, 139, 141, 144, 147,
	150, 154, 158, 164, 166, 169, 182,
	185, 188, 206, 207, 209, 212, 215,
	217, 223, 226, 228, 231, 236, 239,
	242, 244, 247, 264, 269, 274, 280
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_child_count():
		get_child(i).delay = base_delay + (i*0.1)
	start_timer()

func start_timer():
	timer = timer_duration

func _process(delta):
	if timer < 310:
		timer += delta
		
		var t_sec = int(timer)
		
		if t_sec in single_times and not triggered_times.has(t_sec):
			triggered_times[t_sec] = true
			for i in get_child_count():
				get_child(i).animating(1)
		elif t_sec in hold_times and not triggered_times.has(t_sec):
			triggered_times[t_sec] = true
			for i in get_child_count():
				get_child(i).animating(2)
		elif t_sec in release_times and not triggered_times.has(t_sec):
			triggered_times[t_sec] = true
			for i in get_child_count():
				get_child(i).reset_animation()

		if timer >= 310:
			print("TIMER FINISHED!")
