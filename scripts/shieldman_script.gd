extends KinematicBody2D

onready var globalData = get_tree().get_root().get_node("GlobalNode")

export var speed = 500

signal playerPosition(position)

var previousPosition = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("playerPosition", globalData, "updatePosition")

func _physics_process(delta):
	if global_position != previousPosition:
		emit_signal("playerPosition", global_position)
	var inputvector = Vector2 (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	var moveDirection = inputvector.normalized() #
	previousPosition = global_position
	move_and_slide(speed * moveDirection)
