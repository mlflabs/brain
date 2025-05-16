extends Node3D
class_name ActionSensor

@onready var player : Player = $"../.."
@onready var sensor:Area3D = $Area3D

func _ready() -> void:
	sensor.body_entered.connect(on_body_entered)
	disable()



func on_body_entered(node):
	if node is enemy_pointer:
		disable()
		node.npc.damage(player.calculated_strength)
		player.target = node
		player.change_action(Utils.ActionStates.Attack)
		GlobalBoard.blackboard.set(PropertyManager.KEY_PLAYER_TARGET, node.npc)

	if node is StaticInteractableItem:
		node.damage(player.calculated_strength)
		player.target = node
		player.change_action(Utils.ActionStates.Work)
		disable()
		

func enable():
	sensor.monitoring = true
	
func disable():
	sensor.monitoring = false
