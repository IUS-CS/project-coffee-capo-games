extends Area2D

onready var animationPlayer: AnimationPlayer = get_node("AnimationPlayer")

func _on_body_entered(_body: PhysicsBody2D) -> void:
	animationPlayer.play("fade_out")
