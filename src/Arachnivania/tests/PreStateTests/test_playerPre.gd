extends "res://addons/gut/test.gd"

var Player = preload("res://srcPreState/Actors/Player.gd")

func test_start_no_input_left():
	var player = Player.new()
	assert_eq(
		false,
		Input.is_action_pressed("move_left"),
		"Start with no left input"
	)

func test_start_no_input_right():
	var player = Player.new()
	assert_eq(
		false,
		Input.is_action_pressed("move_right"),
		"Start with no right input"
	)

func test_start_no_input_jump():
	var player = Player.new()
	assert_eq(
		false,
		Input.is_action_pressed("jump"),
		"Start with no jump input"
	)	

func test_start_no_direction():
	var player = Player.new()
	assert_eq(
		Vector2(0.0,0.0), 
		player.get_direction(), 
		"Player Starts Not Moving"
	)

func test_input_left():
	var player = Player.new()
	Input.action_press("move_left", 1.0)
	assert_eq(
		true, 
		Input.is_action_pressed("move_left"),
		"Left is pressed"
	)
	Input.action_release("move_left") 

func test_input_right():
	var player = Player.new()
	Input.action_press("move_right", 1.0)
	assert_eq(
		true, 
		Input.is_action_pressed("move_right"),
		"Right is pressed"
	)
	Input.action_release("move_right") 

func test_input_jump():
	var player = Player.new()
	Input.action_press("jump", 1.0)
	assert_eq(
		true, 
		Input.is_action_pressed("jump"),
		"Jump is pressed"
	)
	Input.action_release("jump") 

func test_direction_left():
	var player = Player.new()
	Input.action_press("move_left", 1.0)
	assert_eq(
		Vector2(-1.0,0.0),
		player.get_direction(),
		"Player moves left when input pressed"
	)
	Input.action_release("move_left")
	
func test_direction_right():
	var player = Player.new()
	Input.action_press("move_right", 1.0)
	assert_eq(
		Vector2(1.0,0.0),
		player.get_direction(),
		"Player moves right when input pressed"
	)
	Input.action_release("move_right")

func test_direction_jump():
	var player = Player.new()
	Input.action_press("jump", 1.0)
	assert_eq(
		false,
		player.is_on_floor(),
		"Player jumps when input pressed"
	)
	Input.action_release("jump")

