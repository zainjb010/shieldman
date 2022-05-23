extends Area2D

onready var area = $CollisionShape2D

var nearbyEntities = []

func _ready():
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

func _on_Range_body_entered(body):
	var type = body.get_meta("type")
	if type == "baddie":
		nearbyEntities.append(body)

func _on_Range_body_exited(body):
	var type = body.get_meta("type")
	if type == "baddie":
		nearbyEntities.erase(body)
