extends KinematicBody2D

const ACCELERATION = 512
const MAX_SPEED = 100
const FRICTION = 0.30
const AIR_RESISTANCE = 0.05
const GRAVITY = 200
const JUMPFORCE = 140


var motion = Vector2.ZERO
# Use onready var to grab children nodes, like the sprite
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

# This handles the left and right movement
func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if x_input != 0:
		animationPlayer.play("Walk")
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED,MAX_SPEED)
		sprite.flip_h = x_input < 0
	else:
		animationPlayer.play("Stand")
		
	motion.y += GRAVITY * delta
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
			
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMPFORCE
	else:
		#animationPlayer.play("jump")
		if Input.is_action_just_released("ui_up") and motion.y < -JUMPFORCE/2:
			motion.y = -JUMPFORCE/2 
		if x_input == 0: 
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
	
	motion = move_and_slide(motion,Vector2.UP)
	
