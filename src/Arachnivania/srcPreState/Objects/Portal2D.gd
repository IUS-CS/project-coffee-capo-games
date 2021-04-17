tool
extends Area2D

onready var animationplayer: AnimationPlayer = $AnimationPlayer

export(String, FILE) var next_scene_path = ""
export(Vector2) var player_spawn_location = Vector2.ZERO # ZERO is only initial
export(int) var player_direction = 1

func _get_configuration_warning() -> String:
	if next_scene_path == "":
		return "next_scene_path must be set for the portal to work"
	else:
		return ""

func teleport() -> void:
	animationplayer.play("fade_in")
	yield(animationplayer, "animation_finished")
	

func _on_Portal2D_body_entered(body):
	# globel variable for player position
	Global.player_initial_map_position = player_spawn_location 
	# Global variable fo player direction
	Global.player_facing_direction = player_direction
	if get_tree().change_scene(next_scene_path) != OK:
		#error handeling here
		print("Error: Unavalible scene!")
