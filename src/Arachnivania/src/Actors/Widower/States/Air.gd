extends State
"""
Vertical and Horizontal movement in the air.
Delegates movement to its parent Move state and extends it
with state transitions
"""
#Configurable properties
export var acceleration_x: = 2500.0

#Base interface function from state, delegates to Move
func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	move.unhandled_input(event)

#Base interface function from state, defines Air and transitions
func physics_process(delta: float) -> void:
	var move: = get_parent()
	move.physics_process(delta)
	#Check position after movement has been delegated for transition
	if owner.is_on_floor() and move.get_move_direction().x == 0.0:
		_state_machine.transition_to("Move/Idle")
	elif owner.is_on_floor() and move.get_move_direction().x != 0.0:
		_state_machine.transition_to("Move/Run")

#Base interface function from state to delegate to the parent state Move
func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(msg)
	#Sets the move acceleration vector2 x to the configurable air property
	move.acceleration.x = acceleration_x
	#Preserves velocity of intended x direction after you jump
	if "velocity" in msg:
		move.velocity = msg.velocity
		move.max_speed.x = max(abs(msg.velocity.x), move.max_speed_default.x)
	#Ability to jump, using other states to tell Air the player needs to jump
	if "impulse" in msg:
		move.velocity += calculate_jump_velocity(msg.impulse)

#Base interface function from state to delegate to the parent state Move
func exit() -> void:
	var move: = get_parent()
	move.exit()
	#Resets acceleration to default on exiting move state
	move.acceleration = move.acceleration_default

func calculate_jump_velocity(impulse: = 0.0) -> Vector2:
	var move: = get_parent()
	return move.calculate_velocity(
		move.velocity,
		move.max_speed,
		Vector2(0.0, impulse),
		1.0,
		Vector2.UP
	)
