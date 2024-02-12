extends State
var move_direction : Vector2 = Vector2.ZERO
var wander_time : float
func Update(delta):
	if entity.position.distance_to(entity.target.position) < 500 and !entity.target.isInvis:
		Transitioned.emit(self, "Aware")
	elif entity.HP <= 0:
		var level = entity.get_parent()
		level.enemy_death()
		Transitioned.emit(self, "Dead")
		entity.anim.play("Death_ani")
	else:
		if wander_time > 0:
			wander_time -= delta
		else:
			randomize_wander()
func PhysicsUpdate(delta):
	entity.velocity = move_direction * delta * 4000
	entity.move_and_slide()
func randomize_wander():
	move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wander_time = randf_range(0,1.5)
func Enter():
	entity = get_parent().entity
	randomize_wander()
