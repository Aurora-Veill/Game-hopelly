extends Node
@export var atkRange = 50
@export var initialState : State
var currentState : State
var states : Dictionary = {}
var entity : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	entity = get_parent()
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initialState:
		initialState.Enter()
		currentState = initialState
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentState != null:
		currentState.Update(delta)
func _physics_process(delta):
	if currentState != null:
		currentState.PhysicsUpdate(delta)
func on_child_transition(state, newStateName):
	var newState = states.get(newStateName.to_lower())
	state.Exit()
	newState.Enter()
	currentState = newState
	
