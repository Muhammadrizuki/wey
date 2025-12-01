extends Area2D

@export var value := 0 

var is_player_node := false
var point_cooldown := 2.0

func _process(delta: float) -> void:
	if (value == 1 and Input.is_action_just_pressed("ui_accept")) and is_player_node:
		get_tree().call_group("Player", "add_points")
		is_player_node = false
	if value == 2 and is_player_node:
		if Input.is_action_pressed("ui_accept"):
			point_cooldown -= delta
			if point_cooldown <= 0:
				get_tree().call_group("Player", "add_points")
				point_cooldown = 1.0
		else:
			point_cooldown = 0.0

func _on_body_entered(body: Node2D) -> void:
	print("hey")
	get_tree().call_group("Crowd", "animating", value)
	is_player_node = true

func _on_body_exited(body: Node2D) -> void:
	if value == 2:
		get_tree().call_group("Crowd", "reset_animation")
	is_player_node = false
