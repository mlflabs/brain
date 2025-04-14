extends Node3D
class_name LevelItem


enum { FOOD, WOOD }


var levelId: int = -1
var level: LevelScene
var type = FOOD


func _ready() -> void:
	#register with parent
	var gotParent = false
	
	var p = get_parent()
	while(!gotParent):
		if p is LevelScene:
			p.register_item(self)
			level = p
			gotParent = true
		else:
			p = p.get_parent()
			
