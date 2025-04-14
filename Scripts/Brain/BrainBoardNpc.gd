#@icon("icons/blackboard.svg")
extends BrainBoard
class_name BrainBoardNpc

@export var nav_agent:NavigationAgent3D
@export var npc:Npc
@export var npc_anim:NpcAnim
@export var npc_model_root : Node3D




@export var speed := 5.0
@export var jump_velocity := 4.5
@export var rotation_speed := 6.0

func _ready():
	_data[DEFAULT] = blackboard
