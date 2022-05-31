extends Area2D

onready var hitbox = $CollisionShape2D
onready var sprite = $Sprite
onready var durationTimer = $DurationTimer
onready var castTimer = $CastTimer

export var attackName : String
export(NodePath) var source = null
export var damage = 0
export var damageType = ""
export var duration = 0.0
export var castTime = 0.0
export var hitboxRadius = 0
export var speed = 0.0
export var tracking = false
export var missileCount = 0
export var firingArc = 0.0
export var size = 0
export (Array, String) var additionalEffects

export var spriteTexture : Texture
export var castTexture : Texture

var target
var targets = []

func _ready():
	global_position = target.global_position
	sprite.texture = castTexture
	set_meta("type", "zone")
	hitbox.shape.radius = hitboxRadius
	durationTimer.wait_time = duration
	castTimer.wait_time = castTime
	if castTime > 0:
		hitbox.disabled = true
		castTimer.start()
	else:
		durationTimer.start()

func _physics_process(delta):
	if tracking == true:
		Follow.follow(Vector2(0, 0), global_position, target.global_position)

func _on_Zone_body_entered(body):
	targets.append(body)

func _on_Zone_body_exited(body):
	targets.erase(body)

func _on_DurationTimer_timeout():
	for item in targets:
		item.takeDamage(source, global_position, damage, damageType, additionalEffects)
	queue_free()

func _on_CastTimer_timeout():
	hitbox.disabled = false
	sprite.texture = spriteTexture
	durationTimer.start()
