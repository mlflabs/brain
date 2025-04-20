extends Npc
class_name NpcSmart

@export var action:PlayerManager.PlayerActions


func _ready() -> void:
	BB.blackboard.set("name", name)


func set_action(a: PlayerManager.PlayerActions) ->void:
	if a == action:
		return
	
	action = a
	interupt(self)
