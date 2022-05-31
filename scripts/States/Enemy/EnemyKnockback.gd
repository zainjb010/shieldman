extends "res://scripts/ScriptTemplates/State.gd"

var timer = Timer.new()

func enter():
	#Start a timer that determines how long to be knocked back
	timer.wait_time = .15
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	timer.start()
	
func update(delta):
	var collision = owner.move(owner.moveDirection * 10)
	
func timeout():
	emit_signal("finished", "idle")
