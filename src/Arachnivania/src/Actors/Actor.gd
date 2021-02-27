extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(135.0, 230.0)
export var gravity: = 500.0
#const ACCELERATION = 512
#const MAX_SPEED = 100
#const FRICTION = 0.30
#const AIR_RESISTANCE = 0.05
#const GRAVITY = 200
#const JUMPFORCE = 140

var _velocity: = Vector2.ZERO
# Use onready var to grab children nodes, like the sprite
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
