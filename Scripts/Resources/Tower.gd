extends Resource
class_name Tower

@export var name: String = "Tower"
@export var type:Utils.TowerTypes = Utils.TowerTypes.None
@export var tower_stages:Array[TowerStage] = []
