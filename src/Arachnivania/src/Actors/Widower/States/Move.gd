extends State
"""
Parent class that abstracts and handles basic movement
Defines some base movement and stores shared propeties that are shared
and can be accessed by the child movement states.
Children move states can delegate movement to it, or use its utility function
"""

#Exported variables that can be configured
export var max_speed_default: = Vector2(135.0, 230.0)
export var acceleration_default: = Vector2(50000.0, 1500.0)
export var max_speed_fall: = 1500.0

#Public properties that the states can manipulate
var acceleration: = acceleration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO

#adding a transition to the air state when input is detected
func unhandled_input(event: InputEvent) -> void:
	if owner.is_on_floor() and event.is_action_pressed("jump"):
		_state_machine.transition_to("Move/Air", { impulse = true})

#default physics_process from that will be defined by movement states
#owner calls the parent node
func physics_process(delta: float) -> void:
	velocity = calculate_velocity(
		velocity, max_speed, acceleration, delta, get_move_direction()
	)
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)
	#signal for the CameraRig
	Events.emit_signal("player_moved", owner)

#static functions are for calulations and do not have access to other members of the class
static func calculate_velocity(
		old_velocity: Vector2,
		max_speed: Vector2,
		acceleration: Vector2,
		delta: float,
		move_direction: Vector2,
		max_speed_fall: = 1500.0
	) -> Vector2:
	var new_velocity: = old_velocity
	#steer towards the players intended direction
	new_velocity += move_direction * acceleration * delta
	#clamp velocity on both x and y axis
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed_fall)
	return new_velocity

#function to get movement direction and return a vector2
static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") 
		- Input.get_action_strength("move_left"),
		1.0
	)
