extends Node2D

@export var Player: Node2D
@onready var pHP = Player.HP
@onready var pMana = Player.Mana
@onready var pManaCheck = pMana
@onready var pHPCheck = pHP
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if pHPCheck != Player.HP:
		var HPScale = Vector2(1, 1)
		HPScale.x = float(Player.HP) / float(pHP)
		get_node("HP").apply_scale(HPScale)
		pHPCheck = Player.HP
	if pManaCheck != Player.Mana:
		var ManaScale = Vector2(1, 1)
		ManaScale.x = float(Player.Mana) / float(pMana)
		get_node("MANA").apply_scale(ManaScale)
		pManaCheck = Player.Mana
