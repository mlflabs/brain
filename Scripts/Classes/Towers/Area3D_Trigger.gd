extends Area3D
class_name area3d_trigger

#trigger on player enter, leave
@export var player_triger:bool = true

signal trigger(enter:bool)

func _ready():
	# Connect the body_entered signal to the _on_body_entered function in this script
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	body_shape_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if !player_triger:
		return
	
	if body is Player:
		trigger.emit(true)
	
	
func _on_body_exited(body):
	if !player_triger:
		return
	
	if body is Player:
		trigger.emit(false)
