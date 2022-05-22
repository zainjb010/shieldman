extends Area2D

var nearbyEnemies = []

var closestEnemy = null

func _ready():
	pass # Replace with function body.

func _process(delta):
	closestEnemy = findClosestCanvasItemInArray(global_position, nearbyEnemies)
	

#handles aiming at closest enemies
#Move this to a base class later
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



func _on_magicboltarea_body_entered(body):
	var type = body.get_meta("type")
	if type == "baddie":
		nearbyEnemies.append(body)
	

func _on_magicboltarea_body_exited(body):
	var type = body.get_meta("type")
	if type == "baddie":
		nearbyEnemies.erase(body)
