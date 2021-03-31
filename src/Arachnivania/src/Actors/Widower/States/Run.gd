extends State

#Base interface function from state, delegates to Move
func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	move.unhandled_input(event)

#Base interface function from state, defines Run and transitions
func physics_process(delta: float) -> void:
	var move: = get_parent()
	#Transitions to other states based on direction and position
	if owner.is_on_floor() and move.get_move_direction().x == 0.0:
		_state_machine.transition_to("Move/Idle")
	elif not owner.is_on_floor():
		_state_machine.transition_to("Move/Air")
	#delegates physics process to move
	move.physics_process(delta)

#Base interface function from state to delegate to the parent state Move
func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(msg)

#Base interface function from state to delegate to the parent state Move
func exit() -> void:
	var move: = get_parent()
	move.exit()
