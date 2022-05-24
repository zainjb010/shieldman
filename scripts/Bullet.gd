extends KinematicBody2D

#Stores a given projectile's data, and processes its movement
var bulletDirection = Vector2(0, 0)

onready var hitbox = $CollisionShape2D
onready var sprite = $Sprite
onready var durationTimer = $Timer

export(NodePath) var source = null
export var damage = 0
export var damageType = "magic"
export var speed = 9
export var duration = 0

func _ready():
	set_meta("type", "bullet")
	durationTimer.wait_time = duration
	durationTimer.start()

func _physics_process(delta):
	var collision = move_and_collide(speed * bulletDirection,false)
	if collision:
		var type = collision.collider.get_meta("type")
		#if type == "baddie":
		collision.collider.takeDamage(source, damage, damageType)
		queue_free()
		
func _on_Timer_timeout():
	queue_free()
