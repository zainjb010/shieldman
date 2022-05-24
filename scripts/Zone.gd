extends Area2D

onready var hitbox = $CollisionShape2D
onready var sprite = $Sprite
onready var durationTimer = $Timer

export(NodePath) var source = null
export var damage = 0
export var damageType = ""
export var duration = 0
export var hitboxRadius = 0

var targets = []

func _ready():
	set_meta("type", "zone")
	hitbox.shape.radius = hitboxRadius
	durationTimer.wait_time = duration
	durationTimer.start()

func _physics_process(delta):
	global_position = source.global_position
	for item in targets:
		item.takeDamage(source, damage, damageType)
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
