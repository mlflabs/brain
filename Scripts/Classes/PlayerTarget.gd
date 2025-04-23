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
			if t2 is NpcSmart:
				t2.set_action(Utils.ActionStates.Work, Utils.ResourceTypes.Wood, false)
		targets.clear()
		PlayerManager.player_targets_cleared.emit()
		sender.stop()
		return
	
	if t is PlayerCommandSensor:
		t.action()
		sender.stop()
		return
	

func clear_argets():
	targets.clear()
	PlayerManager.player_targets_cleared.emit()
