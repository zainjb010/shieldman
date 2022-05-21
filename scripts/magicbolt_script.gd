extends Node2D

onready var firingspeed = $firingspeed

var bulletobject = preload("res://objects/Bullet.tscn")

var direction = Vector2(0,0)

func _ready():
	pass # Replace with function body.

func _process(delta):
	if direction != Vector2(0,0) and firingspeed.is_stopped():
		fire()
		
	

func fire():
	var bullet = bulletobject.instance()
	bullet.bulletdirection = direction
	add_child(bullet)
	firingspeed.start()
	


func _on_firingspeed_timeout():
	firingspeed.stop()

