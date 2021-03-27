extends KinematicBody2D
class_name Player

#Store references to nodes different states need to access
onready var state_machine: StateMachine = $StateMachine
onready var collider: CollisionShape2D = $CollisionShape2D

const FLOOR_NORMAL: = Vector2.UP

#Public property to toggle properties on the character
var is_active: = true setget set_is_active

#Setter function for the is_active variable
func set_is_active(value: bool) -> void:
	is_active = value
	#return if the collider has not been set yet, default values get
	#assigned during _init, which happens before _onready
	if not collider:
		return
	#turn collider on if active, disable if inactive
	collider.disabled = not value
