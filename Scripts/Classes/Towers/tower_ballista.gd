extends StaticBody3D
class_name  TowerBase


@export var scanner_area3d: Area3D
@export var data: TowerStage
@export var bb: BrainBoard

var targets: Array[NpcEnemy] = []

func _ready() -> void:
	scanner_area3d.body_entered.connect(on_entered)
	scanner_area3d.body_exited.connect(on_exited)

	bb.blackboard.set(PropertyManager.KEY_PROP_ROTATION_SPEED, data.rotation_speed)
	bb.root = $top

func on_entered(body):
	if body is NpcEnemy:
		targets.append(body)

func on_exited(body):
	if body is NpcEnemy:
		targets.erase(body)

func cleanup():
	for t in targets:
		if !is_instance_valid(t):
			targets.erase(t)
