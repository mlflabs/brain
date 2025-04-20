extends Npc
class_name NpcWPCreeper

@export var waypoint:WayPoint
@export var effect:Effect
 
func damage(value:int):
	npc_stats.change_life(-value)
	effect.start()
