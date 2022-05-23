extends Node2D

onready var attackRange = $Range
onready var attackRangeCollision = $Range/Collision
onready var detectionRange = $Detection
onready var detectionRangeCollision = $Detection/Collision

var nearbyEntities = []
var nearbyTargets = []
var closestEntity = null
var closestTarget = null

#Attack Range collision handling
func _on_Range_body_entered(body):
	pass

func _on_Range_body_exited(body):
	pass

#Detection Range collision handling
func _on_Detection_body_entered(body):
	pass # Replace with function body.

func _on_Detection_body_exited(body):
	pass # Replace with function body.
