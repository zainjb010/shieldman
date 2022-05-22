extends Node2D

onready var firingSpeed = $FiringSpeed

var bulletObject = preload("res://objects/Bullet.tscn")

var direction = Vector2(0,0)

func _ready():
	pass # Replace with function body.

func _process(delta):
	if direction != Vector2(0,0) and firingSpeed.is_stopped():
		fire()
		
func fire():
	#Instantiates a bullet object, and gives it an initial direction
	var bullet = bulletObject.instance()
	bullet.bulletDirection = direction
	add_child(bullet)
	firingSpeed.start()
	
func _on_firingspeed_timeout():
	firingSpeed.stop()

