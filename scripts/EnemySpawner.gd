extends Node

onready var gameData = get_tree().get_root().get_node("Game")
onready var timer = $Timer
var rng = RandomNumberGenerator.new()

var enemyObject = preload("res://objects/Actors/Enemy.tscn")
var enemyResource = "res://resources/Enemies/BasicEnemy.tres"

func _ready():
	rng.randomize()
	timer.start()
	
func spawnEnemy():
	#Spawn 1 - 3 enemies on one side of the screen
	
	var rand
	var count
	var position
	
	count = rng.randi_range(1, 3)
	rand = rng.randi_range(0, 3)
	for i in count:
		var spawn = enemyObject.instance()
		spawn.stats = load(enemyResource)
		add_child(spawn)
		#These positions aren't accurate for now
		if rand == 0:
			#Top of screen
			position = (1024 / 2) - (120 * count) + (i * 120)
			spawn.global_position = Vector2(position, 80)
		if rand == 1:
			#Left
			position = (600 / 2) - (120 * count) + (i * 120)
			spawn.global_position = Vector2(80, position)
		if rand == 2:
			#Bottom
			position = (1024 / 2) - (120 * count) + (i * 120)
			spawn.global_position = Vector2(position, 1024 - 80)
		if rand == 3:
			#Right
			position = (600 / 2) - (120 * count) + (i * 120)
			spawn.global_position = Vector2(600 - 80, position)
	pass

func _on_Timer_timeout():
	spawnEnemy()
	timer.start()
	pass
