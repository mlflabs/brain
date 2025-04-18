extends Node3D
class_name NpcSelector

var selected:bool = false



@export var BB: BrainBoard
@export var npc:Npc


func _ready() -> void:
	PlayerManager.player_targer_added.connect(player_target_added)
	PlayerManager.player_targets_cleared.connect(player_targets_cleared)
	state_changed(selected)

func player_target_added(target):
	if selected:
		return
	if target == npc:
		state_changed(true)
		



func player_targets_cleared():
	state_changed(false)
	
func state_changed(state):
	selected = state
	BB.blackboard.set(PropertyManager.KEY_SELECTED, selected)
	self.visible = selected
