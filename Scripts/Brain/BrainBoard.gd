#@icon("icons/blackboard.svg")
extends Node
class_name BrainBoard


const DEFAULT = "default"

var target
var root


## The blackboard is an object that can be used to store and access data between
## multiple nodes of the behavior tree.
@export var blackboard: Dictionary = {}:
	set(b):
		blackboard = b
		_data[DEFAULT] = blackboard


var _data:Dictionary = {}


func _ready():
	_data[DEFAULT] = blackboard


func keys() -> Array[String]:
	var k: Array[String]
	k.assign(_data.keys().duplicate())
	return k

func set_value(key: Variant, value: Variant, blackboard_name: String = DEFAULT) -> void:
	if not _data.has(blackboard_name):
		_data[blackboard_name] = {}

	_data[blackboard_name][key] = value


func get_value(key: Variant, default_value: Variant = null, blackboard_name: String = DEFAULT) -> Variant:
	if has_value(key, blackboard_name):
		return _data[blackboard_name].get(key, default_value)
	return default_value


func has_value(key: Variant, blackboard_name: String = DEFAULT) -> bool:
	return _data.has(blackboard_name) and _data[blackboard_name].has(key) and _data[blackboard_name][key] != null


func erase_value(key: Variant, blackboard_name: String = DEFAULT) -> void:
	if _data.has(blackboard_name):
		_data[blackboard_name][key] = null
