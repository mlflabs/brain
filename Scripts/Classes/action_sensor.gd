extends Node3D
class_name ActionSensor

@onready var player : Player = $"../.."
@onready var sensor:Area3D = $Area3D

func _ready() -> void:
	sensor.body_entered.connect(on_body_entered)
	disable()



func on_body_entered(node):
	if node is NpcWPCreeper:
		printerr("hitting creep")
		disable()
		node.npc_stats.remove_life(player.calculated_strength)
		PlayerManager.player_action_added.emit(PlayerManager.PlayerActions.Attack)
		GlobalBoard.blackboard.set(PropertyManager.KEY_PLAYER_TARGET, node)

	if node is StaticInteractableItem:
		node.damage(player.calculated_strength)
		PlayerManager.player_action_added.emit(PlayerManager.PlayerActions.Wood)
		disable()
		

func enable():
	sensor.monitoring = true
	
func disable():
	sensor.monitoring = false
