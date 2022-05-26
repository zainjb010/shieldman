extends "res://scripts/ScriptTemplates/State.gd"

func update(delta):
	var inputDirection = owner.getInputDirection()
	if inputDirection:
		emit_signal("finished", "move")
