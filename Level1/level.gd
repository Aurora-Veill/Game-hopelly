extends Node2D

var data = preload("res://data.gd")
@export var enemies = 0
@export var enemyPos = {}
@export var enemy_diff = 1
@export var cooldown = false
@export var endScene = "res://level_3.tscn"
@export var reward = preload("res://class__cleric.tscn")
@onready var player = $Player 
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/LevelData").randomizeSeed()
	if cooldown:
		pass
	player.load_data()
	spawnEnemies()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
func spawn_reward():
	var sR = reward.instantiate()
	sR.position = (Vector2(randf_range(-2,2), randf_range(-2,2))*100)+player.position
	player.charNav.target_position = sR.position
	add_child(sR)
	if !player.charNav.is_target_reachable():
		sR.queue_free()
		spawn_reward()
func change_scene():
	player.save_data()
	get_tree().change_scene_to_file(endScene)
func enemy_death():
	enemies -= 1
	if enemies == 0:
		call_deferred("spawn_reward")
func spawnEnemies():
	for i in range(enemies):
		makeEnemy(load(get_node("/root/LevelData").getRanEnem(enemy_diff)))
func makeEnemy(enemy : PackedScene):
	var enem = enemy.instantiate()
	print(enem)
	player.position = Vector2(880, 220)
	enem.position = enemyPos[(randi() % enemyPos.size())]
	add_child(enem)
