extends CharacterBody2D
class_name EnemyBase
var navReady = false

@export var HP = 2
@export var dmg = 10
@export var spd = 4000
@onready var invuln = $Invuln_Timer
@onready var sprite = $AnimFrames
@onready var anim = $AnimationPlayer
var vulnerable = true
@export var target: Node2D
@export var projectile = preload("res://Enemies/Diff1/arrow.tscn")
@onready var nav = $NavigationAgent2D
var state = State.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("actor_setup")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func actor_setup():
	await get_tree().physics_frame
	navReady = true
	sprite.show()
func _physics_process(delta):
	if target == null:
		for child in self.get_parent().get_children():
			if child.has_method("Player"):
				target = child
#	if !target.isInvis and position.distance_to(target.position) > 50 and position.distance_to(target.position) < 500:
#		makepath()
#		var vel: Vector2 = to_local(nav.get_next_path_position()).normalized()
#		velocity = vel * 4000 * delta
#	else:
#		velocity = Vector2.ZERO
#	move_and_slide()
func ranged_attack(projectile: PackedScene):
	var atk = projectile.instantiate()
	atk.position = position
	atk.look_at(target.get_global_position())
	atk.set_dir(target.position - position)
	add_child(atk)
func set_movement_target(target_pos: Vector2):
	nav.target_position = target_pos
func take_dmg(area, dmg):
	if vulnerable:
		HP -= dmg
		if area.find_parent("Player") != null:
			area.find_parent("Player").mana += 5
		sprite.set_frame(4)
		invuln.start(0.1)
		vulnerable = false
func _on_invuln_timer_timeout():
	sprite.set_frame(0)
	vulnerable = true
func enemy():
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("Player"):
		body.HP -= dmg
