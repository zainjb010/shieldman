extends Node2D

#This script will eventually handle different party formations, and update the party's positions
var partyMembers = []

func newPartyMember(partyNode):
	partyMembers.append(partyNode)
	#Create a position2d node and set the party member to follow it
	var newPosition = Position2D.new()
	newPosition.position = Vector2(0, -100)
	add_child(newPosition)
	partyNode.partyFormationPosition = newPosition
	#partyNode.partyFormationPosition = Vector2((owner.global_position.x - 100), owner.global_position.y)
	pass

func playerMove():
	pass

func playerChangeFacing(direction):
	#When the player changes direction, update the party's positions
	pass
