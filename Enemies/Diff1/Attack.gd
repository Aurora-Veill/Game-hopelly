extends State

func Update(delta):
	if entity.HP <= 0:
		Transitioned.emit(self, "Dead")
	if entity.anim.is_playing():
		return
	if entity.position.distance_to(entity.target.position) > get_parent().atkRange:
		Transitioned.emit(self, "Aware")
func PhysicsUpdate(delta):
	entity.anim.play("attack")
func Enter():
	entity = get_parent().entity
