extends RigidBody3D

@export var acceleration := 10.0  # Усилие для движения
@export var max_speed := 100.0
@export var turn_speed := 2.0
@export var friction := 0.9 

@onready var car_body = $CarBody
@onready var head = $CarBody/Head
@onready var navigator = $CarBody/Navigator
@onready var engine_sound = $EngineSound
@onready var idle_sound = $IdleSound

var yaw := 0.0
var pitch := 0.0
var max_yaw := deg_to_rad(90)

func _ready():
	linear_damp = friction  
	gravity_scale = 1.0    

func _physics_process(delta):
	var forward_dir = -car_body.global_transform.basis.z
	if Input.is_action_pressed("move_forward"):
		if not engine_sound.playing:
			if idle_sound.playing:
				idle_sound.stop()
			engine_sound.play()  
		
		apply_central_force(forward_dir * acceleration)
	elif Input.is_action_pressed("move_backward"):
		apply_central_force(-forward_dir * acceleration * 0.2)
	else:
		if engine_sound.playing:
			engine_sound.stop()
			idle_sound.play()


	var current_speed = linear_velocity.dot(forward_dir)
	if abs(current_speed) > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed


	if Input.is_action_pressed("move_left"):
		apply_torque(Vector3(0, turn_speed, 0))
	elif Input.is_action_pressed("move_right"):
		apply_torque(Vector3(0, -turn_speed, 0))


	if Input.is_action_pressed("look_right"):
		yaw = lerp(yaw, deg_to_rad(-60), 5.0 * delta)
	else:
		yaw = lerp(yaw, 0.0, 5.0 * delta)

	yaw = clamp(yaw, -max_yaw, max_yaw)
	head.rotation.y = yaw
