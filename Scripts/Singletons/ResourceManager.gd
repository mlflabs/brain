extends Node


var gold:int = 0
var wood:int = 0


#signals
signal signal_wood_changed(value:int)
signal signal_gold_changed(value:int)





func change_gold(value:int):
	gold += value
	set_wood(gold)

func set_gold(value:int):
	gold = value
	signal_gold_changed.emit(value)
	

func change_wood(value:int):
	wood += value
	set_wood(wood)

func set_wood(value:int):
	wood = value
	signal_wood_changed.emit(value)
	
	
	
