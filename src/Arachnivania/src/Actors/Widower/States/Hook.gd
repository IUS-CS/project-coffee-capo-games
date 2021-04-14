extends State
"""
The State of the player while in the process of hooking a hook target
"""

#Variables to describe the motion of the hook
export var hook_max_speed: = 243.0
export var arrive_push: = 230.0


#Information passed from the move state
var target_global_position: = Vector2(INF, INF)
var velocity: = Vector2.ZERO

#Physics process function where all movement takes place, uses `Steering`
#autoload
func physics_process(delta: float) -> void:
	velocity = Steering.arrive_to(
		velocity,
		owner.global_position,
		target_global_position,
		hook_max_speed
	)
	#Make sure player doesnt slow down after reaching hook target
	velocity = velocity if velocity.length() > arrive_push else velocity.normalized() * arrive_push
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)
	#signal for camera
	Events.emit_signal("player_moved", owner)
	#calculate distance to target
	var to_target: Vector2 = target_global_position - owner.global_position
	var distance: = to_target.length()
	#Transition to `Air` state
	if distance < velocity.length() * delta:
		velocity = velocity.normalized() * arrive_push
		_state_machine.transition_to("Move/Air", {velocity = velocity})
	

#Enter function that will retrieve the information from Dictionary
func enter(msg: Dictionary = {}) -> void:
	match msg:
		{"target_global_position": var tgp, "velocity": var v}:
			target_global_position = tgp
			velocity  = v

#Exit function and reset values
func exit() -> void:
	target_global_position = Vector2(INF, INF)
	velocity = Vector2.ZERO
