extends Area2D
"""
A seperate object from the hook that will find the hooking target
"""

#References to Node dependencies
onready var hooking_hint: Position2D = $HookingHint
onready var ray_cast: RayCast2D = $RayCast2D

#Store HookTarget setter
var target: HookTarget setget set_target

#Make the ray cast top level in order to manual set detector
func _ready()-> void:
	ray_cast.set_as_toplevel(true)

#physics process to assign the best target to target_variable
func _physics_process(delta: float) -> void:
	self.target = find_best_target()

#Function to find best target to hook onto and make sure there are no
#obstacles in LoS
func find_best_target() -> HookTarget:
	var closest_target: HookTarget = null
	var targets: = get_overlapping_areas()
	for t in targets:
		if not t.is_active:
			continue
		ray_cast.global_position = global_position
		ray_cast.cast_to = t.global_position - ray_cast.global_position
		if ray_cast.is_colliding():
			continue
		closest_target = t
		break
	return closest_target

#Determine if there is a target or not
func has_target() -> bool:
	return target != null

#Set_target setter function, only enables hooking_hint if there is a HookTarget
func set_target(value: HookTarget) -> void:
	target = value
	hooking_hint.visible = has_target()
	hooking_hint.global_position = target.global_position if target else \
	hooking_hint.global_position

