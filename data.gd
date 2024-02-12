extends Node
class_name Player_Data
var HP = 100
var mana = 100
var atk0
var atk1
var className = "none"
var coords = Vector2(200, 200)
func save_data(player: Node2D):
	HP = player.HP
#	print(HP)
	mana = player.mana
#	print(mana)
	atk0 = player.atk0
#	print(atk0)
	atk1 = player.atk1
#	print(atk1)
	className = player.className
#	print(className)
	coords = player.position
func load_HP():
	return HP
func load_mana():
	return mana
func load_atk0():
	return atk0
func load_atk1():
	return atk1
func load_className():
	return className
func load_pos():
	return coords
