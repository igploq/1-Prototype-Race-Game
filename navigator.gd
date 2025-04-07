extends Node3D

@export var drinking := false
@export var drink_timer := 0.0
@export var drink_interval := 15.0 
@export var required_hold_time := 1.0  

@onready var drink_sprite = $Drinking   
@onready var sit_sprite = $Sitting     
@onready var choke_sprite = $Choking   
@onready var choke_hand = $ChokeHand   
@onready var block_scr = $BlackScreen
@onready var choke_sound = $ChokingSound

var hold_time := 0.0  
var is_choking := false 

func _ready():
	block_scr.visible = false
	choke_hand.visible = false
	choke_sprite.visible = false

func _process(delta):
	if not drinking:
		drink_timer += delta
		if drink_timer >= drink_interval:
			start_drinking()
	else:
		if Input.is_action_pressed("look_right"):
			if Input.is_action_pressed("interact"):
				choke_sound.play()
				hold_time += delta 
				is_choking = true  
				if hold_time >= required_hold_time:
					stop_drinking()
			else:
				if hold_time > 0 and hold_time < required_hold_time:
					hold_time = 0.0
				is_choking = false
		else:
			if hold_time > 0:
				hold_time = 0.0
			is_choking = false

	if is_choking:
		sit_sprite.visible = false
		drink_sprite.visible = false
		choke_sprite.visible = true
		choke_hand.visible = true
	else:
		sit_sprite.visible = not drinking
		drink_sprite.visible = drinking
		choke_sprite.visible = false
		choke_hand.visible = false

func start_drinking():
	block_scr.visible = true
	drinking = true
	hold_time = 0.0
	is_choking = false


func stop_drinking():
	block_scr.visible = false
	if choke_sound.playing:
		choke_sound.stop()
	drinking = false
	drink_timer = 0.0
	hold_time = 0.0
	is_choking = false
