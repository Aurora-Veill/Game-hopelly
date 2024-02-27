class_name Projectile
extends Node2D


@export var lifetime = 1
var direction = Vector2.ZERO
@export var speed = 5
@export var dmg = 1
@export var pierce = 1
func _ready():
	set_as_top_level(true)
	var timer = $Timer
	timer.start(lifetime)
	direction = position.direction_to(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	position += direction * speed * delta * 60

func _on_timer_timeout():
	queue_free() # Replace with function body.

func _on_impact_detector_area_entered(area):
	if area.get_parent().has_method("take_dmg"):
		area.get_parent().take_dmg(self, dmg)
	pierce -= 1
	if pierce <= 0:
		queue_free()
func _on_impact_detector_body_entered(body):
	queue_free() # Replace with function body.
