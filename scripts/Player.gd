extends "res://scripts/ScriptTemplates/Entity.gd"

signal positionChanged(position)

func _ready():
	connect("positionChanged", globalData, "updatePosition")
	#Set other entity variables here
	health = 20
	speed = 500
	entityCollision.shape.radius = 32

func _physics_process(delta):
	if global_position != previousPosition:
			emit_signal("positionChanged", global_position)
	var inputvector = Vector2 (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	moveDirection = inputvector.normalized() #
	previousPosition = global_position
	move(moveDirection)
