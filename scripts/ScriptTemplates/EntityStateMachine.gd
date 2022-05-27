extends Node

signal stateChanged(currentState)

#The starting state must be identified
#The states map must be defined
export(NodePath) var START_STATE
var statesMap = {}

var statesStack = []
var currentState = null
var active = false setget setActive

func _ready():
	for child in get_children():
		child.connect("finished", self, "changeState")
	initialize(START_STATE)
	
func initialize(startState):
	setActive(true)
	statesStack.push_front(get_node(startState))
	currentState = statesStack[0]
	currentState.enter()
	
func setActive(value):
	active = value
	set_physics_process(value)
	set_process_input(value)
	if !active:
		statesStack = []
		currentState = null
		
func _physics_process(delta):
	currentState.update(delta)
	
func changeState(stateName):
	if !active:
		return
	currentState.exit()
	
	if stateName == "previous":
		statesStack.pop_front()
	else:
		statesStack[0] = statesMap[stateName]
		
	currentState = statesStack[0]
	emit_signal("stateChanged", currentState)
	
	if stateName != "previous":
		currentState.enter()

func updateLookDirection(direction):
	#direction = direction.normalized()
	if direction.y > 0:
		return "down"
	if direction.y < 0:
		return "up"
	if direction.x > 0:
		return "right"
	if direction.x < 0:
		return "left"
