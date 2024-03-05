extends Node
class_name Player_Data
var HP = 100
var mana = 100
var atk0
var atk1
var className = "none"
var classLevel = 0
var coords = Vector2(200, 200)
func clear_data():
	HP = 100
	mana = 100
	atk0 = null
	atk1 = null
	className = "none"
	classLevel = 0
	coords = Vector2(200, 200)
func save_data(player: Node2D):
	HP = player.HP
#	print(HP)
	mana = player.mana
#	print(mana)
	atk0 = player.atk0
#	print(atk0)
	atk1 = player.atk1
	classLevel = player.classLevel
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
func load_classLevel():
	return classLevel
func load_pos():
	return coords
