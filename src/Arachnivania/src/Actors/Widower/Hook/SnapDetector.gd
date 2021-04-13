extends Area2D
"""
A seperate object from the hook that will find the hooking target
"""

#References to Node dependencies
onready var hooking_hint: Position2D = $HookingHint
onready var ray_cast: RayCast2D = $RayCast2D

#Store HookTarget setter
var target: HookTarget setget set_target

#Determine if there is a target or not
func has_target() -> bool:
	return target != null

#Set_target setter function, only enables hooking_hint if there is a HookTarget
func set_target(value: HookTarget) -> void:
	target = value
	hooking_hint.visible = has_target()
	hooking_hint.global_position = target.global_position if target else \
	hooking_hint.global_position

