extends State

#Base interface function from state, delegates to Move
func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	move.unhandled_input(event)

#Base interface function from state, defines Idle and transitions
func physics_process(delta: float) -> void:
	var move: = get_parent()
	if owner.is_on_floor() and move.get_move_direction().x != 0.0:
		_state_machine.transition_to("Move/Run")
	elif not owner.is_on_floor():
		_state_machine.transition_to("Move/Air")
	

#Base interface function from state to delegate to the parent state Move
func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(msg)
	move.max_speed = move.max_speed_default
	move.velocity = Vector2.ZERO

#Base interface function from state to exit state
func exit() -> void:
	var move: = get_parent()
	move.exit()
