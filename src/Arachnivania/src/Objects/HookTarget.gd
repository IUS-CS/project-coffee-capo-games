extends Area2D
class_name HookTarget
"""
Area2D the Hook can hook onto
If is_one_shot is true, the player can only hook onto the point once
"""
#Signal in the event the target had been hooked and from where
signal hooked_onto_from(hook_position)

#Cache the Timer dependancy
onready var timer: Timer = $Timer

#Configurable property that allows for multiple hooks before CD
export var is_one_shot: = false

#Active and Inactive colors for the target
const COLOR_ACTIVE: Color = Color(0.9375, 0.730906, 0.025635)
const COLOR_INACTIVE: Color = Color(0.515625, 0.484941, 0.4552)

#Variables with setter functions
var is_active: = true setget set_is_active
var color: = COLOR_ACTIVE setget set_color

#Connect to time onready
func _ready() -> void:
	timer.connect("timeout", self, "_on_Timer_timeout")

#Draw the canvas item on ready
func _draw() -> void:
	draw_circle(Vector2.ZERO, 12.0, color)

#Reactivate after CD timer
func _on_Timer_timeout() -> void:
	self.is_active = true

#Function that emits the signal when target has been hooked and from where
func hooked_from(hook_position: Vector2) -> void:
	self.is_active = false
	emit_signal("hooked_onto_from", hook_position)

#Setter function for is_active, changes color of target and starts CD
func set_is_active(value:bool) -> void:
	is_active = value
	self.color = COLOR_ACTIVE if is_active else COLOR_INACTIVE
	if not is_active and not is_one_shot:
		timer.start()

#Setter function for color, ques update for the canvas draw
func set_color(value:Color) -> void:
	color = value
	update()


