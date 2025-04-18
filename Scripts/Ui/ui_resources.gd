extends Control


@onready var lbl_gold = $HBoxContainer/VBoxContainer2/value_gold
@onready var lbl_wood = $HBoxContainer/VBoxContainer2/value_wood



func _ready():
	ResourceManager.signal_gold_changed.connect(on_gold_changed)
	ResourceManager.signal_wood_changed.connect(on_wood_changed)

func on_gold_changed(value:int):
	lbl_gold.text = str(value)

func on_wood_changed(value:int):
	lbl_wood.text = str(value)
