tool
extends Node2D
"""
Colors the hooking target to communicate to the player that it is a hookable
surface
"""

#Properties
export var color: Color

#Making the node completly independent, can place and draw anywhere from parent
#making the hooking hint constant regardless of snap detector position
func _ready() -> void:
	set_as_toplevel(true)
	update()

#Draw function
func _draw() -> void:
	draw_circle(Vector2.ZERO, 5.0, color)
