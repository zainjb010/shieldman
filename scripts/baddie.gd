extends KinematicBody2D

onready var globalData = get_tree().get_root().get_node("GlobalNode")

export var speed = 100

var velocity = Vector2(0, 0)

func _ready():
	set_meta("type", "baddie")

func _physics_process(delta):
	var moveDirection = global_position.direction_to(globalData.playerPosition)
	
	move_and_slide(speed * moveDirection)
	

func take_damage():
	queue_free()
