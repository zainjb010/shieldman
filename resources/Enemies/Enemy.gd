extends Resource

class_name Enemy

export var name : String = ""
export var type : String = "baddie"

export var sprite : Texture

export var health : int
export var speed : float
export var collisionRadius : float
export var attackRadius : float
export var detectRadius: float

export (Array, Resource) var attacks
