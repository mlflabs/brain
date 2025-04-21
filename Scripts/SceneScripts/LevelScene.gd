extends Node
class_name LevelScene

@export
var items_all : Array[StaticInteractableItem] = []

@export var items_wood: Array[StaticInteractableItem] = []


func _ready():
	MapManager.level = self

func register_item(item: StaticInteractableItem) ->void:
	print("Item Registered: ", item, ", Type: ", item.type)
	items_all.append(item)
	if item.type == Utils.ResourceTypes.Wood:
		items_wood.append(item)

func remove_item(item: StaticInteractableItem) ->void:
	items_all.erase(item)
	if item.type == Utils.ResourceTypes.Wood:
		items_wood.erase(item)


func find_closest_resource(pos: Vector3, type:Utils.ResourceTypes) -> StaticInteractableItem:
	var items = items_all
	match type:
		Utils.ResourceTypes.Wood:
			items = items_wood
		_:
			items = items_all
	
	var closest_index:int = -1
	var closest_distance:float = INF
	var distance:float
	for	i in range(len(items)):
		distance = pos.distance_squared_to(items[i].global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_index = i
	
	if closest_index == -1:
		return null
	return items[closest_index]
	
	
	
	
	
