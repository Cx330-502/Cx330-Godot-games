extends Area2D

var HitEffect=preload("res://Effects/HitEffect.tscn")
onready var timer=$Timer
var duration

export var hit_effect:bool=false 
var invincible:bool=false

func start_invincibility(duration0):
	self.invincible=true
	set_deferred("monitoring",false)
	timer.start(duration0)


func _on_Hurtboxes_area_entered(area):
	if hit_effect:
		var hiteffect=HitEffect.instance()
		get_parent().add_child(hiteffect)
		hiteffect.global_position=global_position
	pass # Replace with function body.


func _on_Timer_timeout():
	set_deferred("monitoring",true)
	self.invincible=false
