extends Position2D
"""
Rig to move a child camera based on the player's input, to give them more forward visibility
"""

#Caches the child node
onready var camera: Camera2D = $ShakingCamera

#Adjustable properties of the camera
export var offset: = Vector2(300.0, 300.0)
export var mouse_range: = Vector2(100.0, 500.0)

#Variable for state machine
var is_active: = true

func _physics_process(delta: float) -> void:
	update_position()

#Updates the camera rig's position based on the player's state and controller position
func update_position(velocity: Vector2 = Vector2.ZERO) -> void:
	if not is_active:
		return
	var mouse_position: = get_local_mouse_position()
	var distance_ratio: = clamp(mouse_position.length(), mouse_range.x, mouse_range.y) / mouse_range.y
	camera.position = distance_ratio * mouse_position.normalized() * offset

