extends State
func Update(delta):
	if entity.target.isInvis or entity.position.distance_to(entity.target.position) > 1000:
		Transitioned.emit(self, "Idle")
		return
	elif entity.HP <= 0:
		Transitioned.emit(self, "Dead")
	elif entity.position.distance_to(entity.target.position) < get_parent().atkRange:
		Transitioned.emit(self, "Attack")
func PhysicsUpdate(delta):
	entity.nav.target_position = entity.target.global_position
	var vel: Vector2 = entity.to_local(entity.nav.get_next_path_position()).normalized()
	entity.velocity = vel * entity.spd * delta
	entity.move_and_slide()
func Enter():
	entity = get_parent().entity
	for child in entity.get_parent().get_children():
		if child.has_method("Player"):
			entity.target = child
