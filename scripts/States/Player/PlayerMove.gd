extends "res://scripts/ScriptTemplates/State.gd"

func update(delta):
	var inputDirection = owner.getInputDirection()
	if !inputDirection:
		emit_signal("finished", "idle")
		
	var collision = move(owner.speed, inputDirection)
	if !collision:
		return
		
func move(speed, direction):
	var velocity = direction.normalized() * speed
	owner.move_and_slide(velocity)
