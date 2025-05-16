extends Resource
class_name NpcStats

@export var life:int = 2
@export var strength:int = 1

@export var speed:float = 1




func _ready() -> void:
	set_strength(strength)


func set_strength(value:int):
	strength = value
	if strength < 0:
		strength = 0
