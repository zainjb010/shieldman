extends "res://scripts/ScriptTemplates/Entity.gd"

func _physics_process(delta):
	#Finds closest enemy within the detection range and moves towards it
	ranges.closestEntity = findClosestCanvasItemInArray(global_position, ranges.nearbyEntities)
	if ranges.closestEntity != null:
		moveDirection = Follow.follow(
			moveDirection,
			global_position,
			ranges.closestEntity.global_position,
			speed
		)
		#moveDirection = global_position.direction_to(ranges.closestEntity.global_position)
	else: 
		moveDirection = Vector2(0, 0)
			
	moveDirection = move_and_slide(moveDirection)
