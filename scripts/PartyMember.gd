extends "res://scripts/ScriptTemplates/Entity.gd"

onready var player = get_parent().get_node("Player")

signal partyMemberCreated(node)
var partyFormationPosition = Vector2(0, 0)
var playerThreatened = false

func _ready():
	#Send a reference to self to global data for bookkeeping purposes
	connect("partyMemberCreated", globalData, "partyMemberCreated")
	emit_signal("partyMemberCreated", self)
	#Connects the cast timers for all attacks to the state machine, signaling it to change out of the cast state
	for item in attacks.get_children():
		item.castTimer.connect("timeout", stateMachine.get_node("Cast"), "_on_Timer_timeout")
	pass

func setFormationPosition(position: Vector2):
	partyFormationPosition = position

func selectMoveTarget():
	#If the party member detects an enemy, it selects the closest one and moves toward it
	#Otherwise, it follows the partyFormationPosition
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

func avoid():
	#Called by zone or wave type attacks when the party member enters it
	#If casting, cancels the current attack and changes to the avoid state
	#If the playerThreatened flag is set, run away from enemies
	#If it's not set, run toward player
	pass

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
