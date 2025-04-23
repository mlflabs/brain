extends Node3D
class_name BuildTowerSelection

@export var tower:Tower


@onready var mesh = $mesh
@onready var  marker = $mesh/selection


func set_selected(s:bool):
	marker.visible = s
