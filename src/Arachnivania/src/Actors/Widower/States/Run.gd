extends State

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 3aa1ee9... Run State
#Base interface function from state, delegates to Move
func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	move.unhandled_input(event)

#Base interface function from state, defines Run and transitions
func physics_process(delta: float) -> void:
	var move: = get_parent()
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
	#Transitions to other states based on direction and position
=======
>>>>>>> 3aa1ee9... Run State
=======
	#Transitions to other states based on direction and position
>>>>>>> f351235... Added Air state and tweaked movement
=======
>>>>>>> 3aa1ee9... Run State
=======
	#Transitions to other states based on direction and position
>>>>>>> f351235... Added Air state and tweaked movement
	if owner.is_on_floor() and move.get_move_direction().x == 0.0:
		_state_machine.transition_to("Move/Idle")
	elif not owner.is_on_floor():
		_state_machine.transition_to("Move/Air")
<<<<<<< HEAD
<<<<<<< HEAD
	#delegates physics process to move
=======
>>>>>>> 3aa1ee9... Run State
=======
	#delegates physics process to move
>>>>>>> f351235... Added Air state and tweaked movement
	move.physics_process(delta)

#Base interface function from state to delegate to the parent state Move
func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(msg)

#Base interface function from state to delegate to the parent state Move
func exit() -> void:
	var move: = get_parent()
	move.exit()
<<<<<<< HEAD
=======
>>>>>>> 95667ce... Building Player.tscn and Player.gd script
=======
>>>>>>> 3aa1ee9... Run State
