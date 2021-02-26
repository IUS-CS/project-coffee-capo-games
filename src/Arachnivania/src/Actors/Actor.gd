extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0

var _velocity: = Vector2.ZERO
# Use onready var to grab children nodes, like the sprite
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
