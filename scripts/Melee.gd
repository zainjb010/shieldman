extends Area2D

#I'm not completely sure of this implementation; I may scrap it or heavily rework it

var direction = Vector2(0, 0)
var distance = 0
var angle = 0
var timeout = false

onready var hitbox = $CollisionShape2D
onready var sprite = $Sprite
onready var durationTimer = $Timer

export var attackName : String
export(NodePath) var source = null
export var damage = 0
export var damageType = ""
export var speed = 0.0
export var firingArc = 0
export var duration = 0
export var missileCount = 0
export var hitboxRadius = 0
export var size = 0
export (Array, String) var additionalEffects

var targets = []
var spriteTexture

func _ready():
	sprite.texture = spriteTexture
	set_meta("type", "melee")
	hitbox.shape.radius = hitboxRadius
	angle = source.position.angle_to(direction)
	#print(rad2deg(angle))
	#angle = angle - (deg2rad(firingArc / 2))
	#print(rad2deg(angle))
	distance = source.ranges.attackRangeCollision.shape.radius - hitboxRadius
	#position = Vector2(cos(angle), sin(angle)) * distance
	position.x += distance
	get_parent().set_rotation(angle)
	angle = angle + deg2rad(firingArc * 1.5)
	#print(rad2deg(angle))
	
	durationTimer.wait_time = duration
	durationTimer.start()
	var delay = Timer.new()
	delay.wait_time = .5
	delay.connect("timeout", self, "delay")

func _physics_process(delta):
	#Rotate the object around the entity
	for item in targets:
		item.takeDamage(source, direction, damage, damageType, additionalEffects)
		targets.erase(item)
	get_parent().rotate(deg2rad(speed * delta))
	#print(rad2deg(get_parent().get_rotation()), " ", rad2deg(angle), " ", rad2deg(get_parent().get_rotation()) - rad2deg(angle))
	if abs(rad2deg(get_parent().get_rotation()) - rad2deg(angle)) <= 2: #and timeout == true:
		print(angle, " ", deg2rad(firingArc / 2), " ", get_parent().get_rotation())
		get_parent().set_rotation(0)
		queue_free()
	pass

func delay():
	timeout = true

func _on_Melee_body_entered(body):
	targets.append(body)

func _on_Timer_timeout():
	get_parent().set_rotation(0)
	queue_free()
