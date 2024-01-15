extends CharacterBody2D

var HP;
@onready var invuln = $Invuln_Timer
@onready var sprite = $AnimFrames
@onready var anim = $AnimationPlayer
var vulnerable = true
@export var target: Node2D
@export var nav: NavigationAgent2D
# Called when the node enters the scene tree for the first time.
func _ready():
	
	HP = 2
	nav.path_desired_distance = 100.0
	nav.target_desired_distance = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !target.isInvis:
		makepath()
		var vel: Vector2 = to_local(nav.get_next_path_position()).normalized()
		velocity = vel * 4000 * delta
	else:
		velocity = Vector2.ZERO
	if nav.distance_to_target() <= 100:
		pass
	move_and_slide()
func _on_hurtbox_area_entered(area):
	if vulnerable:
		take_dmg(area)
func makepath() -> void:
	nav.target_position = target.global_position
func set_movement_target(target_pos: Vector2):
	nav.target_position = target_pos
func take_dmg(area):
	HP -= 1
	if(HP <= 0):
		var level = get_parent()
		level.enemy_death()
		anim.play("Death_ani")
	var Player = area.find_parent("Player")
	if Player != null:
		Player.mana += 5
	sprite.set_frame(4)
	invuln.start(0.1)
	vulnerable = false
func _on_invuln_timer_timeout():
	sprite.set_frame(0)
	vulnerable = true
