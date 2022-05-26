extends "res://scripts/ScriptTemplates/Entity.gd"

func selectMoveTarget():
	if ranges.nearbyEntities.empty():
		return null
	ranges.closestEntity = findClosestCanvasItemInArray(global_position, ranges.nearbyEntities)
	if ranges.closestEntity != null:
		moveTarget = ranges.closestEntity
	if moveTarget == null or ! is_instance_valid(moveTarget):
		return null
	if is_instance_valid(moveTarget):
		return moveTarget

func selectTarget():
	#Finds the closest target
	if ranges.nearbyTargets.empty():
		return null
	ranges.closestTarget = findClosestCanvasItemInArray(global_position, ranges.nearbyTargets)
	if ranges.closestTarget != null:
		currentTarget = ranges.closestTarget
	if currentTarget == null or ! is_instance_valid(currentTarget):
		attackDirection = Vector2(0, 0)
		return null
	if is_instance_valid(currentTarget):
		return currentTarget

#func _physics_process(delta):
	#Finds the closest target and fires at it
	#ranges.closestTarget = findClosestCanvasItemInArray(global_position, ranges.nearbyTargets)
	#if ranges.closestTarget != null:
		#print(ranges.closestTarget.name)
		#currentTarget = ranges.closestTarget
	#if currentTarget == null or ! is_instance_valid(currentTarget):
		#attackDirection = Vector2(0, 0)
		#return
	#if is_instance_valid(currentTarget):
		#var firingDirection = global_position.direction_to(currentTarget.global_position)
		#attackDirection = firingDirection
		#var selectedAttack = selectAttack()
		#if selectedAttack != null:
			#attack(selectedAttack)
		#attack(selectAttack())
	#pass
