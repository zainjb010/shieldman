extends KinematicBody2D

onready var playerdata = get_tree().get_root().get_node("globalnode")

export var speed = 500

signal playerposition (position)

var previousposition = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("playerposition", playerdata, "updateposition")

func _physics_process(delta):
	if global_position != previousposition:
		emit_signal("playerposition",global_position)
	var inputvector = Vector2 (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	var movedirection = inputvector.normalized() #
	previousposition = global_position
	move_and_slide(speed * movedirection)
