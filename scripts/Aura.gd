extends Area2D

onready var hitbox = $CollisionShape2D
onready var sprite = $Sprite
onready var durationTimer = $Timer

export var attackName : String
export(NodePath) var source = null
export var damage = 0
export var damageType = ""
export var duration = 0
export var hitboxRadius = 0
export var missileCount = 0
export var speed = 0.0
export var firingArc = 0.0
export var size = 0
export (Array, String) var additionalEffects

var targets = []
var spriteTexture

func _ready():
	sprite.texture = spriteTexture
	set_meta("type", "aura")
	hitbox.shape.radius = hitboxRadius
	durationTimer.wait_time = duration
	durationTimer.start()

func _physics_process(delta):
	global_position = source.global_position
	for item in targets:
		item.takeDamage(source, global_position, damage, damageType, additionalEffects)
		targets.erase(item)
	pass
		
func _on_Timer_timeout():
	queue_free()

func _on_Zone_body_entered(body):
	targets.append(body)
	pass

func _on_Zone_body_exited(body):
	targets.erase(body)
	pass 
