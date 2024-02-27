extends State

@onready var timer = $Timer
func Update(delta):
	if entity.HP <= 0:
		Transitioned.emit(self, "Dead")
	if entity.anim.is_playing():
		return
	if entity.position.distance_to(entity.target.position) > get_parent().range:
		Transitioned.emit(self, "Aware")
func PhysicsUpdate(delta):
	var space = entity.get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(entity.position, entity.target.position)
	var result = space.intersect_ray(query)
	print("a")
	if timer.is_stopped():
		print("e")
		RangedAtk()
	else:
		print("i")
		Transitioned.emit(self, "Aware")
func Enter():
	entity = get_parent().entity
func RangedAtk():
	print("hi")
	timer.start(2)
	entity.anim.play("ranged_attack")
