extends Area2D

func _on_Shield_body_entered(body):
	if body.get_meta("type") == "bullet":
		body.queue_free()
	pass

func _physics_process(delta):
	look_at(get_global_mouse_position())
