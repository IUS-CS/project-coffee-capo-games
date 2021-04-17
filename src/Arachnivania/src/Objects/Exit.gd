tool
extends Area2D

onready var animationplayer: AnimationPlayer = $AnimationPlayer

export var next_scene: PackedScene

func _on_body_entered(body: Node) -> void:
	teleport()

func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""

func teleport() -> void:
	animationplayer.play("fade_in")
	yield(animationplayer, "animation_finished")
	get_tree().change_scene_to(next_scene)
