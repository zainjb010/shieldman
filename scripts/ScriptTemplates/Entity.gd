extends KinematicBody2D

#Template to be used for entities that interact with the combat system
const attackPath = "res://resources/Attacks"
var attackObject = preload("res://objects/ObjectTemplates/Attack.tscn")

onready var globalData = get_tree().get_root().get_node("GlobalNode")

onready var recovery = $Recovery
onready var sprite = $Sprite
onready var attacks = $Attacks
onready var entityCollision = $EntityCollision
onready var projectileSpawner = $ProjectileSpawner
onready var stateMachine = $StateMachine
onready var ranges = $Ranges
onready var ui = $UI

var lookDirection = "down"
var moveTarget = null
var currentTarget = null
var moveDirection = Vector2(0, 0)
var attackDirection = Vector2(0, 0)
var previousPosition = Vector2(0, 0)
var availableAttacks = []
var canAttack = true
var isStunned = false

#This variable holds the resource containing the entity's stats
export (Resource) var stats

export var health = 0
var currentHealth = 0
export var speed = 500

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
		currentHealth = stats.health
		ui.healthBar.updateBar(100 * (currentHealth / health))
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
		newAttack.attackName = attack.name
		newAttack.sprite = attack.sprite
		newAttack.type = attack.type
		newAttack.damage = attack.damage
		newAttack.damageType = attack.damageType
		newAttack.speed = attack.speed
		newAttack.missileCount = attack.missileCount
		newAttack.cooldown = attack.cooldown
		newAttack.hitboxRadius = attack.hitboxRadius
		newAttack.firingArc = attack.firingArc
		newAttack.duration = attack.duration
		newAttack.size = attack.size
		newAttack.connect("attackReady", self, "refreshAttack")
		attacks.add_child(newAttack)
		#Append the new attack to the list of available attacks; this may become optional
		availableAttacks.append(newAttack)

func move(direction, scale = 1):
	previousPosition = global_position
	return move_and_slide(speed * direction * scale)

func selectAttack():
	#Searches list of available attacks; returns the attack with longest cooldown
	var selected = null
	if availableAttacks.empty():
		return null
	for item in availableAttacks:
		#Prefer the attack with the longest cooldown
		if selected == null or item.cooldown > selected.cooldown:
			selected = item
	return selected

func refreshAttack(attackNode):
	#Function for returning an attack to the available list
	#Accepts an Attack Node
	availableAttacks.append(attackNode)
	pass

func attack(attackNode):
	#Uses the given Attack Node to generate the proper attack in the projectile spawner
	if attackNode == null or canAttack == false:
		return
	#Use the given attack and remove it from the list of available attacks
	canAttack = false
	recovery.start()
	projectileSpawner.fire(
		self,
		attackNode,
		attackDirection
	)
		
	#Start the attack's cooldown timer and remove it from the list of available attacks
	attackNode.timer.start()
	availableAttacks.erase(attackNode)
	pass

func takeDamage(source: Node, direction : Vector2, amount: int, type: String, additionalEffects : Array) -> int:
	#Placeholder function
	#Takes the amount of damage, and the type of damage (for typed reduction/armor)
	#Returns the actual amount of damage taken
	if type == "aggro":
		amount = 0
	currentHealth = currentHealth - amount
	ui.healthBar.updateBar(100 * (float(currentHealth) / float(health)))
	if currentHealth <= 0:
		die()
	for item in additionalEffects:
		if item == "push":
			moveDirection = direction.normalized()
			stateMachine.changeState("knockback")
	#Update health bar here
	return amount

func die():
	queue_free()

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

func _on_Recovery_timeout():
	canAttack = true
