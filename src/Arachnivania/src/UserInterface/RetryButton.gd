extends Button

func _on_button_up() -> void:
	PlayerData.reset()
	get_tree().pause = false
	get_tree().reload_current_scene()
