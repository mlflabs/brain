extends BrainAction
class_name BrainActionFindClosestResource


@export var type: Utils.ResourceTypes
@export var npc: NpcSmart
@export var max_distance:float = 10

var state: Utils.FlowStates

var target: StaticInteractableItem

func on_enter():
	state = Utils.FlowStates.Start

func tick(_delta:float):
	match  state:
		Utils.FlowStates.Start:
			target = MapManager.level.find_closest_resource(npc.global_position, type)
			state = Utils.FlowStates.Finished
		Utils.FlowStates.Finished:
			if target == null:
				return parent.on_result(false)
			if !is_instance_valid(target):
				return parent.on_result(false)
			if npc.global_position.distance_squared_to(target.global_position) > max_distance:
				return parent.on_result(false)
			npc.target = target
			return parent.on_result(true)
