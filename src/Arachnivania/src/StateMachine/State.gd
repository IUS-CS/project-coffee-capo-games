extends Node
class_name State, "res://GodotAssets/Icons/state.svg"
"""
State interface to use in Hierachial State Machines.
The lowest leaf tries to handle callbacks, and if it can't, it delegates the 
work to its parent.
It is up to the user to call the parent state's function, e.g.
`get_parent().physics_process(delta)`
Use State as a child of a StateMachine node.
"""

#reference to the state machine this state belongs to
onready var _state_machine: = _get_state_machine(self)

#allows one state to delegate unhandled input from the state machine manually
func unhandled_input(event: InputEvent) -> void:
	return

#allows one state to delegate physics process callbacks from the state machine manually
func physics_process(delta: float) -> void:
	return

#allows states to pass data to one another
func enter(msg: Dictionary = {}) -> void:
	return

#exit the state
func exit() -> void:
	return

#a recursive method that iterates up the scene tree to find the parent
#state_machine
func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node
