extends KinematicBody2D

#Stores a given projectile's data, and processes its movement
var bulletDirection = Vector2(0, 0)

onready var hitbox = $CollisionShape2D
onready var sprite = $Sprite
onready var durationTimer = $Timer

export var attackName : String
export var type : String
export(NodePath) var source = null
export var damage = 0
export var damageType = "magic"
export var speed = 9
export var tracking = false
export var missileCount = 0
export var firingArc = 0
export var duration = 0
export var castTime = 0.0
export var size = 0
export var hitboxRadius = 0.0
export (Array, String) var additionalEffects

export var spriteTexture : Texture
export var castTexture : Texture

func _ready():
	global_position = source.global_position
	sprite.texture = spriteTexture
	set_meta("type", "bullet")
	durationTimer.wait_time = duration
	durationTimer.start()

func _physics_process(delta):
	var collision = move_and_collide(speed * bulletDirection,false)
	if collision:
		collision.collider.takeDamage(source, bulletDirection, damage, damageType, additionalEffects)
		queue_free()
		
func _on_Timer_timeout():
	queue_free()
