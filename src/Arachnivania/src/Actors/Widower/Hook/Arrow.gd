extends Node2D

#Load dependencies
onready var head: Sprite = $Head
onready var tail: Line2D = $Tail
onready var tween: Tween = $Tween

#Load starting position of the Arrow head's pivot point, needed for tail length
onready var start_length: float = head.position.x

#Hooks position and length of tail to follow hook setter properties
var hook_position: = Vector2.ZERO setget set_hook_position
var length: = 4.0 setget set_length

#Testing the hook
#func _unhandled_input(event: InputEvent) -> void:
#	if event.is_action_pressed("hook"):
#		self.hook_position = get_global_mouse_position()

#Setter functions for hook_position and length
func set_hook_position(value: Vector2) -> void:
	hook_position = value
	var to_target: = hook_position - global_position
	self.length = to_target.length()
	rotation = to_target.angle()
	tween.interpolate_property(
		self, "length", length, start_length, 
		0.25, Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	tween.start()

func set_length(value: float) -> void:
	length = value
	#index -1 accesses the last member in the array
	tail.points[-1].x = length
	head.position.x = tail.points[-1].x + tail.position.x


