extends BrainAction
class_name BrainActionTowerFireAtTarget

@export var tower:TowerBase
@export var bb:BrainBoard
@export var reload_wait_time:float = 0.3
@export var finish_time:float = 0.5
#where does the bullet start
@export var bullet_offset:Vector3

var _time:float = 0

func on_enter():
	print("Fire Setup::::;")
	
	_time = 0
	tower.start()
	#bullet.start(bb.target)

func tick(_delta:float):
	_time += _delta
	
	if _time > reload_wait_time:
		tower.bullet.visible = true
		if _time > finish_time:
			return parent.on_result(true)
	
