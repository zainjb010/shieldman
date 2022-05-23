extends Area2D

onready var collision = $Collision

var nearbyEntities = []
var closestEntity = null

func _on_Detection_body_entered(body):
	pass

func _on_Detection_body_exited(body):
	pass 
