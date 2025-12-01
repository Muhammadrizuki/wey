extends Node2D

@export var base_delay := 1.0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_child_count():
		get_child(i).delay = base_delay + (i*0.1)
