extends Node2D

var playerPosition = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updatePosition(value):
	playerPosition = value
