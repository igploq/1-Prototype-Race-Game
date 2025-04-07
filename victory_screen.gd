extends Control

@onready var restart_button = $RestartButton

func _ready():
	restart_button.pressed.connect(self._on_restart_pressed)

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://game.tscn")
