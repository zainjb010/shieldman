extends "res://scripts/ScriptTemplates/State.gd"

var nextAttack = null

func update(delta):
	var attack = owner.selectAttack()
	if attack and attack != nextAttack:
		print(attack.attackName)
		nextAttack = attack
		owner.changeAttackRange(0)
		owner.changeAttackRange(nextAttack.rangeModifier)
	
	var moveTarget = owner.selectTarget()
	var attackRadius = owner.ranges.attackRangeCollision.shape.radius
	var partyFormation = owner.partyFormationPosition
	if moveTarget:
		if owner.global_position.distance_to(moveTarget.global_position) < (attackRadius - (attackRadius / 8)):
			emit_signal("finished", "attack")
			return
	moveTarget = owner.selectMoveTarget()
	if moveTarget == partyFormation:
		var collision = moveSmooth(owner.speed, moveTarget.global_position)
		if !collision:
			return
	if !moveTarget:
		emit_signal("finished", "idle")
		return
		
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

func moveSmooth(speed, direction):
	var moveDirection = Follow.followSmooth(
		owner.moveDirection,
		owner.global_position,
		direction,
		speed
	)
	moveDirection = owner.move_and_slide(moveDirection)
