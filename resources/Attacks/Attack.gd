extends Resource

#Contains all variables defining an attack
class_name Attack

export var name : String = ""
#Valid Types: missile, zone
export var type : String = ""

export var sprite : Texture

export var damage : int
export var damageType : String = ""
export var speed : float
export var missileCount : int
export var cooldown : float
export var hitboxRadius : float
export var duration : float
