extends Node2D

var bulletObject = preload("res://objects/ObjectTemplates/Bullet.tscn")

func _ready():
	pass

#func fire(source: Node, sprite : Texture, hitboxRadius : float, direction : Vector2, duration : float):
func fire(source: Node, attack: Node, direction: Vector2):
	#Using an attack's parameters, generates the proper projectile and gives it parameters
	var projectile
	if attack.type == "missile":
		projectile = bulletObject.instance()
		projectile.source = source
		projectile.bulletDirection = direction
		projectile.sprite = attack.sprite
		projectile.duration = attack.duration
		projectile.damage = attack.damage
		if source.get_meta("type") == "party" or source.get_meta("type") == "player":
			projectile.set_collision_mask_bit(2, true)
		if source.get_meta("type") == "baddie":
			projectile.set_collision_mask_bit(0, true)
			projectile.set_collision_mask_bit(1, true)
		add_child(projectile)
