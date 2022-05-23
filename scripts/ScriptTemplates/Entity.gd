extends KinematicBody2D

#Template to be used for entities that interact with the combat system

onready var globalData = get_tree().get_root().get_node("GlobalNode")

onready var entityCollision = $EntityCollision
onready var projectileSpawner = $ProjectileSpawner
onready var attackRange = $Range

var currentTarget = null
var moveDirection = Vector2(0, 0)
var previousPosition = Vector2(0, 0)

export var health = 0
export var attacks = []
export var speed = 500
export var collisionRadius = 32
export var detectionRadius = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	entityCollision.shape.radius = collisionRadius
	attackRange.area.shape.radius = detectionRadius

func move(direction):
	previousPosition = global_position
	move_and_slide(speed * moveDirection)

func attack():
	pass
