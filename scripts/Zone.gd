extends KinematicBody2D

onready var collision = $ZoneCollision
onready var hitbox = $ZoneCollision/CollisionShape2D
onready var sprite = $Sprite
onready var durationTimer = $DurationTimer
onready var castTimer = $CastTimer

signal partyMemberEntered(position)
signal partyMemberExited
signal playerThreat(value)

export var attackName : String
export(NodePath) var source = null
export var damage = 0
export var damageType = ""
export var duration = 0.0
export var castTime = 0.0
export var hitboxRadius = 0
export var speed = 0.0
export var tracking = false
export var missileCount = 0
export var firingArc = 0.0
export var size = 0
export (Array, String) var additionalEffects

export var spriteTexture : Texture
export var castTexture : Texture

var target
var targets = []
var playerThreatened = false

func _ready():
	if source.get_meta("type") == "party" or source.get_meta("type") == "player":
		collision.set_collision_mask_bit(2, true)
	if source.get_meta("type") == "baddie":
		collision.set_collision_mask_bit(0, true)
		collision.set_collision_mask_bit(1, true)
	
	global_position = target.global_position
	sprite.texture = castTexture
	set_meta("type", "zone")
	hitbox.shape.radius = hitboxRadius
	durationTimer.wait_time = duration
	castTimer.wait_time = castTime
	if castTime > 0:
		#hitbox.disabled = true
		castTimer.start()
	else:
		durationTimer.start()

func _physics_process(delta):
	if tracking == true:
		if is_instance_valid(target):
			var targetPosition = target.global_position
			var moveDirection = Follow.followSmooth(Vector2(0, 0), global_position, targetPosition, speed)
			move_and_slide(moveDirection)

func _on_DurationTimer_timeout():
	if castTime == 0:
		for item in targets:
			item.takeDamage(source, global_position, damage, damageType, additionalEffects)
	emit_signal("partyMemberExited")
	queue_free()

func _on_CastTimer_timeout():
	#hitbox.disabled = false
	sprite.texture = spriteTexture
	durationTimer.start()
	for item in targets:
		item.takeDamage(source, global_position, damage, damageType, additionalEffects)

func _on_ZoneCollision_body_entered(body):
	if body.get_meta("type") == "player":
		emit_signal("playerThreat", true)
		playerThreatened = true
	if body.get_meta("type") == "party":
		print("here")
		connect("partyMemberEntered", body, "avoid")
		connect("partyMemberExited", body, "stopAvoid")
		connect("playerThreat", body, "setPlayerThreatened")
		emit_signal("partyMemberEntered", global_position)
	targets.append(body)

func _on_ZoneCollision_body_exited(body):
	if body.get_meta("type") == "player":
		emit_signal("playerThreat", false)
		playerThreatened = true
	if body.get_meta("type") == "party":
		emit_signal("partyMemberExited")
	targets.erase(body)
