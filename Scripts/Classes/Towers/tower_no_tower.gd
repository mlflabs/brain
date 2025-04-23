extends Node3D
class_name TowerNoTower


@onready var confirm = $Active/Confirm
@onready var selections = $Active/Selections



var selection:BuildTowerSelection

func _ready():
	if selections.manager == null:
		selections.manager = self

	if selection == null:
		confirm.visible = false

func set_selection(s: BuildTowerSelection):
	selection = s
	
	#can we buy it
	var can_buy:bool = true
	if ResourceManager.gold < selection.tower.tower_stages[0].cost_gold:
		can_buy = false

	if ResourceManager.wood < selection.tower.tower_stages[0].cost_wood:
		can_buy = false
		
		
