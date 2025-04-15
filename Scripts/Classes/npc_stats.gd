extends Node
class_name NpcStats

const KEY_LIFE:String = "prop_life"
const KEY_STRENGTH:String = "prop_strength"

@export var BB:BrainBoard
@export var npc:Npc
@export var life:int = 2
@export var strength:int = 1




func _ready() -> void:
	set_strength(strength)
	set_life(life)

func change_life(value:int):
	life += value
	if life < 0: life = 0
	set_life(life)

func set_life(value:int):
	life = value
	if life <= 0:
		npc.remove()
		return
	BB.blackboard.set(KEY_LIFE, life)

func set_strength(value:int):
	strength = value
	if strength < 0:
		strength = 0
	BB.blackboard.set(KEY_STRENGTH, strength)


func remove_life(value:int):
	change_life(-value)
