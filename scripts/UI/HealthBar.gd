extends TextureProgress
onready var tween = $Tween

func _ready():
	pass 

func updateBar(percentage):
	tween.interpolate_property(self, "value", self.value, percentage, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	yield($Tween, "tween_completed")
	pass
