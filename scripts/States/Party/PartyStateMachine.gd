extends "res://scripts/ScriptTemplates/EntityStateMachine.gd"

func _ready():
	statesMap = {
		"idle": $Idle,
		"move": $Move,
		"attack": $Attack,
		"cast": $Cast
	}

func changeState(stateName):
	#Handle which states are pushed onto the automaton
	print(stateName)
	.changeState(stateName)
