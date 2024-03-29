extends Node2D

var data = preload("res://data.gd")
var spawnlocs = []
@export var enemies = 21
@export var enemy_diff = 1
@export var scripted = false
@export var endScene = "res://level_3.tscn"
@export var reward = preload("res://class__cleric.tscn")
@onready var player = $Player 
var spawns
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/LevelData").randomizeSeed()
	if !scripted:
		spawns = $Spawns.get_children()
		enemies = get_node("/root/LevelData").runs + 1
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
	get_node("/root/LevelData").incrementRuns()
	get_tree().change_scene_to_file(get_node("/root/LevelData").getRanLevel())
func enemy_death():
	enemies -= 1
	if enemies == 0:
		call_deferred("spawn_reward")
func spawnEnemies():
	for i in range(enemies):
		makeEnemy(load(get_node("/root/LevelData").getRanEnem(enemy_diff)))
func makeEnemy(enemy : PackedScene):
	if spawns.size() < 1:
		return
	var enem = enemy.instantiate()
	enem.position = spawns[(randi() % spawns.size())].position
	if (enemies <= spawns.size()):
		checkloc(enem)
	spawnlocs.push_back(enem.position);
	add_child(enem)
func checkloc(enem):
	for i in spawnlocs:
		if enem.position == i:
			enem.position = spawns[(randi() % spawns.size())].position
			checkloc(enem)
