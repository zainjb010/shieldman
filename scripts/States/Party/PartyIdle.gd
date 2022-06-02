extends "res://scripts/ScriptTemplates/State.gd"

var nextAttack = null

func enter():
	print("idling")

func update(delta):
	var attack = owner.selectAttack()
	if attack and attack != nextAttack:
		print(attack.attackName)
		nextAttack = attack
		owner.changeAttackRange(0)
		owner.changeAttackRange(nextAttack.rangeModifier)
	
	var currentTarget = owner.selectMoveTarget()
	if currentTarget:
		emit_signal("finished", "move")
		return
	currentTarget = owner.selectTarget()
	if currentTarget:
		emit_signal("finished", "attack")
