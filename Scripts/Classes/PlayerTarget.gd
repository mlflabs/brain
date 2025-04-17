extends Node
class_name PlayerTargetManager

@export var player:Player


var targets = []



func add_target(t):
	
	if !targets.is_empty():
		if typeof(t) == typeof(targets[0]):
			targets.append(t)
		return
		
	if t is NpcSmart:
		targets.append(t)
		PlayerManager.player_targer_added.emit(t)
		

func clear_argets():
	targets.clear()
	PlayerManager.player_targets_cleared.emit()
