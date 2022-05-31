extends Node

#Stores data for a given attack
export(Resource) var data = null

export var attackName = ""
export var type = ""
export var damage = 0
export var damageType = ""
export var speed = 0
export var tracking = false
export var missileCount = 0
export var cooldown = 0
export var hitboxRadius = 0
export var firingArc = 0
export var duration = 0
export var castTime = 0.0
export var size = Vector2(0, 0)

export var sprite : Texture
export var castSprite : Texture

export (Array, String) var additionalEffects

onready var refreshTimer = $Timer
onready var castTimer = $CastTimer

signal attackReady(node)

func _ready():
	if data:
		attackName = data.name
		type = data.type
		damage = data.damage
		damageType = data.damageType
		speed = data.speed
		tracking = data.tracking
		missileCount = data.missileCount
		cooldown = data.cooldown
		hitboxRadius = data.hitboxRadius
		duration = data.duration
		castTime = data.castTime
		size = data.size
		
		sprite = data.sprite
		castSprite = data.castSprite
		
		additionalEffects = data.additionalEffects
	refreshTimer.wait_time = cooldown
	castTimer.wait_time = castTime

func _on_Timer_timeout():
	if get_parent().get_parent().get_meta("type") == "party":
		print(attackName, " refreshed")
	emit_signal("attackReady", self)
	pass

func _on_CastTimer_timeout():
	if get_parent().get_parent().get_meta("type") == "party":
		print(attackName, " cast time complete ", castTime)
	refreshTimer.start()
