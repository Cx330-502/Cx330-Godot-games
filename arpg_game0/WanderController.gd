extends Node2D

export var wander_range:int=32

onready var start_position=global_position
onready var target_position=global_position

func update_target_position():
	var target_vector=Vector2(rand_range(-wander_range,wander_range),rand_range(-wander_range,wander_range))
	target_position=start_position+target_vector


func timer_lefttime():
	return $Timer.time_left


func start_timer(duration):
	$Timer.start(duration)

func _on_Timer_timeout():
	update_target_position()
