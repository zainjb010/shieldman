extends "res://scripts/ScriptTemplates/State.gd"

func update(delta):
	var currentTarget = owner.selectTarget()
	var moveTarget = owner.selectMoveTarget()
	if !currentTarget:
		emit_signal("finished", "idle")
	if currentTarget == null or ! is_instance_valid(currentTarget):
		owner.attackDirection = Vector2(0, 0)
		emit_signal("finished", "idle")
		return
	if moveTarget:
		emit_signal("finished", "move")
	if is_instance_valid(currentTarget):
		#var firingDirection = owner.global_position.direction_to(currentTarget.global_position)
		var firingDirection = owner.global_position.direction_to(currentTarget.global_position)
		owner.attackDirection = firingDirection
	owner.attack(owner.selectAttack())
