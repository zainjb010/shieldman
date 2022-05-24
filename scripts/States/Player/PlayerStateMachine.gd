extends "res://scripts/ScriptTemplates/EntityStateMachine.gd"

func _ready():
	statesMap = {
		"idle": $Idle,
		"move": $Move
	}
	
func changeState(stateName):
	#Handle which states are pushed onto the automaton
	.changeState(stateName)
	
