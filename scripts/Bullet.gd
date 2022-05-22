extends KinematicBody2D

var bulletDirection = Vector2(0, 0)

export var speed = 9

func _ready():
	set_meta("type", "bullet")

func _physics_process(delta):
	var collision = move_and_collide(speed * bulletDirection,false)
	if collision:
		var type = collision.collider.get_meta("type")
		if type == "baddie":
			collision.collider.take_damage()
			queue_free()
		
