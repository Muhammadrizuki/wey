extends PointLight2D

@export var radius: float = 100
@export var speed: float = 1

var center := Vector2.ZERO 
var angle = 0

func _ready() -> void:
	center = position

func _process(delta):
	angle += speed * delta
	position = center + Vector2(
		cos(angle) * radius,
		sin(angle) * radius
		)
