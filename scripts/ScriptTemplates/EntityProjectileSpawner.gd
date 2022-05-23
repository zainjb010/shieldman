extends Node2D

var bulletObject = preload("res://objects/ObjectTemplates/Bullet.tscn")

func _ready():
	pass

func fire(sprite, hitboxRadius, direction):
	var bullet = bulletObject.instance()
	bullet.bulletDirection = direction
	bullet.sprite = sprite
	add_child(bullet)
