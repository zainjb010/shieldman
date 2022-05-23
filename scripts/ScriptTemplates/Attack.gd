extends Node

#Stores data for a given attack
export var attackName = ""
export var type = ""
export var speed = 0
export var missileCount = 0
export var cooldown = 0
export var hitboxRadius = 0
export var duration = 0
export var sprite : Texture

onready var timer = $Timer

signal attackReady(node)

func _ready():
	timer.wait_time = cooldown

func _on_Timer_timeout():
	emit_signal("attackReady", self)
	pass
