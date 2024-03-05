extends State

@onready var timer = $Timer
var off_cd = true
func Update(delta):
	if entity.HP <= 0:
		Transitioned.emit(self, "Dead")
	if entity.anim.is_playing():
		return
	if entity.position.distance_to(entity.target.position) > get_parent().atkRange:
		Transitioned.emit(self, "Aware")
func PhysicsUpdate(delta):
	var space = entity.get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(entity.position, entity.target.position)
	var result = space.intersect_ray(query)
	if off_cd:
		print("e")
		RangedAtk()
	else:
		Transitioned.emit(self, "Aware")
func Enter():
	entity = get_parent().entity
func RangedAtk():
	timer.start(2)
	off_cd = false
	entity.anim.play("ranged_attack")


func _on_timer_timeout():
	off_cd = true
