extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var crowd_container: Node2D = $CrowdContainer
@onready var trigger_container: Node2D = $TriggerContainer
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var point_light_2d_2: PointLight2D = $PointLight2D2
@onready var point_light_2d_3: PointLight2D = $PointLight2D3
@onready var point_light_2d_4: PointLight2D = $PointLight2D4
@onready var dialogue: Label = $UI/Dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player.stream =load("res://Audio/black.mp3")
	audio_stream_player.play()
	
	canvas_modulate.color = Color.BLACK
	await get_tree().create_timer(3).timeout
	audio_stream_player.stream =load("res://Audio/on.mp3")
	audio_stream_player.play()
	canvas_modulate.color = Color.DARK_SLATE_GRAY
	
	point_light_2d.visible = true
	point_light_2d_2.visible = true
	point_light_2d_3.visible = true
	point_light_2d_4.visible = true
	
	await get_tree().create_timer(2).timeout
	concert_start()

func _process(delta: float) -> void:
	pass

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

func concert_start():
	audio_stream_player.stream = load("res://Audio/concert.mp3")
	audio_stream_player.play()
	#start(trigger_container, Vector2(-50000, 0), Vector2(50000, 0), 305)
	
	await get_tree().create_timer(305).timeout
	dialogue.text = "Thanks for Playing"
	await get_tree().create_timer(3).timeout
	dialogue.text = "This song by [name here]"
	await get_tree().create_timer(3).timeout
	dialogue.text = "Hope you like it"
	await get_tree().create_timer(3).timeout
	dialogue.text = "Goodbye"
	
	
