extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_animating = false
var hold_time := 0.0

const HOLD_THRESHOLD := 1 

func _ready() -> void:
	animated_sprite_2d.play("idle")
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_animating == false:
		hold_time = 0
		animated_sprite_2d.play("wey")
		
	if Input.is_action_pressed("ui_accept"):
		hold_time += delta
		if hold_time > HOLD_THRESHOLD:
			animated_sprite_2d.play("hold")
			
	if Input.is_action_just_released("ui_accept"):
		if hold_time > HOLD_THRESHOLD:
			animated_sprite_2d.play("hands_down")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play("idle")

func add_points():
	Global.points += 1
	print(Global.points)
