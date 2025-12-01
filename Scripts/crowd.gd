extends StaticBody2D

@export var delay : float = 0.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("idle")

func animating(a):
	await get_tree().create_timer(delay).timeout
	if a == 1:
		animated_sprite_2d.play("wey")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play("idle")
	if a == 2:
		animated_sprite_2d.play("hands_up")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play("hold")

func reset_animation():
	await get_tree().create_timer(delay).timeout
	animated_sprite_2d.play("hands_down")
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play("idle")
