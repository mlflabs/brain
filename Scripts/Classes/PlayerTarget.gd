extends Node
class_name PlayerTargetManager

@export var player:Player


var targets = []



func add_target(t, sender):
	
	
	if t is NpcSmart:
		if targets.has(t):
			return
		targets.append(t)
		PlayerManager.player_targer_added.emit(t)
		sender.stop()
		return
	
	if t is StaticInteractableTree:
		for t2 in targets:
			t2.set_action(Utils.ActionStates.Work, Utils.ResourceTypes.Wood, false)
		targets.clear()
		PlayerManager.player_targets_cleared.emit()
		sender.stop()
		return
	
	if t is PlayerCommandSensor:
		if !targets.is_empty():
			if t == targets[0]: 
				return
			targets[0].set_node_visible(false)
			targets.clear()
		targets.append(t)
		t.set_node_visible(true)
		sender.stop()
		return
	

func clear_argets():
	targets.clear()
	PlayerManager.player_targets_cleared.emit()
