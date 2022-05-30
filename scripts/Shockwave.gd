extends Area2D

onready var hitbox = $CollisionShape2D
onready var sprite = $Sprite
onready var durationTimer = $Timer
onready var left = $Left
onready var leftMiddle = $LeftMiddle
onready var rightMiddle = $RightMiddle
onready var right = $Right

export(NodePath) var source = null
export var damage = 0
export var damageType = ""
export var duration = 0
export var speed = 0.0
export (Array, String) var additionalEffects

var spriteTexture
var size: = Vector2(0, 0)
var direction: = Vector2(0, 0)

func _ready():
	hitbox.shape.extents = size
	left.position.y = size.y * -1
	leftMiddle.position.y = size.y * -.5
	rightMiddle.position.y = size.y * .5
	right.position.y = size.y
	rotation = get_angle_to(direction)
	#position.x = size.x
	sprite.texture = spriteTexture
	set_meta("type", "wave")
	durationTimer.wait_time = duration
	durationTimer.start()
		
func _on_Timer_timeout():
	queue_free()

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
