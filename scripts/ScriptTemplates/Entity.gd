extends KinematicBody2D

#Template to be used for entities that interact with the combat system
const attackPath = "res://resources/Attacks"
var attackObject = preload("res://objects/ObjectTemplates/Attack.tscn")

onready var globalData = get_tree().get_root().get_node("GlobalNode")

onready var sprite = $Sprite
onready var attacks = $Attacks
onready var entityCollision = $EntityCollision
onready var projectileSpawner = $ProjectileSpawner
onready var ranges = $Ranges
#onready var attackRange = $Range
#onready var detectRange = $Detection

var currentTarget = null
var moveDirection = Vector2(0, 0)
var attackDirection = Vector2(0, 0)
var previousPosition = Vector2(0, 0)
var availableAttacks = []

#This variable holds the resource containing the entity's stats
export (Resource) var stats

export var health = 0
export var speed = 500
#export var collisionRadius = 32
#export var detectionRadius = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("type", "entity")
	initialize()

func initialize():
	#set variables based on resource
	if stats != null:
		set_meta("type", stats.type)
		sprite.texture = stats.sprite
		health = stats.health
		speed = stats.speed
		entityCollision.shape.radius = stats.collisionRadius
		ranges.attackRangeCollision.shape.radius = stats.attackRadius
		ranges.detectionRangeCollision.shape.radius = stats.detectRadius
		for attack in stats.attacks:
			addAttack(attack.name)
	
func addAttack(attackName):
	#Add an attack to the unit's list of attacks
	var attack = attackPath + "/" + attackName.replace(" ", "") + ".tres"
	for item in attacks.get_children():
		if item.attackName == attackName:
			return
	if ResourceLoader.exists(attack):
		#Instantiate an attack object for the attack
		attack = load(attack)
		var newAttack = attackObject.instance()
		newAttack.sprite = attack.sprite
		newAttack.type = attack.type
		newAttack.attackName = attack.name
		newAttack.speed = attack.speed
		newAttack.missileCount = attack.missileCount
		newAttack.cooldown = attack.cooldown
		newAttack.hitboxRadius = attack.hitboxRadius
		newAttack.duration = attack.duration
		newAttack.connect("attackReady", self, "refreshAttack")
		attacks.add_child(newAttack)
		#Append the new attack to the list of available attacks; this may become optional
		availableAttacks.append(newAttack)

func move(direction):
	previousPosition = global_position
	move_and_slide(speed * moveDirection)

func selectAttack():
	var selected = null
	if availableAttacks.empty():
		return null
	for item in availableAttacks:
		#Prefer the attack with the longest cooldown
		if selected == null or item.cooldown > selected.cooldown:
			selected = item
	return selected

func refreshAttack(attackNode):
	availableAttacks.append(attackNode)
	pass

func attack(attackNode):
	if attackNode == null:
		return
	#Use the given attack and remove it from the list of available attacks
	if attackNode.type == "missile":
		projectileSpawner.fire(
			attackNode.sprite, 
			attackNode.hitboxRadius, 
			attackDirection, 
			attackNode.duration,
			get_meta("type")
			)
		
	attackNode.timer.start()
	availableAttacks.erase(attackNode)
	pass

func takeDamage(amount, type):
	queue_free()
	pass

#Handles finding closest enemies to the entity
func findClosestCanvasItemInArray(globalPosition: Vector2, canvasItems: Array) -> CanvasItem:
	assert(canvasItems != null)

	var closestCanvasItem = null
	var closestDistanceSquared = INF

	for canvasItem in canvasItems:
		assert(canvasItem is CanvasItem)

		var distanceSquared = globalPosition.distance_squared_to(canvasItem.global_position)

		if not closestCanvasItem or distanceSquared < closestDistanceSquared:
			closestCanvasItem = canvasItem
			closestDistanceSquared = distanceSquared

	return closestCanvasItem
