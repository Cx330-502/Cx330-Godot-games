extends Node

export var max_health:int=1 
export var drop_money:int=0
export var max_shield:int=0 
onready var health:int=max_health setget set_health
onready var shield:int=max_shield
signal no_health

func set_health(value):
	health=value
	if health<=0:
		emit_signal("no_health")

