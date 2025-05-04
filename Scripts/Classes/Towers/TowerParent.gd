extends Node3D
class_name TowerParent


@export var building_parent: Node


func build(ps:PackedScene):
	#remove all
	for child in building_parent.get_children():
		child.queue_free()
		
	#build
	var s = ps.instantiate()
	building_parent.add_child(s)
	
