extends "res://scripts/ScriptTemplates/State.gd"

func update(delta):
	var inputDirection = owner.getInputDirection()
	if !inputDirection:
		emit_signal("finished", "idle")
		
	var collision = move(owner.speed, inputDirection, delta)
	if !collision:
		return
		
func move(speed, direction, delta):
	var velocity = direction.normalized() * speed
	owner.move_and_slide(velocity)
	var newLookDirection = get_parent().updateLookDirection(velocity)
	if newLookDirection:
		if newLookDirection != owner.lookDirection:
			owner.lookDirection = newLookDirection
			owner.partyFormation.playerChangeFacing(newLookDirection)
