extends Npc
class_name NpcWPCreeper

@export var waypoint:WayPoint
@export var BA:BrainAgent
@export var BB:BrainBoard
 
var parent

var target

var on_destroy_callback


func focus(t):
	target = t
	BA.interupt()
	BB.blackboard.set("target", t)
	


func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		on_destroy_callback.call(self)
