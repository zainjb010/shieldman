extends "res://scripts/ScriptTemplates/EntityRanges.gd"

#Attack Range collision handling
func _on_Range_body_entered(body):
	print(self.name, " ", get_parent().name, " ", body.name)
	var type = body.get_meta("type")
	if type == "player":
		nearbyEntities.append(body)
	pass

func _on_Range_body_exited(body):
	var type = body.get_meta("type")
	if type == "player":
		nearbyEntities.erase(body)
	pass

#Detection Range collision handling
func _on_Detection_body_entered(body):
	var type = body.get_meta("type")
	if type == "player":
		nearbyEntities.append(body)
	pass # Replace with function body.

func _on_Detection_body_exited(body):
	var type = body.get_meta("type")
	if type == "player":
		nearbyEntities.erase(body)
	pass # Replace with function body.
