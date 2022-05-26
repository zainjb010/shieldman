extends Node

const DEFAULT_MASS: = 2.0
const DEFAULT_MAX_SPEED: = 400.0
const DEFAULT_SLOW_RADIUS = 100.0

#Function for smooth tracking of a given target
static func follow(
	velocity: Vector2,
	global_position: Vector2,
	target_position: Vector2,
	maxSpeed: = DEFAULT_MAX_SPEED,
	mass: = DEFAULT_MASS
) -> Vector2:
	var newVelocity = ((target_position - global_position).normalized() * maxSpeed)
	var dampening = (newVelocity - velocity) / mass
	return velocity + dampening

static func followSmooth(
	velocity: Vector2,
	global_position: Vector2,
	target_position: Vector2,
	maxSpeed: = DEFAULT_MAX_SPEED,
	slowRadius: = DEFAULT_SLOW_RADIUS,
	mass: = DEFAULT_MASS
) -> Vector2:
	var toTarget: = global_position.distance_to(target_position)
	var newVelocity: = (target_position - global_position).normalized() * maxSpeed
	if toTarget < slowRadius:
		newVelocity *= (toTarget / slowRadius) * 0.8 + 0.2
		
	var dampening = (newVelocity - velocity) / mass
	return velocity + dampening
