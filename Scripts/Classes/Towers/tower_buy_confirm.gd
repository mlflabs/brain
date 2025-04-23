extends Node3D
class_name Confirm_Build


@onready var emoji = $Emoji
@onready var area_3d = $Area3D


@export var state:Utils.ConfirmStates = Utils.ConfirmStates.No

@export var action_callback:Callable

func _ready():
	area_3d.action_callback = action_callback

func set_confirm(yes:bool):
	if yes:
		emoji.change_state(Utils.EmojiStates.Star)
	else:
		emoji.change_state(Utils.EmojiStates.Cross)
	self.visible = true
	
