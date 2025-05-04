extends Node
class_name TriggeredCountdown


@export var progress: RadialProgress
@export var amount_per_second:float = 1
@export var total_amount:float = 2

var amount:float = 0
var active:bool = false

@export var trigger: area3d_trigger

signal success()


func _ready():
	trigger.trigger.connect(on_trigger_on)
	
func _process(delta):
	if !active:
		return
		
	amount += delta * amount_per_second
	
	progress.progress = amount / total_amount * 100
	print(progress.progress, ", ", amount, ", ", total_amount)
	
	if amount > total_amount:
		success.emit()


func on_trigger_on(on:bool):
	
	if on:
		if active:
			return
		amount = 0
		active= true
	else:
		if !active:
			return
		amount = 0
		active = false
