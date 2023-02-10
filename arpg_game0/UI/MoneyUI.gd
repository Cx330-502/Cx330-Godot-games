extends Control
onready var label=$Label
var money:int=0

func set_money(value):
	money+=value
	label.set_deferred("text",str(money))
