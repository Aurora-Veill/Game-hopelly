extends Node2D

@export var className = "N/A"
@export var atk0 = preload("res://Player/beam.tscn")
@export var atk1 = ["heal", 30]
var isIn = false
var player := Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isIn:
		get_node("Explainer").show()
	else:
		get_node("Explainer").hide()
	if Input.is_action_pressed("Collect") and isIn:
		player.className = className
		player.atk0 = atk0
		player.atk1 = atk1
		var level = get_parent()
		level.change_scene()
		queue_free()

func _on_collection_trigger_body_entered(body):
	if body.has_method("Player"):
		player = body
		isIn = true

func _on_collection_trigger_body_exited(body):
	if body.has_method("Player"):
		isIn = false

