extends "res://scripts/ScriptTemplates/EntityRanges.gd"

#Detection Range collision handling
func _on_Detection_body_entered(body):
	var type = body.get_meta("type")
	if type == "baddie":
		nearbyEntities.append(body)
	pass 

func _on_Detection_body_exited(body):
	var type = body.get_meta("type")
	if type == "baddie":
		nearbyEntities.erase(body)
	pass

func calculatePartyPosition() -> Vector2:
	#For each detected enemy, sum their position vectors multiplied by their threat levels
	#Normalize the result, and multiply by -1 to find where the party should loosely be
	if nearbyEntities.empty():
		return Vector2.ZERO
	var position := Vector2.ZERO
	var sum := Vector2.ZERO
	for item in nearbyEntities:
		if is_instance_valid(item):
			position = item.global_position - global_position
			position = position.normalized() * item.threat
			sum += position
			
	#Add in the shield vector, with a multiplier of 1/4
	#This will cause the party to respect your shield position somewhat
	sum += (get_global_mouse_position() - global_position).normalized() * .25
	sum = sum.normalized() * -1
	return sum
	pass
