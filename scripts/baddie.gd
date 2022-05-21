extends KinematicBody2D

onready var playerdata = get_tree().get_root().get_node("globalnode")

export var speed = 100

var velocity = Vector2(0,0)

func _ready():
	set_meta("type","baddie")

func _physics_process(delta):
	var movedirection = global_position.direction_to(playerdata.playerposition)
	
	move_and_slide(speed * movedirection)
	

func take_damage():
	queue_free()
