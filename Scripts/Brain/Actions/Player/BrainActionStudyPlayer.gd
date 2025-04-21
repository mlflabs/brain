extends BrainAction
class_name BrainActionStudyPlayer


@export var bb:BrainBoardNpc
@export var player_action_key:String = "player_action"
@export var player_action_time_key:String = "player_action_time"
enum state {Start, Finished}
var current_state:state


func on_enter():
	PlayerManager.player_action_added.connect(on_player_action)

func on_exit():
	PlayerManager.player_action_added.disconnect(on_player_action)

func tick(_delta:float):
	pass

func on_player_action(action:Utils.ActionStates):
	bb.set_value(player_action_key, action)
	bb.set_value(player_action_time_key, Time.get_ticks_msec())
