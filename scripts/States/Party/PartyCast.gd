extends "res://scripts/ScriptTemplates/State.gd"

#onready var castTimer = $Timer

func enter():
	#castTimer.wait_time = owner.castTime
	#castTimer.start()
	pass
	
func _on_Timer_timeout():
	var target
	if get_parent().getCurrentState() == "avoid":
		return
	if is_instance_valid(owner.currentTarget):
		target = owner.currentTarget
	for item in owner.currentAttack.additionalEffects:
		if item == "return":
			owner.global_position = owner.teleportPosition
	emit_signal("finished", "idle")
