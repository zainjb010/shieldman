extends "res://scripts/ScriptTemplates/EntityRanges.gd"

#Detection Range collision handling
func _on_Detection_body_entered(body):
	var type = body.get_meta("type")
	if type == "player":
		nearbyEntities.append(body)
	pass 

func _on_Detection_body_exited(body):
	var type = body.get_meta("type")
	if type == "player":
		nearbyEntities.erase(body)
	pass
