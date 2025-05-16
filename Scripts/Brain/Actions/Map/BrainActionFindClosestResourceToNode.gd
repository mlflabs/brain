extends BrainAction
class_name BrainActionFindClosestResourceToNode


@export var type: Utils.ResourceTypes
@export var node:Node3D
#node with target property
@export var target_save_node:Node3D
@export var max_distance:float = 10

var state: Utils.FlowStates

var target: StaticInteractableItem

func on_enter():
	state = Utils.FlowStates.Start

func tick(_delta:float):
	match  state:
		Utils.FlowStates.Start:
			target = MapManager.level.find_closest_resource(node.global_position, type)
			state = Utils.FlowStates.Finished
		Utils.FlowStates.Finished:
			if target == null:
				return parent.on_result(false)
			if !is_instance_valid(target):
				return parent.on_result(false)
			if node.global_position.distance_squared_to(node.global_position) > max_distance:
				return parent.on_result(false)
			target_save_node.target = target
			return parent.on_result(true)
