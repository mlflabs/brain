extends BrainAction
class_name BrainActionEmoji


@export var emoji:Emoji
@export var state: Utils.EmojiStates

func on_enter():
	emoji.change_state(state)

func tick(_delta:float):
	parent.on_result(true)
