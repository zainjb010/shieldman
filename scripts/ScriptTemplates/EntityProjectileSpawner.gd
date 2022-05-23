extends Node2D

var bulletObject = preload("res://objects/ObjectTemplates/Bullet.tscn")

func _ready():
	pass

func fire(sprite : Texture, hitboxRadius : float, direction : Vector2, duration : float, entityType : String):
	#Using an attack's parameters, generates the proper projectile and gives it parameters
	var bullet = bulletObject.instance()
	bullet.bulletDirection = direction
	bullet.sprite = sprite
	bullet.duration = duration
	if entityType == "party" or entityType == "player":
		bullet.set_collision_mask_bit(2, true)
	if entityType == "baddie":
		bullet.set_collision_mask_bit(0, true)
		bullet.set_collision_mask_bit(1, true)
	add_child(bullet)
