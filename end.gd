extends Node2D

@onready var dialogue: Label = $UI/Dialogue

var index := 0
var points := Global.points

var dialogues := [
	"Wow, you Nailed it",
	"Through out some misses",
	"I think you get a big point",
	"And your point is",
	str(points),
]

var end_dialogues := [
	"That's it folks, thank you for playing",
	"Hope you enjoy it",
	"Goodbye",
]

var bonus_dialogues := [
	"WOw, thats a lot!",
	"you know what?",
	"i think youre ready for the real deal",
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_dialogue()

func start_dialogue():
	for i in dialogues.size():
		dialogue.text = dialogues[index]
		await get_tree().create_timer(3).timeout
		index += 1
		
	if points > 80:
		index = 0
		for i in bonus_dialogues.size():
			dialogue.text = bonus_dialogues[index]
			await get_tree().create_timer(3).timeout
			index += 1
		get_tree().change_scene_to_file("res://Scenes/concerto.tscn")
	else: 
		index = 0
		for i in end_dialogues.size():
			dialogue.text = end_dialogues[index]
			await get_tree().create_timer(3).timeout
			index += 1
