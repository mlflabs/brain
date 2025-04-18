extends BrainBase
class_name BrainAgent

var considerations : Array[BrainConsideration] = []
var current_consideration: BrainConsideration

enum { START, THINKING, DECIDING, RUNNING, ERROR }

var state = THINKING



var largest_score:float = -1
var largest_index:int = -1
var current_index:int = 0

func _ready():
	for i in get_children():
		if i is BrainConsideration:
			considerations.append(i)
			i.parent = self
	
	if considerations.is_empty():
		printerr("No considerations found")

func _physics_process(delta):
	if state == RUNNING:
		current_consideration.tick_physics(delta)

func _process(delta):
	match state:
		RUNNING:
			current_consideration.tick(delta)
			return
			
		THINKING:
			if considerations.is_empty():
				printerr("No Considerations found....")
				return
			if current_index == considerations.size():
				state = DECIDING
				current_index = 0
				return
			
			var score = considerations[current_index].get_score()
			if score > largest_score:
				largest_score = score
				largest_index = current_index
			current_index += 1
			return
			
		DECIDING:
			current_consideration = considerations[largest_index]
			current_consideration.on_enter()
			print("Chosen: ", current_consideration.brain_name, ", with score:", largest_score)
			state = RUNNING
			return
		START:
			largest_index = 0
			largest_score = 0
			state= THINKING
			current_consideration.on_exit()
		ERROR:
			state = START
			
		

func on_result(result:bool):
	if result:
		state = START
	else:
		state = ERROR
	
func interupt():
	on_result(false)

		
