extends "res://scripts/ScriptTemplates/Entity.gd"

#var aggroTarget = null
var aggroValue = 0
var aggroTable = []

func selectMoveTarget():
	if !aggroTable.empty():
		moveTarget = selectTarget()
		return moveTarget
	if ranges.nearbyEntities.empty():
		return null
	ranges.closestEntity = findClosestCanvasItemInArray(global_position, ranges.nearbyEntities)
	if ranges.closestEntity != null:
		moveTarget = ranges.closestEntity
	if moveTarget == null or ! is_instance_valid(moveTarget):
		return null
	if is_instance_valid(moveTarget):
		return moveTarget

func selectTarget():
	#Finds the target with the highest aggro value in range
	#Or, if the table is empty, finds the closest target
	if !aggroTable.empty():
		for item in aggroTable:
			if currentTarget == null or item["value"] > aggroValue:
				currentTarget = item["source"]
				aggroValue = item["value"]
		return currentTarget
	if ranges.nearbyTargets.empty():
		return null
	ranges.closestTarget = findClosestCanvasItemInArray(global_position, ranges.nearbyTargets)
	if ranges.closestTarget != null:
		currentTarget = ranges.closestTarget
	if currentTarget == null or ! is_instance_valid(currentTarget):
		attackDirection = Vector2(0, 0)
		return null
	if is_instance_valid(currentTarget):
		return currentTarget

func takeDamage(source: Node, amount: int, type: String) -> int:
	#Add the source of the damage to an aggro table
	var damage = .takeDamage(source, amount, type)
	if type == "none":
		damage = amount
	for item in aggroTable:
		if item["source"] == source:
			item["value"] += damage
			return damage
	aggroTable.append(
		{
			"source": source,
			"value": damage
		}
	)
	#for item in aggroTable:
		#print(item["source"].name, " ", item["value"])
	return damage
