extends Node
class_name  Effect


@export var start_on_ready:bool = false

func _ready():
	if start_on_ready:
		start()

func start():
	pass
