extends "res://scripts/ScriptTemplates/Entity.gd"

func _physics_process(delta):
	ranges.closestTarget = findClosestCanvasItemInArray(global_position, ranges.nearbyTargets)
	if ranges.closestTarget != null:
		currentTarget = ranges.closestTarget
	if currentTarget == null or ! is_instance_valid(currentTarget):
		attackDirection = Vector2(0, 0)
		return
	if is_instance_valid(currentTarget):
		var firingDirection = global_position.direction_to(currentTarget.global_position)
		attackDirection = firingDirection
		#var selectedAttack = selectAttack()
		#if selectedAttack != null:
			#attack(selectedAttack)
		attack(selectAttack())
	pass
