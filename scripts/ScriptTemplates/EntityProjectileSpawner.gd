extends Node2D

var bulletObject = preload("res://objects/ObjectTemplates/Bullet.tscn")
var auraObject = preload("res://objects/ObjectTemplates/Aura.tscn")
var meleeObject = preload("res://objects/ObjectTemplates/Melee.tscn")
var waveObject = preload("res://objects/ObjectTemplates/Wave.tscn")
var zoneObject = preload("res://objects/ObjectTemplates/Zone.tscn")

func _ready():
	pass

#func fire(source: Node, sprite : Texture, hitboxRadius : float, direction : Vector2, duration : float):
func fire(source: Node, attack: Node, direction: Vector2):
	#Using an attack's parameters, generates the proper projectile and gives it parameters
	var projectile
	if attack.type == "instant":
		owner.currentTarget.takeDamage(source, global_position, attack.damage, attack.type)
		return
		
	if attack.type == "missile":
		projectile = bulletObject.instance()
		projectile.bulletDirection = direction
	if attack.type == "aura":
		projectile = auraObject.instance()
	if attack.type == "melee":
		projectile = meleeObject.instance()
	if attack.type == "wave":
		projectile = waveObject.instance()
	if attack.type == "zone":
		projectile = zoneObject.instance()
		projectile.target = owner.currentTarget.global_position
		
	projectile.source = source
	projectile.attackName = attack.name
	projectile.spriteTexture = attack.sprite
	projectile.damage = attack.damage
	projectile.damageType = attack.damageType
	projectile.speed = attack.speed
	projectile.missileCount = attack.missileCount
	projectile.hitboxRadius = attack.hitboxRadius
	projectile.firingArc = attack.firingArc
	projectile.duration = attack.duration
	projectile.size = attack.size
		
	projectile.additionalEffects = attack.additionalEffects
		
	if source.get_meta("type") == "party" or source.get_meta("type") == "player":
		projectile.set_collision_mask_bit(2, true)
	if source.get_meta("type") == "baddie":
		projectile.set_collision_mask_bit(0, true)
		projectile.set_collision_mask_bit(1, true)
	add_child(projectile)
