extends Node
class_name LevelScene

@export
var items : Array[LevelItem] = []




func register_item(item: LevelItem) ->void:
	items.append(item)
