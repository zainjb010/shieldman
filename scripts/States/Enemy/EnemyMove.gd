extends "res://scripts/ScriptTemplates/State.gd"

func update(delta):
	var moveTarget = owner.selectTarget()
	var attackRadius = owner.ranges.attackRangeCollision.shape.radius
	if moveTarget:
		if owner.global_position.distance_to(moveTarget.global_position) < (attackRadius - (attackRadius / 8)):
			emit_signal("finished", "attack")
			return
	moveTarget = owner.selectMoveTarget()
	if !moveTarget:
		emit_signal("finished", "idle")
		
	var collision = move(owner.speed, moveTarget.global_position)
	if !collision:
		return
		
func move(speed, direction):
	var moveDirection = Follow.follow(
		owner.moveDirection,
		owner.global_position,
		direction,
		speed
	)
	moveDirection = owner.move_and_slide(moveDirection)
