extends Control

@onready var dialogue: Label = $Dialogue
@onready var instruction: Label = $Instruction
@onready var crowd_container: Node2D = $"../crowdContainer"
@onready var trigger_container: Node2D = $"../TriggerContainer"

var index := 0
var instruction_state = false

func _ready() -> void:
	dialogue.text = "Press right arrow button to start"
	crowd_visible()
	trigger_container.start()
	

func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_right") and instruction_state == false:
		#play_dialogue()
		
	if Input.is_action_just_pressed("ui_accept") and instruction_state == true:
		await get_tree().create_timer(4).timeout
		play_dialogue()
		instruction_state = false
		
	if index == 3 and instruction_state == false:
		instruction_state = true
		
	if index == 7 and instruction_state == false:
		instruction_state = true
		crowd_visible()
		await get_tree().create_timer(1).timeout
		play_dialogue()
		instruction_state = false
		
	if index == 13 or index == 17 or index == 20:
		trigger_container.start()
		
func play_dialogue():
	var dialogues = [
		"Welcome!",
		"This game is very simple",
		"You just need to press spacebar",
		"easy right?",
		"Now, let me introduce you about timing",
		"But first, we need some crowds to help",
		"But first, we need some crowds to help",
		"There we go",
		"The crowd will Wey! with you, some what try to make ",
		"Waves",
		"Try to sync with them",
		"Ready?",
		"Go!",
		"Eh, not quiet",
		"Another one",
		"Ready?",
		"Go",
		"One more time",
		"Ready",
		"Go!"
	]
	
	dialogue.text = dialogues[index]
	index += 1

func crowd_visible():
	var crowd = crowd_container.get_children()
	
	for i in crowd:
		i.visible = true
		await get_tree().create_timer(0.1).timeout
