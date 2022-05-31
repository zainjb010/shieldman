extends "res://scripts/ScriptTemplates/EntityStateMachine.gd"

func _ready():
	statesMap = {
		"idle": $Idle,
		"move": $Move,
		"attack": $Attack,
		"knockback": $Knockback
	}

func changeState(stateName):
	#Handle which states are pushed onto the automaton
	.changeState(stateName)
