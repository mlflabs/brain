extends TowerBase
class_name  TowerWorker


#@export var scanner_area3d: Area3D
#@export var data: TowerStage
#@export var bb: BrainBoard
#@export var bullet:Node3D
#@export var ap: AnimationPlayer
#
#var targets: Array[NpcEnemy] = []
#
#var bullet2:Node3D
@export var workers: Array[NpcSmart] = []
@export var travel_distance: float = 5


var trees: Array[StaticInteractableTree]

func _ready() -> void:
	scanner_area3d.body_entered.connect(on_entered)
	scanner_area3d.body_exited.connect(on_exited)

func on_entered(body):
	if body is NpcEnemy:
		targets.append(body)
		update_npcs()

func on_exited(body):
	if body is NpcEnemy:
		targets.erase(body)
		update_npcs()
		
func update_npcs():
	if targets.is_empty():
		set_worker_targers(null)
		
	while true:
		if targets.is_empty():
			set_worker_targers(null)
			return
		if is_instance_valid(targets[0]):
			set_worker_targers(targets[0])
			return
		else:
			targets.remove_at(0)

func set_worker_targers(target):
	for w in workers:
		w.BB.target = target

func set_worker_resource():
	print("setting resources................")
	var r = bb.get_value("resource", null)
	for w in workers:
		w.BB.set_value("resource", r)	

func cleanup():
	for t in targets:
		if !is_instance_valid(t):
			targets.erase(t)

func start():
	print("Worker Start")
