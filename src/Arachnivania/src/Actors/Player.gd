extends Actor

export var stomp_impulse: = 230.0

func _on_EnemyDetector_area_entered(_area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(_body: PhysicsBody2D) -> void:
	PlayerData.health -= 25
	if PlayerData.health <= 0:
		die()

# This handles the left and right movement
func _physics_process(_delta: float) -> void:
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

func die() -> void:
	queue_free()

#For RyanS test levels
func _on_Fallzone_body_entered(body):
	get_tree().change_scene("res://src/Levels/RyanSCave.tscn")


func _on_Exit_body_entered(body):
	get_tree().change_scene("res://src/Levels/RyanSGrassland.tscn")


func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://src/Levels/RyanSCave.tscn")
