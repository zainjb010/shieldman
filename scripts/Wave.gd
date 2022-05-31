extends Area2D

onready var hitbox = $CollisionShape2D
onready var sprite = $Sprite
onready var durationTimer = $DurationTimer
onready var castTimer = $CastTimer
onready var left = $Left
onready var leftMiddle = $LeftMiddle
onready var rightMiddle = $RightMiddle
onready var right = $Right

export var attackName : String
export(NodePath) var source = null
export var damage = 0
export var damageType = ""
export var duration = 0.0
export var castTime = 0.0
export var speed = 0.0
export var tracking = false
export var missileCount = 0
export var firingArc = 0.0
export var hitboxRadius = 0.0
export (Array, String) var additionalEffects

export var spriteTexture : Texture
export var castTexture : Texture

var size: = Vector2(0, 0)
var direction: = Vector2(0, 0)

func _ready():
	hitbox.shape.extents = size
	left.position.y = size.y * -1
	leftMiddle.position.y = size.y * -.5
	rightMiddle.position.y = size.y * .5
	right.position.y = size.y
	rotation = source.get_angle_to(direction)
	global_position = source.global_position
	#position.x = size.x
	sprite.texture = castTexture
	set_meta("type", "wave")
	durationTimer.wait_time = duration
	castTimer.wait_time = castTime
	if castTime > 0:
		hitbox.disabled = true
		castTimer.start()
	else:
		durationTimer.start()
		
func _on_Timer_timeout():
	queue_free()

func _on_CastTimer_timeout():
	hitbox.disabled = false
	sprite.texture = spriteTexture
	durationTimer.start()

func _on_Shockwave_body_entered(body):
	var distance = global_position.distance_squared_to(body.global_position)
	var point = global_position
	if left.global_position.distance_squared_to(body.global_position) < distance:
		distance = left.global_position.distance_squared_to(body.global_position)
		point = left.global_position
	if right.global_position.distance_squared_to(body.global_position) < distance:
		distance = right.global_position.distance_squared_to(body.global_position)
		point = right.global_position
	if leftMiddle.global_position.distance_squared_to(body.global_position) < distance:
		distance = leftMiddle.global_position.distance_squared_to(body.global_position)
		point = leftMiddle.global_position
	if rightMiddle.global_position.distance_squared_to(body.global_position) < distance:
		distance = rightMiddle.global_position.distance_squared_to(body.global_position)
		point = rightMiddle.global_position
	body.takeDamage(source, body.global_position - point, damage, damageType, additionalEffects)
	pass # Replace with function body.
