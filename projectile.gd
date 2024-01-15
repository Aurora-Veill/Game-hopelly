class_name Projectile
extends Node2D


@export var lifetime = 60
var direction = Vector2.ZERO
@export var speed = 5
@export var dmg = 1
@export var type = "atk0"
# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	var timer = $Timer
	timer.start(lifetime / float(60))
	direction = position.direction_to(get_global_mouse_position())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * speed * delta * 60


func _on_timer_timeout():
	queue_free() # Replace with function body.

func _on_impact_detector_area_entered(_area):
	queue_free()
