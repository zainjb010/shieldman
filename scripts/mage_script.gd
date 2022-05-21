extends KinematicBody2D


var currenttarget = null

onready var magicboltarea = $magicboltarea

onready var magicbolt = $magicbolt


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if magicboltarea.closestenemy != null:
		currenttarget = magicboltarea.closestenemy
	if currenttarget == null or ! is_instance_valid(currenttarget):
		magicbolt.direction = Vector2(0,0)
		return
	if is_instance_valid(currenttarget):
		var firingdirection = global_position.direction_to(currenttarget.global_position)	
		magicbolt.direction = firingdirection
		
