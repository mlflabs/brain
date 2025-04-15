extends BrainAction
class_name BrainActionGetNextWP

@export var npc:NpcWPCreeper
@export var bb:BrainBoardNpc


func on_enter():
	if npc.waypoint:
		if npc.global_position.distance_to(npc.waypoint.position) < PropertyManager.distance_reach_buffer:
			#get next wp
			if npc.waypoint.end_wp:
				npc.queue_free()
			else:
				npc.waypoint = npc.waypoint.next_wp
				bb.nav_agent.set_target_position(npc.waypoint.position)
		else:
			bb.nav_agent.set_target_position(npc.waypoint.position)
	else:
		printerr("No waypoint specified")
	
	parent.on_result(true)
