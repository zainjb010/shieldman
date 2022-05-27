extends Node2D

#This script will eventually handle different party formations, and update the party's positions
var partyMembers = []
var previousFacing = "down"

func newPartyMember(partyNode):
	partyMembers.append(partyNode)
	#Create a position2d node and set the party member to follow it
	var newPosition = Position2D.new()
	newPosition.position = Vector2(0, -100)
	add_child(newPosition)
	partyNode.partyFormationPosition = newPosition
	pass

func playerMove():
	pass

func playerChangeFacing(direction):
	#When the player changes direction, update the party's positions
	if direction == previousFacing:
		return
	for item in get_children():
		if (direction == "down" and previousFacing == "up") or (direction == "up" and previousFacing == "down"):
			item.position.y *= -1
		if (direction == "left" and previousFacing == "right") or (direction == "right" and previousFacing == "left"):
			item.position.x *= -1
		if (direction == "down" or direction == "up") and (previousFacing == "left" or previousFacing == "right"):
			var swap = item.position.x
			item.position.x = item.position.y
			item.position.y = swap
			if (direction == "down" and item.position.y > 0) or (direction == "up" and item.position.y < 0):
				item.position.y *= -1
		if (direction == "right" or direction == "left") and (previousFacing == "down" or previousFacing == "up"):
			var swap = item.position.x
			item.position.x = item.position.y
			item.position.y = swap
			if (direction == "right" and item.position.x > 0) or (direction == "left" and item.position.x < 0):
				item.position.x *= -1
	previousFacing = direction
	pass
