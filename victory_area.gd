extends Area3D

func _on_body_entered(body):
	if body.name == "CharacterBody3D":
		get_tree().change_scene_to_file("res://victory_screen.tscn")
