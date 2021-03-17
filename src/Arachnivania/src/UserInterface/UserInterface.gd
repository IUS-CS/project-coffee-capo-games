extends Control

# cache dependencies 
onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")

# uses setter function to set paused value
var paused: = false setget set_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		# call setter function or use self.paused
		# Usually implicit, in this case need to make explicit
		self.paused = not paused
		# pause input event should not propogate, so set as handled
		scene_tree.set_input_as_handled()

# setter function for paused variable
func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
