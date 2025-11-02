extends Node2D

@onready var crab: CharacterBody2D = $Crab
@onready var player: CharacterBody2D = $Player


func _on_timer_timeout() -> void:
	crab.call("set_movement_target", player.global_position)
