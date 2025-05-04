extends Node3D


@export var tp: TowerParent
@export var trigger:TriggeredCountdown

var ps: PackedScene = preload("res://Scenes/towers/tower_ballista_1.tscn")

func _ready():
	trigger.success.connect(on_success)

func on_success():
	tp.build(ps)

	
