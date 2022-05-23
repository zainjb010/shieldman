extends KinematicBody2D

#Template to be used for entities that interact with the combat system
const attackPath = "res://resources/Attacks"
var attackObject = preload("res://objects/ObjectTemplates/Attack.tscn")

onready var globalData = get_tree().get_root().get_node("GlobalNode")

onready var sprite = $Sprite
onready var attacks = $Attacks
onready var entityCollision = $EntityCollision
onready var projectileSpawner = $ProjectileSpawner
onready var attackRange = $Range

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
	#entityCollision.shape.radius = collisionRadius
	#attackRange.area.shape.radius = detectionRadius
	initialize()

func initialize():
	#set variables based on resource
	if stats != null:
		sprite.texture = stats.icon
		health = stats.health
		speed = stats.speed
		entityCollision.shape.radius = stats.collisionRadius
		attackRange.area.shape.radius = stats.detectionRadius
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
		newAttack.cooldown = attack.cooldown
		newAttack.hitboxRadius = attack.hitboxRadius
		newAttack.connect("attackReady", self, "refreshAttack")
		attacks.add_child(newAttack)
		#Append the new attack to the list of available attacks; this may become optional
		availableAttacks.append(newAttack)

func move(direction):
	previousPosition = global_position
	move_and_slide(speed * moveDirection)

func selectAttack():
	print(availableAttacks)
	var selected = null
	for item in availableAttacks:
		#Prefer the attack with the longest cooldown
		if selected == null or item.cooldown > selected.cooldown:
			selected = item
	return selected

func refreshAttack(attackNode):
	availableAttacks.append(attackNode)
	pass

func attack(attackNode):
	print("here")
	#Use the given attack and remove it from the list of available attacks
	if attackNode.type == "ranged":
		projectileSpawner.fire(attackNode.sprite, attackNode.hitboxRadius, attackDirection)
		
	attackNode.timer.start()
	availableAttacks.erase(attackNode)
	pass
