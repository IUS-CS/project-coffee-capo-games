extends Actor

export var stomp_impulse: = 230.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body: Node) -> void:
	queue_free()

# This handles the left and right movement
func _physics_process(delta: float) -> void:
	var is_jump_interrupted = (Input.is_action_just_released("jump") 
		and _velocity.y < 0.0)
	var direction: = get_direction()
	if direction.x != 0.0:
		animationPlayer.play("Walk")
		sprite.flip_h = direction.x < 0.0
	else:
		animationPlayer.play("Stand")
#	if direction.y != 0.0:
#		animationPlayer.play("Jump")
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
		var out: = linear_velocity
		out.x = speed.x * direction.x
		out.y += gravity * get_physics_process_delta_time()
		if direction.y ==  -1.0:
			out.y = speed.y * direction.y
		if is_jump_interrupted:
			out.y = 0.0 
		return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
		var out: = linear_velocity
		out.y = -impulse
		return out

#const ACCELERATION = 512
#const MAX_SPEED = 100
#const FRICTION = 0.30
#const AIR_RESISTANCE = 0.05
#const GRAVITY = 200
#const JUMPFORCE = 140
#var motion = Vector2.ZERO

## This handles the left and right movement
#func _physics_process(delta):
#	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	if x_input != 0:
#		animationPlayer.play("Walk")
#		motion.x += x_input * ACCELERATION * delta
#		motion.x = clamp(motion.x, -MAX_SPEED,MAX_SPEED)
#		sprite.flip_h = x_input < 0
#	else:
#		animationPlayer.play("Stand")
#	motion.y += GRAVITY * delta
#	if is_on_floor():
#		if x_input == 0:
#			motion.x = lerp(motion.x, 0, FRICTION)
#		if Input.is_action_just_pressed("ui_up"):
#			motion.y = -JUMPFORCE
#	else:
#		animationPlayer.play("jump")
#		if Input.is_action_just_released("ui_up") and motion.y < -JUMPFORCE/2:
#			motion.y = -JUMPFORCE/2 
#		if x_input == 0: 
#			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
#	motion = move_and_slide(motion,Vector2.UP)
