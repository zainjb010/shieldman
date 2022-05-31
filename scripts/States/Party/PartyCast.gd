extends "res://scripts/ScriptTemplates/State.gd"

#onready var castTimer = $Timer

func enter():
	#castTimer.wait_time = owner.castTime
	#castTimer.start()
	pass
	
func _on_Timer_timeout():
	emit_signal("finished", "attack")
