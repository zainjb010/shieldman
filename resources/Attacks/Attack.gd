extends Resource

#Contains all variables defining an attack
class_name Attack

export var name : String = ""
#Valid Types: missile, zone, wave, instant
export var type : String = ""

export var sprite : Texture
export var castSprite : Texture

export var damage : int
export var damageType : String = ""
export var speed : float
export var tracking : bool
export var missileCount : int
export var cooldown : float
export var hitboxRadius : float
export var firingArc : float
export var duration : float
export var castTime : float
export var size : Vector2

export (Array, String) var additionalEffects
