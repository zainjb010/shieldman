extends "res://scripts/ScriptTemplates/Entity.gd"

signal partyMemberCreated(node)
var partyFormationPosition = Vector2(0, 0)

func _ready():
	#Send a reference to self to global data for bookkeeping purposes
	connect("partyMemberCreated", globalData, "partyMemberCreated")
	emit_signal("partyMemberCreated", self)
	for item in attacks.get_children():
		item.castTimer.connect("timeout", stateMachine.get_node("Cast"), "_on_Timer_timeout")
	pass

func setFormationPosition(position: Vector2):
	partyFormationPosition = position

func selectMoveTarget():
	if ranges.nearbyEntities.empty():
		return partyFormationPosition
	ranges.closestEntity = findClosestCanvasItemInArray(global_position, ranges.nearbyEntities)
	if ranges.closestEntity != null:
		moveTarget = ranges.closestEntity
	if moveTarget == null or ! is_instance_valid(moveTarget):
		return null
	if is_instance_valid(moveTarget):
		return moveTarget

func selectTarget():
	#Finds the closest target
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

#func _physics_process(delta):
	#Finds the closest target and fires at it
	#ranges.closestTarget = findClosestCanvasItemInArray(global_position, ranges.nearbyTargets)
	#if ranges.closestTarget != null:
		#print(ranges.closestTarget.name)
		#currentTarget = ranges.closestTarget
	#if currentTarget == null or ! is_instance_valid(currentTarget):
		#attackDirection = Vector2(0, 0)
		#return
	#if is_instance_valid(currentTarget):
		#var firingDirection = global_position.direction_to(currentTarget.global_position)
		#attackDirection = firingDirection
		#var selectedAttack = selectAttack()
		#if selectedAttack != null:
			#attack(selectedAttack)
		#attack(selectAttack())
	#pass
