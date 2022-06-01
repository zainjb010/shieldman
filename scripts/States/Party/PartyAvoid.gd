extends "res://scripts/ScriptTemplates/State.gd"

func update(delta):
	var moveTarget = owner.player
	var moveDirection = Vector2(0, 0)
	var avoid = owner.avoidPosition
	var directionToAvoid = owner.global_position.direction_to(owner.avoidPosition)
	if moveTarget:
		if owner.playerThreatened == true:
			moveDirection = directionToAvoid
		if owner.playerThreatened == false:
			#moveDirection = (moveTarget.global_position - owner.avoidPosition) - (owner.global_position - owner.avoidPosition)
			moveDirection = moveTarget.global_position
		if directionToAvoid.dot(moveDirection) > 0:
			moveDirection *= -1
		if owner.global_position.distance_to(moveTarget.global_position) < 30:
			return
	if !moveTarget:
		emit_signal("finished", "idle")
		return
	
	var collision = move(owner.speed, moveDirection)
	#var collision = move(owner.speed, moveTarget.global_position)
	if !collision:
		return
		
func move(speed, direction):
	var moveDirection = Follow.followSmooth(
		owner.moveDirection,
		owner.global_position,
		direction,
		speed
	)
	moveDirection = owner.move_and_slide(moveDirection)
