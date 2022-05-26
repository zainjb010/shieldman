extends Node2D

signal newPartyMember(partyNode)

var playerPosition = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#This function is deprecated
func updatePosition(value):
	playerPosition = value
	
func partyMemberCreated(partyNode):
	emit_signal("newPartyMember", partyNode)
