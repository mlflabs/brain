extends Node


var player:Player


enum PlayerActions { None, Idle, Move, Attack, Wood }


#signals
signal player_targer_added(target)
signal player_targets_cleared()
signal player_action_added(action:PlayerActions)
