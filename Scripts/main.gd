extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var dialogue: Label = $UI/Dialogue
@onready var crowd_container: Node2D = $CrowdContainer
@onready var trigger_container_2: Node2D = $TriggerContainer2
@onready var trigger_container_3: Node2D = $TriggerContainer3
@onready var trigger_container_4: Node2D = $TriggerContainer4


var index := 0
var instruction_state = false

var tutorial_notes = [
	[686.093, "hold"],
	[555.3496, "hold"],
	[443.8243, "single"],
	[417.6556, "single"],
	[379.197, "hold"],
	[336.678, "hold"],
	[292.4398, "hold"],
	[248.6164, "hold"],
	[-15.56244, "hold"],
	[-147.089, "hold"],
	[-258.0803, "single"],
	[-282.9166, "single"],
	[-321.9033, "hold"],
	[-409.4634, "hold"],
	[-497.439, "hold"],
	[-584.8425, "hold"],
	[-628.3086, "hold"],
	[-673.0007, "hold"],
	[-716.2715, "hold"],
	[-760.4435, "hold"],
	[-804.3832, "hold"],
	[-848.1923, "hold"],
	[-892.2803, "hold"],
	[-974.1055, "single"]
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue.text = "Press right arrow button to start"

	create_trigger(trigger_container_2, 1, 0, 100, 1)
	create_trigger(trigger_container_3, 2, 0, 100, 50)
	
func _process(delta: float) -> void:
	if index <= 36 and not instruction_state:
		if Input.is_action_just_pressed("ui_right"):
			play_dialogue()
	
	if index <= 36 and instruction_state:
		if Input.is_action_just_released("ui_accept"):
			await get_tree().create_timer(2).timeout
			play_dialogue()
			instruction_state = false
		
	if index in [3, 23] and not instruction_state:
		instruction_state = true
		
	if index == 7 and not instruction_state:
		instruction_state = true
		crowd_visible()
		await get_tree().create_timer(2).timeout
		play_dialogue()
		instruction_state = false
		
	if index in [13, 17, 20] and not instruction_state:
		trigger_container_2.position = Vector2.ZERO
		start(trigger_container_2, Vector2(-350, 100), Vector2(350, 100), 1.5)
		
		instruction_state = true
		await get_tree().create_timer(2).timeout
	
	if index in[27,30,32] and not instruction_state:
		trigger_container_3.position = Vector2.ZERO
		
		start(trigger_container_3, Vector2(-600, 100), Vector2(600, 100), 5)
		
		instruction_state = true
		await get_tree().create_timer(5).timeout
	
	if index == 37 and not instruction_state:
		instruction_state = true
		play_dialogue()
		await get_tree().create_timer(1).timeout
		challange()
		

func play_dialogue():
	var dialogues = [
		"Welcome!", #1
		"This game is very simple.", #2
		"You just need to press the spacebar.", #3
		"Easy, right?", #4
		"Now, let me explain a bit about timing.", #5
		"But first… we need a crowd to help!", #6
		"Alright, let’s bring them in.",# 7
		"There we go!", #8
		"The crowd will cheer with you—kind of like making waves.",#9
		"Watch their movement.",#10
		"Try to sync with them.", #11
		"Ready?", #12
		"Go!", #13
		"Hmm… not quite.", #14
		"Try again!", #15
		"Ready?", #16
		"Go!", #17
		"One more time!", #18
		"Ready?", #19
		"Go!", #20
		"You’re getting the hang of it!", #21
		"Let's move to the next steps.",
		"Try holding the spacebar.",
		"That’s how you do a banzai!",
		"Let’s practice it.",
		"Ready?",
		"GO!", #27
		"Whenever you ready, press the rigth arrow button",
		"Ready?",
		"GOO!", #30
		"Ready?",
		"GOOO!",
		"Alright, let’s play the real game now.",
		"Remember, your goal is to making waves",
		"Ready?",
		"Set…",
		"Go!",
		"",
		""
	]
	
	dialogue.text = dialogues[index]
	
	print(index)
	index += 1

func crowd_visible():
	var crowd = crowd_container.get_children()
	
	for i in crowd:
		i.visible = true
		await get_tree().create_timer(0.1).timeout

func start(container, point_a, point_b, duration):
	container.position += point_a
	var tween = create_tween()
	tween.tween_property(container, "position", point_b, duration).set_trans(Tween.TRANS_LINEAR)

func create_trigger(container, value, x_position, y_position, x_scale):
	var trigger_scene = load("res://Scenes/trigger.tscn")
	var trigger = trigger_scene.instantiate()
	
	trigger.value = value
	trigger.position = Vector2(x_position, y_position)
	trigger.scale = Vector2(x_scale, 1)
	
	container.add_child(trigger)
	return trigger
	
func challange():
	for i in tutorial_notes:
		if i[1] == "single":
			create_trigger(trigger_container_4, 1, i[0], 200, 1)
		else:
			if i[0] in [379.197, 336.678, 292.4398, 248.6164, -584.8425, -628.3086, -673.0007, -716.2715, -760.4435, -804.3832, -848.1923]:
				create_trigger(trigger_container_4, 2, i[0] - 15, 200, 3)
			elif i[0] in [-321.9033, -409.4634, -497.439]:
				create_trigger(trigger_container_4, 2, i[0] - 15, 200, 5)
			else:
				create_trigger(trigger_container_4, 2, i[0] - 40, 200, 8)
	start(trigger_container_4, Vector2(-1000,0), Vector2(1000,0), 176)
	audio_stream_player.stream = load("res://Audio/tutorial.mp3")
	audio_stream_player.play()
	await get_tree().create_timer(180).timeout
	get_tree().change_scene_to_file("res://Scenes/end.tscn")
