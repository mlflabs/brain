extends Area3D
class_name PlayerCommandSensor

@export var node: Node3D 
@export var root:Node
@export var on_ready_visible:bool = false
@export var sensor_name:String

func _ready() -> void:
	node.visible = on_ready_visible

func action(node):
	node.visible = !node.visible

func set_node_visible(on:bool):
	node.visible = on
	
