extends Resource

class_name PartyMember

export var name : String = ""

export var icon : Texture

export var health : int
export var speed : float
export var collisionRadius : float
export var detectionRadius : float

export (Array, Resource) var attacks
