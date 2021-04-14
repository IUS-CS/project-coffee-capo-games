extends State
"""
The State of the player while in the process of hooking a hook target
"""

#Information passed from the move state
var target_global_position: = Vector2(INF, INF)
var velocity: = Vector2.ZERO

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
