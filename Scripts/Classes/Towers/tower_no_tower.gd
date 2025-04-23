extends Node3D
class_name TowerNoTower


@onready var selections = $Active/Selections
@onready var confirm: Confirm_Build = $Active/Confirm



var selection:BuildTowerSelection

func _ready():
	confirm.action_callback = Callable(self, "confirm_build")
	if selections.manager == null:
		selections.manager = self

	if selection == null:
		confirm.visible = false
	
	

func confirm_build():
	print("ddddddddddddddddddddd")

func set_selection(s: BuildTowerSelection):
	selection = s
	
	#can we buy it
	var can_buy:bool = true
	if ResourceManager.gold < selection.tower.tower_stages[0].cost_gold:
		can_buy = false

	if ResourceManager.wood < selection.tower.tower_stages[0].cost_wood:
		can_buy = false
		
		
