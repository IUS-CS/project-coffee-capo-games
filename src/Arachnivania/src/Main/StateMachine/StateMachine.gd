extends Node
class_name StateMachine, "res://GodotAssets/Icons/state_machine.svg"
"""
Generic State Machine. Initializes states and delgates engine callbacks
(_physics_process, _unhandled_input) to the active state.
"""

#allows the setting of an initial state from the inspector
export var initial_state: = NodePath()

#active state variable that starts as the initial state and uses a setter to change
onready var state: State = get_node(initial_state) setget set_state
#allows for printing of state name for debugging
onready var _state_name: = state.name

#added to the state_machine group before its added to the scene
#this is used in the state interface to fine the state machine
func _init() -> void:
	add_to_group("state_machine")

#waits for the owner node of the state machine to emit a ready signal before entering the initial state 
func _ready() -> void:
	yield(owner, "ready")
	state.enter()

#callbacks that are delgated to the state
func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)

#callbacks that are delgated to the state
func _physics_process(delta: float) -> void:
	state.physics_process(delta)

#take a target state path (node path) from state machine to the state
#and a message dictionary that the state is going to pass through the transition
#that will be recieved on the enter() function
func transition_to(target_state_path: String, msg: Dictionary= {}) -> void:
	#safeguard incase state path does not exist
	if not has_node(target_state_path):
		return
	var target_state: = get_node(target_state_path)
	#exit previous state
	state.exit()
	#set target to current state
	self.state = target_state
	#enter state with msg
	state.enter(msg)

#setter function for state variable and state name
func set_state(value: State) -> void:
	state = value
	_state_name = value.name
