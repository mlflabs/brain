extends Npc
class_name NpcSmart

@export var stats:NpcStats
#if 0, will be overwritten by stats.life
@export var life:int = 0

@export var selected: bool = false
@export var action: Utils.ActionStates
@export var resource: Utils.ResourceTypes
@export var nav_agent: NavigationAgent3D 
@export var npc_model_root : Node3D
@export var npc_selector: NpcSelector

func _ready() -> void:
	BB.blackboard.set("name", name)
	if life == 0:
		life = stats.life


func set_action(a: Utils.ActionStates, r:Utils.ResourceTypes, s:bool = false) ->void:
	if a == action and r == resource and s == selected:
		return
	
	action = a
	resource = r
	set_selected(s)
	interupt(self)

func set_selected(state:bool):
	if state == selected:
		return
	selected = state
	interupt(self)
	

func change_life(value:int):
	life += value
	if life < 0: life = 0
	set_life(life)
	print("LIVE changed to: ", life)

func set_life(value:int):
	life = value
	if life <= 0:
		remove()
		return
	BB.blackboard.set(PropertyManager.KEY_PROP_LIFE, life)

func remove_life(value:int):
	change_life(-value)
