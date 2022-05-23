extends "res://scripts/ScriptTemplates/Entity.gd"

func _physics_process(delta):
	var moveDirection = global_position.direction_to(globalData.playerPosition)
	
	move_and_slide(speed * moveDirection)
