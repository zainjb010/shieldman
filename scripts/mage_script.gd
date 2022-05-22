extends KinematicBody2D


var currentTarget = null

onready var attackRange = $Range

onready var bulletSpawner = $BulletSpawner


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if attackRange.closestEnemy != null:
		currentTarget = attackRange.closestEnemy
	if currentTarget == null or ! is_instance_valid(currentTarget):
		bulletSpawner.direction = Vector2(0, 0)
		return
	if is_instance_valid(currentTarget):
		var firingDirection = global_position.direction_to(currentTarget.global_position)
		bulletSpawner.direction = firingDirection
		
