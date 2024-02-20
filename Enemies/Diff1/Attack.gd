extends State

func Update(delta):
	if entity.HP <= 0:
		Transitioned.emit(self, "Dead")
	if entity.anim.is_playing():
		return
	if entity.target.isInvis or entity.position.distance_to(entity.target.position) > 500:
		Transitioned.emit(self, "Idle")
		return
	elif entity.position.distance_to(entity.target.position) > 50:
		Transitioned.emit(self, "Aware")
func PhysicsUpdate(delta):
	entity.anim.play("attack")
func Enter():
	entity = get_parent().entity
