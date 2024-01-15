extends Node2D

var data = preload("res://data.gd")
@export var enemies = 1
@export var cooldown = false
@export var endScene = "res://Level2/Level2.tscn"
@export var reward = preload("res://class__cleric.tscn")
@onready var player = $Player 
# Called when the node enters the scene tree for the first time.
func _ready():
	if cooldown:
		pass
	player.load_data()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
func spawn_reward(Reward: PackedScene):
	var sR = Reward.instantiate()
	sR.position = Vector2(500, 150)
	add_child(sR)
func change_scene():
	player.save_data()
	get_tree().change_scene_to_file(endScene)
func enemy_death():
	enemies -= 1
	if enemies == 0:
		spawn_reward(reward)
