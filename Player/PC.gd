extends CharacterBody2D

var atk0
var atk1

var className = "none"
var dashCD = 0
var atk0CD = 0
var atk1CD = 0
var atk1Buff = 0
var isInvis = false
@export var right_side = 2200
@export var bottom_side = 1200

# Called when the node enters the scene tree for the first time.
@onready var atkPos = $atkPos
@onready var Cam = $PlayerCam
@onready var hpbar = $HPbar
@onready var mana = 100
@onready var atk1Cost = 25
@onready var spd = 150
@onready var isDashing = false
@onready var HP = 100
@onready var charNav = $charNav
func _ready():
	Cam.set_limit(SIDE_LEFT, 0)
	Cam.set_limit(SIDE_TOP, 0)
	Cam.set_limit(SIDE_RIGHT, 2200)
	Cam.set_limit(SIDE_BOTTOM, 1200)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if HP <= 0:
		death()
	if Input.is_action_pressed("Dash") && dashCD == 0:
		isDashing = true
		dashCD = 30
	if dashCD > 0:
		dashCD -= 1
	if atk0CD > 0:
		atk0CD -= 1
	if atk1CD > 0:
		atk1CD -= 1
	if atk1Buff > 0:
		atk1Buff -= 1
	else:
		isInvis = false
	if dashCD < 25:
		isDashing = false
	move(delta)
	setBar()
func attack(projectile: PackedScene) -> void:
	var atk = projectile.instantiate()
	atk.position = position
	atk.look_at(get_global_mouse_position())
	atk.set_dir(get_local_mouse_position())
	add_child(atk)
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Atk0") && atk0 != null:
		if atk0CD == 0:
			atk0CD = 60
			attack(atk0)
	if event.is_action("Atk1") && atk1 != null:
		if mana >= atk1Cost && atk1CD == 0:
			mana -= atk1Cost
			atk1CD = 20
			if atk1[0] == "heal":
				HP += atk1[1]
			if atk1[0] == "invis":
				isInvis = true
				atk1Buff = atk1[1]

func load_data():
	HP = get_node("/root/Data").load_HP()
	mana = get_node("/root/Data").load_mana()
	atk0 = get_node("/root/Data").load_atk0()
	atk1 = get_node("/root/Data").load_atk1()
	className = get_node("/root/Data").load_className()
	position = get_node("/root/Data").load_pos()
#	print(HP)
#	print(mana)
#	print(atk0)
#	print(atk1)
#	print(className)
func save_data():
	HP -= 10
	mana -= 19
	get_node("/root/Data").save_data(self)
func death():
	get_node("/root/Data").clear_data()
	get_tree().change_scene_to_file("res://Level1/level.tscn")
func Player():
	pass
func move(delta):
	var movement = Vector2.ZERO
	if Input.is_action_pressed("Move Right"):
		movement.x += 1
	if Input.is_action_pressed("Move Left"):
		movement.x -= 1
	if Input.is_action_pressed("Move Down"):
		movement.y += 1
	if Input.is_action_pressed("Move Up"):
		movement.y -= 1
	movement = movement.normalized()
	if isDashing:
		movement *= 4
	velocity = movement * delta * spd * 60
	move_and_slide()
func _on_pc_hurtbox_area_entered(area):
	if area.get_parent().has_method("enemy"):
		HP -= area.get_parent().dmg # Replace with function body.
func setBar():
	hpbar.scale.x = HP*0.3
