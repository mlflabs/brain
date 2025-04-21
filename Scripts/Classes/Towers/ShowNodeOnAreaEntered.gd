extends Area3D
class_name ShowNodeOnAreaEnter

@export var node: Node3D 
@export var set_visible:bool = true
var collable 

func _ready():
	# Connect the body_entered signal to the _on_body_entered function in this script
	area_entered.connect(_on_body_entered)
	area_exited.connect(_on_body_exited)
	node.visible = false


func _on_body_entered(body):
	if body is PlayerActionArea3D and set_visible:
		node.visible = true
	
func _on_body_exited(body):
	if body  is PlayerActionArea3D and !set_visible:
		node.visible = false
