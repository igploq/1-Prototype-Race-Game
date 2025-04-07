extends Node3D

@onready var crowd1 = $CrowdAnim

func _ready() -> void:
	crowd1.play("Crowd_Jump")
