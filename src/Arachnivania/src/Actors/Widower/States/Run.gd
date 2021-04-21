extends State
"""
Horizontal movement on the ground.
Delegates movement to its parent Move state and extends it
with state transitions
"""
export var max_speed_sprint: = 243.0

var on_floor: bool = true

#Base interface function from state, delegates to Move
func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	move.unhandled_input(event)

#Base interface function from state, defines Run and transitions
func physics_process(delta: float) -> void:
	var move: = get_parent()
	#Set max_speed based on whether sprint is pressed or not
	if Input.is_action_pressed("sprint"):
		move.max_speed.x = max_speed_sprint
	else:
		move.max_speed.x = move.max_speed_default.x
	#Transitions to other states based on direction and position
	on_floor = owner.is_on_floor()
	if owner.is_on_floor() and move.get_move_direction().x == 0.0:
		_state_machine.transition_to("Move/Idle")
	elif not owner.is_on_floor():
		_state_machine.transition_to("Move/Air")
	#delegates physics process to move
	var direction = move.get_move_direction()
	if direction.x != 0.0:
		owner.animationPlayer.play("Walk")
		owner.sprite.flip_h = direction.x < 0.0
	else:
		owner.animationPlayer.play("Stand")
	move.physics_process(delta)

#Base interface function from state to delegate to the parent state Move
func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(msg)

#Base interface function from state to delegate to the parent state Move
func exit() -> void:
	var move: = get_parent()
	move.exit()
