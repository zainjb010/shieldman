extends "res://scripts/ScriptTemplates/State.gd"

func enter():
	print("idling")

func update(delta):
	var currentTarget = owner.selectMoveTarget()
	if currentTarget:
		emit_signal("finished", "move")
		return
	currentTarget = owner.selectTarget()
	if currentTarget:
		emit_signal("finished", "attack")
