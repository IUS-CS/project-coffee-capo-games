extends State
"""
Manages Air movement, including jumping and landing.
You can pass a msg to this state, every key is optional:
{
	velocity: Vector2, to preseve inertia from the previos state
	impulse: float, to make the character jump
}
"""
#Configurable properties
export var acceleration_x: = 2500.0
export var jump_impulse: = 450.0
export var max_jump_count:= 2
var _jump_count: = 0

#Base interface function from state, delegates to Move
func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	if event.is_action_pressed("jump") and _jump_count < max_jump_count:
		jump()
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
		jump()

#Base interface function from state to delegate to the parent state Move
func exit() -> void:
	var move: = get_parent()
	#Resets acceleration to default on exiting move state
	move.acceleration = move.acceleration_default
	#Reset _jump_count
	_jump_count = 0
	move.exit()

#Handles jump velocity and double jump
func jump() -> void:
	var move: = get_parent()
	move.velocity += calculate_jump_velocity(jump_impulse)
	_jump_count += 1

#Returns a new velocity with a vertical impulse added it it
func calculate_jump_velocity(impulse: = 0.0) -> Vector2:
	var move: = get_parent()
	return move.calculate_velocity(
		move.velocity,
		move.max_speed,
		Vector2(0.0, impulse),
		1.0,
		Vector2.UP
	)
