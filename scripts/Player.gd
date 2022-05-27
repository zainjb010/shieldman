extends "res://scripts/ScriptTemplates/Entity.gd"

#signal positionChanged(position)
onready var partyFormation = $PartyFormation
onready var shield = $Shield

#Overloaded ready function that sets entity variables
func _ready():
	set_meta("type", "player")
	#connect("positionChanged", globalData, "updatePosition")
	globalData.connect("newPartyMember", partyFormation, "newPartyMember")
	#Set other entity variables here
	health = 20
	currentHealth = 20
	speed = 500
	entityCollision.shape.radius = 32
	availableAttacks.append($Attacks/Taunt)
	ui.healthBar.updateBar(100 * (currentHealth / health))

func getInputDirection():
	var inputvector = Vector2 (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	moveDirection = inputvector.normalized()
	return moveDirection

func _input(event):
	if event.is_action_pressed("ui_select") and availableAttacks.has($Attacks/Taunt):
		attack($Attacks/Taunt)
	pass

func takeDamage(source: Node, direction : Vector2, amount: int, type: String) -> int:
	#Check if shield is blocking in the proper direction
	var shieldDirection = Vector2(1, 0).rotated(shield.rotation)
	var blocked = global_position.direction_to(source.global_position)
	if blocked.dot(shieldDirection) > 0:
		#The damage is blocked
		return 0
	return .takeDamage(source, direction, amount, type)
	
	
#func _physics_process(delta):
	#if global_position != previousPosition:
			#emit_signal("positionChanged", global_position)
	#var inputvector = Vector2 (
		#Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		#Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#)
	#moveDirection = inputvector.normalized() #
	#previousPosition = global_position
	#move(moveDirection)
