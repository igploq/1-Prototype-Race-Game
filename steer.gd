extends Sprite3D

@export var rotation_speed := 50.0 
@export var return_speed := 25.0 
var rotation_angle := 0.0 

func _ready():

	rotation = Vector3(0, 0, deg_to_rad(rotation_angle))

func _process(delta):

	if Input.is_action_pressed("move_right"):
		rotate_steering_wheel(-rotation_speed * delta) 
	elif Input.is_action_pressed("move_left"):
		rotate_steering_wheel(rotation_speed * delta) 
	else:

		rotation_angle = lerp(rotation_angle, 0.0, return_speed * delta)
		rotation = Vector3(0, 0, deg_to_rad(rotation_angle))

func rotate_steering_wheel(amount: float):
	rotation_angle += amount 

	rotation_angle = clamp(rotation_angle, -150, 150)
	

	rotation = Vector3(0, 0, deg_to_rad(rotation_angle))
