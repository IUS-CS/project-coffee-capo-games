extends State
"""
State that rotates and updates various nodes that are needed to 
detect points the player will hook onto.
"""

#Base State Interface
#Transtion to fire state when hooking happens
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hook") and owner.can_hook():
		_state_machine.transition.to("Aim/Fire")

#Base State Interface
#Creates a vector for ray cast and direction
func _physics_process(delta: float) -> void:
	var cast: Vector2 = owner.get_aim_direction() * owner.ray_cast.cast_to.length()
	var angle: = cast.angle()
	owner.ray_cast.cast_to = cast
	owner.arrow.rotation = angle
	owner.snap_detector.rotation = angle
	owner.ray_cast.force_raycast_update()
