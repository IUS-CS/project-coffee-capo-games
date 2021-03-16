extends Area2D

onready var animationPlayer: AnimationPlayer = get_node("AnimationPlayer")

export var health: = 20

func _on_body_entered(_body: PhysicsBody2D) -> void:
	if PlayerData.health <= 100:
		picked()

func picked() -> void:
	PlayerData.health += health
	animationPlayer.play("fade_out")
	if PlayerData.health > 100:
		PlayerData.health = 100
