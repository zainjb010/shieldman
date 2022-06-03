extends Node2D

onready var projectileData = get_tree().get_root().get_node("GlobalNode/ProjectileManager")

var bulletObject = preload("res://objects/ObjectTemplates/Bullet.tscn")
#var auraObject = preload("res://objects/ObjectTemplates/Aura.tscn")
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
		owner.currentTarget.takeDamage(source, global_position, attack.damage, attack.type, attack.additionalEffects)
		return
		
	if attack.type == "missile":
		projectile = bulletObject.instance()
		projectile.bulletDirection = direction
	#if attack.type == "aura":
		#projectile = auraObject.instance()
	if attack.type == "melee":
		projectile = meleeObject.instance()
	if attack.type == "wave":
		projectile = waveObject.instance()
		if source.get_meta("type") == "player":
			projectile.direction = direction
		else:
			projectile.direction = owner.currentTarget.global_position
	if attack.type == "zone":
		projectile = zoneObject.instance()
		projectile.target = owner.currentTarget
		
	projectile.source = source
	projectile.attackName = attack.attackName
	
	projectile.spriteTexture = attack.sprite
	projectile.castTexture = attack.castSprite
	
	projectile.damage = attack.damage
	projectile.damageType = attack.damageType
	projectile.speed = attack.speed
	projectile.tracking = attack.tracking
	projectile.missileCount = attack.missileCount
	projectile.hitboxRadius = attack.hitboxRadius
	projectile.firingArc = attack.firingArc
	projectile.duration = attack.duration
	projectile.castTime = attack.castTime
	projectile.size = attack.size
		
	projectile.additionalEffects = attack.additionalEffects
		
	if source.get_meta("type") == "party" or source.get_meta("type") == "player":
		projectile.set_collision_mask_bit(2, true)
	if source.get_meta("type") == "baddie":
		projectile.set_collision_mask_bit(0, true)
		projectile.set_collision_mask_bit(1, true)
	#The projectile is added as a child to a different node, so that the attacks move independently from their sources
	projectileData.add_child(projectile)
