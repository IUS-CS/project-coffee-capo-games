extends State
"""
State that allows for the firing of the hook and target detection. Reactivates
Aim state after the cool down timer
"""

#Transitions the StateMachine to the Aim state
func _on_Cooldown_timeout() -> void:
	_state_machine.transition_to("Aim")

#Allows this state to react to hooks cooldown timer and hooktargets 
func enter(msg: Dictionary = {}) -> void:
	owner.cooldown.connect("timeout", self, "_on_Cooldown_timeout")
	owner.cooldown.start()
	var target: HookTarget = owner.snap_detector.target
	owner.arrow.hook_position = target.global_position
	target.hooked_from(owner.global_position)
	owner.emit_signal("hooked_onto_target", target.global_position)

#Manually disconnects the cooldown timer
func exit() -> void:
	owner.cooldown.disconnect("timeout", self, "_on_Cooldown_timeout")
