extends Resource

#Contains all variables defining a projectile attack
class_name ProjectileAttack

export var name : String = ""
#Valid Types: missile,
export var type : String = ""

export var sprite : Texture

export var damage : int
export var speed : float
export var missileCount : int
export var cooldown : float
export var hitboxRadius : float
export var duration : float
