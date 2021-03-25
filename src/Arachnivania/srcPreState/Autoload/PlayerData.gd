extends Node

signal xp_updated
signal health_updated

var xp: = 0 setget set_xp
var health: = 100 setget set_health

func reset() -> void:
	xp = 0
	health = 100

func set_xp(value: int) -> void:
	xp = value
	emit_signal("xp_updated")

func set_health(value: int) -> void:
	health = value
	emit_signal("health_updated")
