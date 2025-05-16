extends BrainConsideration
class_name BF_FindResource

@export var bb:BrainBoard
@export var position_node:Node3D
@export var max_distance:float = INF
@export var type: Utils.ResourceTypes


@export var resource_key: String = "resource"



@export var curve : Curve

func get_score():

	var target = MapManager.level.find_closest_resource(position_node.global_position, type, max_distance)
	
	if !is_instance_valid(target):
		target = null
	
	bb.set_value(resource_key, target)

	return -1
	
