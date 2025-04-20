extends Node
class_name LevelScene

@export
var items : Array[StaticInteractableItem] = []


func _ready():
	MapManager.level = self

func register_item(item: StaticInteractableItem) ->void:
	items.append(item)

func remove_item(item: StaticInteractableItem) ->void:
	items.erase(item)
