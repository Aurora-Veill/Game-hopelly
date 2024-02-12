extends State

func Enter():
	entity = get_parent().entity
	var level = entity.get_parent()
	level.enemy_death()
	entity.anim.play("Death_ani")
