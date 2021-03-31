# Unit Testing

We will be using the GUT library plugin to do unit testing on the Arachnivania source code. The asserts and method library documentation can be found at https://github.com/bitwes/Gut/wiki/Asserts-and-Methods

With this we will be able to simulate many different aspect of player input, character states, character movement and character position. We can then assert whether the intended output of code matches the simulated output. This will be easy to implement and monitor due to the previous implementation of the debug panel that is a UI panel displaying customizable properties including the current state of the State Machine.

## Example

Here is a very early example of using GUT to test prelimenary movement code on our character

```GDscript
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
```

While this was made before the State machine was implemented, it will be very easy to refactor the tests to better fit the code.

## Expectations

In order to make our unit testing more adaptable we are not going to be testing against **internal** states, i.e *Run, Idle, Move, Air*. Instead we will be testing against **external** states.

* Internal states are the states that the state machine uses to do its job
* External states are states that can be reacted to by code using the state machine (events or side-effects caused by transition actions)

This is because if we wrote tests against the internal states, anytime we would refactor the internal states in our source code, we would then have to change our tests. However if we were to say, tests against an event argument that holds information on whether a specific state is happening, we could refactor source code and tests would not be affected. It would also be easy to adapt by just adding new indicators to our events.

For example, say I wanted to test whether my character is moving or not, and I tested against the *Move* state (before creating child states *Idle, Run and Air*) so I write all my tests to assert whether I was in the *Move* state. Now, as I develop more of my game, I create the different child states of *Move*. Since I tested against the **internal** state, I would now have to go back and rewrite my tests. However, if I were to test against a signal that is emitted when the character moves, and another when the character is in the air, I would not have to change my tests, only add the *Air* signal to the event argument and assert.

## Implementation

By arranging our state machine properly, we can easily implement our testing method. We can code the state machine to be in the **external** state before any action we may want to test and then preform the state transition. This will allow us to easily assert whether the state machine made the correct calls.

## Sources

PlanetGeek - https://www.planetgeek.ch/2011/05/17/how-to-unit-test-finite-state-machines/