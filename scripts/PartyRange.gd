extends "res://scripts/ScriptTemplates/EntityRanges.gd"

#Attack Range collision handling
func _on_Range_body_entered(body):
	var type = body.get_meta("type")
	if type == "baddie":
		nearbyTargets.append(body)

func _on_Range_body_exited(body):
	var type = body.get_meta("type")
	if type == "baddie":
		nearbyTargets.erase(body)

#Detection Range collision handling
func _on_Detection_body_entered(body):
	var type = body.get_meta("type")
	if type == "baddie":
		nearbyEntities.append(body)

func _on_Detection_body_exited(body):
	var type = body.get_meta("type")
	if type == "baddie":
		nearbyEntities.erase(body)
