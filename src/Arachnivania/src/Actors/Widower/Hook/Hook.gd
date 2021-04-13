extends Position2D
class_name Hook, "res://GodotAssets/Icons/icon_hook.svg"
"""
Handles whether the player can hook and the direction
"""

#Signal that passes HookTargets postion from snap detector
signal hooked_onto_target(target_global_position)

#References to Nodes that Hook state will need access to
onready var ray_cast: RayCast2D = $RayCast2D
onready var arrow: Node2D = $Arrow
onready var snap_detector: Area2D = $SnapDetector
onready var cooldown: Timer = $Cooldown

#State status variable
var is_active: = true

#Asks Hook if the player can hook from one of the states
func can_hook() -> bool:
	return is_active and snap_detector.has_target() and cooldown.is_stopped()

#Gets the aim direction
func get_aim_direction() -> Vector2:
	var direction: = Vector2.ZERO
	#Could also use get_local_mouse_position.normalized()
	direction = (get_global_mouse_position() - global_position).normalized()
	return direction
