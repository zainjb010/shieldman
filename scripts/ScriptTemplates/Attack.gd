extends Node

#Stores data for a given attack
export(Resource) var data = null

export var attackName = ""
export var type = ""
export var damage = 0
export var damageType = ""
export var speed = 0
export var missileCount = 0
export var cooldown = 0
export var hitboxRadius = 0
export var firingArc = 0
export var duration = 0
export var sprite : Texture

onready var timer = $Timer

signal attackReady(node)

func _ready():
	if data:
		attackName = data.name
		type = data.type
		damage = data.damage
		damageType = data.damageType
		speed = data.speed
		missileCount = data.missileCount
		cooldown = data.cooldown
		hitboxRadius = data.hitboxRadius
		duration = data.duration
		sprite = data.sprite
	timer.wait_time = cooldown

func _on_Timer_timeout():
	emit_signal("attackReady", self)
	pass
