extends Node3D
class_name NpcSelector




@export var BB: BrainBoard
@export var npc:NpcSmart


func _ready() -> void:
	PlayerManager.player_targer_added.connect(player_target_added)
	PlayerManager.player_targets_cleared.connect(player_targets_cleared)
	state_changed(npc.selected)

func player_target_added(target):
	if npc.selected:
		return
	if target == npc:
		state_changed(true)
		



func player_targets_cleared():
	state_changed(false)
	
func state_changed(state:bool):
	npc.set_selected(state)
	BB.blackboard.set(PropertyManager.KEY_SELECTED, npc.selected)
	self.visible = npc.selected
